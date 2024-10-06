clc
clear all
close all

m = 100;
n = 82;
A = randi([-100,100],n,m);
D = normc(A);

M = max(max(abs(D'*D-eye(m))));
gribonval_band = (1+M^(-1))/2;

s = zeros(m,1);
t = randperm(m);

non_zero_elements = gribonval_band + 30;
s(t(1:floor(non_zero_elements))) = randi([0,100],[floor(non_zero_elements),1]);
b = A * s;

s_estim_simplex = BP(A,b,1);
s_estim_interior_point = BP(A,b,2);
clc;
disp('No Noise')
snr_simplex = 10*log10(sum(s.^2)/sum((s_estim_simplex-s).^2))
snr_interior_point = 10*log10(sum(s.^2)/sum((s_estim_interior_point-s).^2))
disp('--------------------------------------------------------------------')
figure('Name','Estimated Sparse (Simplex)','NumberTitle','off');
stem(s,'*');
hold on
stem(s_estim_simplex,'o');
grid on
legend('s', 's_e_s_t_i_m _s_i_m_p_l_e_x')
title('Estimated Sparse Vector (Simplex Method) Without Noise')

figure('Name','Estimated Sparse (Interior Point)','NumberTitle','off');
stem(s,'*');
hold on
stem(s_estim_interior_point,'o');
grid on
legend('s', 's_e_s_t_i_m _i_n_t_e_r_i_o_r _p_o_i_n_t')
title('Estimated Sparse Vector (Interior Point Method) Without Noise')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% s + noise %%%%%%%%%%%%%%%%%%%%%%%%%
s_noisy = s + 2*randn([m, 1]);
b = A * s_noisy;

noisy_s_estim_simplex = BP(A,b,1);
noisy_s_estim_interior_point = BP(A,b,2);

disp('Noisy Sparse Vector')
snr_simplex_noisy_s = 10*log10(sum(s_noisy.^2)/sum((noisy_s_estim_simplex-s_noisy).^2))
snr_interior_point_noisy_s = 10*log10(sum(s_noisy.^2)/sum((noisy_s_estim_interior_point-s_noisy).^2))
disp('--------------------------------------------------------------------')
figure('Name','Estimated Sparse (Simplex) Noisy Sparse Vector','NumberTitle','off');
stem(s_noisy,'*');
hold on
stem(noisy_s_estim_simplex,'o');
grid on
legend('s', 's_e_s_t_i_m _s_i_m_p_l_e_x')
title('Estimated Sparse Vector (Simplex Method) With Noisy Sparse Vector')

figure('Name','Estimated Sparse (Interior Point) Noisy Sparse Vector','NumberTitle','off');
stem(s_noisy,'*');
hold on
stem(noisy_s_estim_interior_point,'o');
grid on
legend('s', 's_e_s_t_i_m _i_n_t_e_r_i_o_r _p_o_i_n_t')
title('Estimated Sparse Vector (Interior Point Method) With Noisy Sparse Vector')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% As + noise %%%%%%%%%%%%%%%%%%%%%%%%%
b_noisy = A * s + 2*randn([n, 1]);

s_estim_simplex_b_noisy = BP(A,b_noisy,1);
s_estim_interior_point_b_noisy = BP(A,b_noisy,2);

disp('Noisy b')
snr_simplex_noisy_b = 10*log10(sum(s.^2)/sum((s_estim_simplex_b_noisy-s).^2))
snr_interior_point_noisy_b = 10*log10(sum(s.^2)/sum((s_estim_interior_point_b_noisy-s).^2))
disp('--------------------------------------------------------------------')
figure('Name','Estimated Sparse (Simplex) With Noisy b','NumberTitle','off');
stem(s,'*');
hold on
stem(s_estim_simplex_b_noisy,'o');
grid on
legend('s', 's_e_s_t_i_m _s_i_m_p_l_e_x')
title('Estimated Sparse Vector (Simplex Method) With Noisy b')

figure('Name','Estimated Sparse (Interior Point) With Noisy b','NumberTitle','off');
stem(s,'*');
hold on
stem(s_estim_interior_point_b_noisy,'o');
grid on
legend('s', 's_e_s_t_i_m _i_n_t_e_r_i_o_r _p_o_i_n_t')
title('Estimated Sparse Vector (Interior Point Method) With Noisy b')
disp('--------------------------------------------------------------')
disp('NOTE: Since the interior point method cannot estimate negative')
disp('elements of s, all elements of s are considered to be positive.')
disp('--------------------------------------------------------------')
disp('Robustness to Noise Comparison:')
disp('Adding noise to 𝑠 decreases the SNR more than adding noise to 𝑏.')
disp('In other words, the algorithm is more robust to noise in 𝑏 than in 𝑠.')











