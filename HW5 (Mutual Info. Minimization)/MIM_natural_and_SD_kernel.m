clc
clear all

% Reading voice files
[s1, Fs1] = audioread('p232_002.wav');
[s2, Fs2] = audioread('p257_428.wav');

s1 = resample(s1, 4000, Fs1);
s2 = resample(s2, 4000, Fs2);

max_length = max(length(s1), length(s1));

% Zero-pad the shorter audio samples
s1 = [s1; zeros(max_length - length(s1), size(s1, 2))];
s2 = [s2; zeros(max_length - length(s2), size(s2, 2))];


s1 = s1 ./ sqrt(s1' *s1);
s1 = s1 - mean(s1);

s2 = s2 ./ sqrt(s2' * s2);
s2 = s2 - mean(s2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Natural  Gradient %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.04;
[Y, B] = natural_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix1_naturalG = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%second mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.04;
[Y, B] = natural_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix2_naturalG = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%third mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.03;
[Y, B] = natural_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix3_naturalG = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fourth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.03;
[Y, B] = natural_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix4_naturalG = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fifth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.022;
[Y, B] = natural_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix5_naturalG = SNR(s1, s2, Y)
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Normal   Gradient %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.04;
[Y, B] = SD_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix1_SD = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%second mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.04;
[Y, B] = SD_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix2_SD = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%third mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.03;
[Y, B] = SD_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix3_SD = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fourth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
A = [0.26,0.13;0.49,0.90];
%A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.03;
[Y, B] = SD_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix4_SD = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fifth mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A = [0.79,0.9;0.67,0.31];
%A = [0.44,0.33;0.28,0.43];
%A = [0.15,0.10;0.36,0.94];
%A = [0.26,0.13;0.49,0.90];
A = [0.27,0.5;0.82,0.33];
S = [s1, s2];

X = A * S';
mu = 0.022;
[Y, B] = SD_kernel(X, mu);

Y = X' * B;
Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));

% sound(10*Y(:,1), 4000)
% sound(10*Y(:,2), 4000)

snr_matrix5_SD = SNR(s1, s2, Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('The ith row of the SNR matrix gives SNR of ith output with respect to all sources.')
disp(' ')
disp('By comparing the SNR matrices of both cases, we can realize that quality and SNR of natural gradient outputs are better than normal SD gradient.')











