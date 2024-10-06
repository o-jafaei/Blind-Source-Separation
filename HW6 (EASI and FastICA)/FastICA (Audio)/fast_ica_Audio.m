clc
clear all
warning('off', 'all')
% Reading voice files
[s1, Fs1] = audioread('s1.mp3');
[s2, Fs2] = audioread('s2.mp3');
s1 = s1';
s2 = s2';
s1 = (s1 - mean(s1))';
s1 = s1 ./ sqrt(s1' *s1);

s2 = (s2 - mean(s2))';
s2 = s2 ./ sqrt(s2' * s2);
threshold = 1e-4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
[V,Z,Rz]=whitening(X);

[W, Y]=performing_ica(Z, threshold);

Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix1 = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%second mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
[V,Z,Rz]=whitening(X);

[W, Y]=performing_ica(Z, threshold);

Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix2 = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%third mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
[V,Z,Rz]=whitening(X);

[W, Y]=performing_ica(Z, threshold);

Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix3 = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fourth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
[V,Z,Rz]=whitening(X);

[W, Y]=performing_ica(Z, threshold);

Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix4 = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fifth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
A = [0.57,0.4;0.71,0.28];
S = [s1, s2];

X = A * S';
[V,Z,Rz]=whitening(X);

[W, Y]=performing_ica(Z, threshold);

Y = Y';
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y_b(:,1), 16000) if you want to listen to output signals,
% sound(10*Y_b(:,2), 16000) uncomment these lines.

snr_matrix5 = SNR(s1, s2, Y)
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('The ith row of the SNR matrix gives SNR of ith output with respect to all sources.')
disp('--------------------------------------------------------------------------------------')
disp('Comparison is in EASI_Audio.m file.')






