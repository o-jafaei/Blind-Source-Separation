clc
clear all

N = 10000000;
%%%%%%%%%%%%%%%%%%% Normal Distribution%%%%%%%%%%%%%%%%%%%
x1_n = randn(N, 1);
x2_n = x1_n.^2;
x3_n = x1_n.^3;
x4_n = x1_n.^4;

m1 = mean(x1_n);
m2 = mean(x2_n);
m3 = mean(x3_n);
m4 = mean(x4_n);

unnormalized_kurtosis_NormDist = m4 - 4*m1*m3 - 3*m2^2 + 12*(m1^2)*m2 -6*m1^4;   % unnormalized kurtosis

gamma2_NormDist = unnormalized_kurtosis_NormDist / ((m2-m1^2)^2);    % normalized kurtosis
%%%%%%%%%%%%%%%%%%% Uniform Distribution %%%%%%%%%%%%%%%%%%%
x1_u = rand(N, 1);
x2_u = x1_u.^2;
x3_u = x1_u.^3;
x4_u = x1_u.^4;

m1 = mean(x1_u);
m2 = mean(x2_u);
m3 = mean(x3_u);
m4 = mean(x4_u);

unnormalized_kurtosis_UniDist = m4 - 4*m1*m3 - 3*m2^2 + 12*(m1^2)*m2 -6*m1^4;   % unnormalized kurtosis

gamma2_UniDist = unnormalized_kurtosis_UniDist / (m2-m1^2)^2;    % normalized kurtosis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['Unnormalized Kurtosis of Normal Distribution:', num2str(unnormalized_kurtosis_NormDist)])
disp(['Normalized Kurtosis of Normal Distribution:', num2str(gamma2_NormDist)])
disp(' ')
disp('Both values are expected to be approximately zero.')
disp('---------------------------------------------------------------------------------- ')
disp(['Unnormalized Kurtosis of Uniform Distribution:', num2str(unnormalized_kurtosis_UniDist)])
disp(['Normalized Kurtosis of Uniform Distribution:', num2str(gamma2_UniDist)])
disp(' ')
disp('Unnormalized Kurtosis is expected to be around -1/120 or approximately -0.00833.')
disp('Normalized Kurtosis is exepected to be approximately -1.2.')
disp('They are negative because Uniform Distribution is a platykutotic Distribution.')