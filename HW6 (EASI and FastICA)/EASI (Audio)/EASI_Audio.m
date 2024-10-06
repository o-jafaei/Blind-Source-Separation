clc
clear all
warning('off', 'all')
[s1, Fs1] = audioread('s1.mp3');
[s2, Fs2] = audioread('s2.mp3');
 
s1 = s1';
s2 = s2';

s1 = (s1 - mean(s1))';
s1 = s1 ./ sqrt(s1' *s1);

s2 = (s2 - mean(s2))';
s2 = s2 ./ sqrt(s2' * s2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
%A=rand(2,2);
S = [s1, s2];

X = A * S';
Y = zeros(size(X, 1), size(X, 2));
B1 = eye(2, 2);
lambda = 18e-5;

for i=1:size(X, 2)
    Y(:, i) = B1 * X(:, i);
    y = Y(:, i);
    g = (tanh(y.^4).^4 + exp(-0.5*y.^4));
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B1 = B1 - lambda * H * B1;
    
end
Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.
snr_matrix1_Adaptive = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))



Y_b = (B1*X)';
Y_b(:,1) = Y_b(:,1) ./ sqrt(Y_b(:,1)' *Y_b(:,1));
Y_b(:,2) = Y_b(:,2) ./ sqrt(Y_b(:,2)' *Y_b(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix1_Batch = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y_b(size(s1, 1)/4:end, :))
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%second mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
Y = zeros(size(X, 1), size(X, 2));
B2 = eye(2, 2);
lambda = 28e-5;

for i=1:size(X, 2)
    Y(:, i) = B2 * X(:, i);
    y = Y(:, i);
    g = (tanh(y).^2 + exp(-0.5*y));
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B2 = B2 - lambda * H * B2;
    
end
Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix2_Adaptive = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))



Y_b = (B2*X)';
Y_b(:,1) = Y_b(:,1) ./ sqrt(Y_b(:,1)' *Y_b(:,1));
Y_b(:,2) = Y_b(:,2) ./ sqrt(Y_b(:,2)' *Y_b(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix2_Batch = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y_b(size(s1, 1)/4:end, :))
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%third mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
Y = zeros(size(X, 1), size(X, 2));
B3 = eye(2, 2);
lambda = 25e-5;

for i=1:size(X, 2)
    Y(:, i) = B3 * X(:, i);
    y = Y(:, i);
    g = (tanh(y).^2 + exp(-0.5*y));
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B3 = B3 - lambda * H * B3;
    
end
Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix3_Adaptive = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))



Y_b = (B3*X)';
Y_b(:,1) = Y_b(:,1) ./ sqrt(Y_b(:,1)' *Y_b(:,1));
Y_b(:,2) = Y_b(:,2) ./ sqrt(Y_b(:,2)' *Y_b(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix3_Batch = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y_b(size(s1, 1)/4:end, :))
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fourth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
Y = zeros(size(X, 1), size(X, 2));
B4 = eye(2, 2);
lambda = 23e-5;

for i=1:size(X, 2)
    Y(:, i) = B4 * X(:, i);
    y = Y(:, i);
    g = (tanh(y).^2 + exp(-0.5*y));
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B4 = B4 - lambda * H * B4;
    
end
Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix4_Adaptive = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))



Y_b = (B4*X)';
Y_b(:,1) = Y_b(:,1) ./ sqrt(Y_b(:,1)' *Y_b(:,1));
Y_b(:,2) = Y_b(:,2) ./ sqrt(Y_b(:,2)' *Y_b(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix4_Batch = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y_b(size(s1, 1)/4:end, :))
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fifth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
Y = zeros(size(X, 1), size(X, 2));
B5 = eye(2, 2);
lambda = 25e-5;

for i=1:size(X, 2)
    Y(:, i) = B5 * X(:, i);
    y = Y(:, i);
    g = (tanh(y).^2 + exp(-0.5*y));
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B5 = B5 - lambda * H * B5;
    
end
Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix5_Adaptive = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))



Y_b = (B5*X)';
Y_b(:,1) = Y_b(:,1) ./ sqrt(Y_b(:,1)' *Y_b(:,1));
Y_b(:,2) = Y_b(:,2) ./ sqrt(Y_b(:,2)' *Y_b(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix5_Batch = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y_b(size(s1, 1)/4:end, :))
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('The ith row of the SNR matrix gives SNR of ith output with respect to all sources.')
disp('------------------------------------------------------------------------------------')
disp('As expected, the EASI algorithm (adaptive mode) works faster then FastICA.') 
disp('But the SNR of seperated sources of adaptive mode EASI is lower then FactICA results.')
disp('So FactICA results better SNRs but can not be used in adaptive applications.')
disp('If we use batch mode EASI, the results will be almost the same as FastICA. FastICA might be a little better.')





