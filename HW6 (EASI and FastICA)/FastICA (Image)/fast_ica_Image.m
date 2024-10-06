clc
clear all
warning('off', 'all')

im1 = imread('s1.jpg');
im2 = imread('s2.jpg');


size1 = size(im1);
size2 = size(im2);

im1_flatten = reshape(double(im1), size(im1, 1)*size(im1, 2), 1);
im2_flatten = reshape(double(im2), size(im2, 1)*size(im2, 2), 1);

im1_flatten_mean = mean(im1_flatten);
im1_flatten_E = sqrt(im1_flatten' * im1_flatten);

im2_flatten_mean = mean(im2_flatten);
im2_flatten_E = sqrt(im2_flatten' * im2_flatten);


s1 = im1_flatten - im1_flatten_mean;
s1 = s1 ./ im1_flatten_E;

s2 = im2_flatten - im2_flatten_mean;
s2 = s2 ./ im2_flatten_E;
threshold = 1e-6;
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


snr_matrix1 = SNR(s1, s2, Y)
if snr_matrix1(1, 1) > snr_matrix1(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','First Mixing Matrix (FastICA)','NumberTitle','off');
title('First Source')
subplot(2,2,1);
imshow(im1);
title('First Source')

subplot(2,2,2);
imshow(im2);
title('Second Source')


subplot(2,2,3);
imshow(uint8(img1_recovered));
title('First Output')


subplot(2,2,4);
imshow(uint8(img2_recovered));
title('Second Output')
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
Y(:,1) = -Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = -Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix2 = SNR(s1, s2, Y)

if snr_matrix2(1, 1) > snr_matrix2(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Second Mixing Matrix (FastICA)','NumberTitle','off');
title('First Source')
subplot(2,2,1);
imshow(im1);
title('First Source')

subplot(2,2,2);
imshow(im2);
title('Second Source')

subplot(2,2,3);
imshow(uint8(img1_recovered));
title('First Output')


subplot(2,2,4);
imshow(uint8(img2_recovered));
title('Second Output')
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
Y(:,1) = -Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = -Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix3 = SNR(s1, s2, Y)

if snr_matrix3(1, 1) > snr_matrix3(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Third Mixing Matrix (FastICA)','NumberTitle','off');
title('First Source')
subplot(2,2,1);
imshow(im1);
title('First Source')

subplot(2,2,2);
imshow(im2);
title('Second Source')

subplot(2,2,3);
imshow(uint8(img1_recovered));
title('First Output')


subplot(2,2,4);
imshow(uint8(img2_recovered));
title('Second Output')
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
Y(:,1) = -Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix4 = SNR(s1, s2, Y)

if snr_matrix4(1, 1) > snr_matrix4(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Fourth Mixing Matrix (FastICA)','NumberTitle','off');
title('First Source')
subplot(2,2,1);
imshow(im1);
title('First Source')

subplot(2,2,2);
imshow(im2);
title('Second Source')

subplot(2,2,3);
imshow(uint8(img1_recovered));
title('First Output')


subplot(2,2,4);
imshow(uint8(img2_recovered));
title('Second Output')
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
Y(:,1) = -Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix5 = SNR(s1, s2, Y)

if snr_matrix5(1, 1) > snr_matrix5(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Fifth Mixing Matrix (FastICA)','NumberTitle','off');
title('First Source')
subplot(2,2,1);
imshow(im1);
title('First Source')

subplot(2,2,2);
imshow(im2);
title('Second Source')

subplot(2,2,3);
imshow(uint8(img1_recovered));
title('First Output')


subplot(2,2,4);
imshow(uint8(img2_recovered));
title('Second Output')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('The ith row of the SNR matrix gives SNR of ith output with respect to all sources.')
disp('--------------------------------------------------------------------------------------')
disp('Comparison is in EASI_Image.m file.')






