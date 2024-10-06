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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first mixing matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];

S = [s1, s2];

X = A * S';
B1 = eye(2, 2);

lambda = 12e-3;

for i=1:size(X, 2)
    Y(:, i) = B1(:,:,i) * X(:, i);
    y = Y(:, i);
    g = -(tanh(y) + 0.0001*exp(-0.5*y)).^3;
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B1(:,:,i+1) = B1(:,:,i) - lambda * H * B1(:,:,i);
    clear g H;
end
clear Y;
Y = B1(:,:,end)*X;
Y = Y';

Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix1 = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))

if snr_matrix1(1, 1) > snr_matrix1(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','First Mixing Matrix (EASI)','NumberTitle','off');
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
clear Y;
%A = [0.61,0.54;0.58,0.87];
A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];

S = [s1, s2];

X = A * S';
B2 = eye(2, 2);

lambda = 118e-4;

for i=1:size(X, 2)
    Y(:, i) = B2(:,:,i) * X(:, i);
    y = Y(:, i);
    g = -(tanh(y) + 0.0001*exp(-0.5*y)).^3;
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B2(:,:,i+1) = B2(:,:,i) - lambda * H * B2(:,:,i);
    clear g H;
end
clear Y;
Y = B2(:,:,end)*X;
Y = Y';

Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix2 = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))

if snr_matrix2(1, 1) > snr_matrix2(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Second Mixing Matrix (EASI)','NumberTitle','off');
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
clear Y;
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];

S = [s1, s2];

X = A * S';
B3 = eye(2, 2);

lambda = 115e-4;

for i=1:size(X, 2)
    Y(:, i) = B3(:,:,i) * X(:, i);
    y = Y(:, i);
    g = -(tanh(y) + 0.0001*exp(-0.5*y)).^3;
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B3(:,:,i+1) = B3(:,:,i) - lambda * H * B3(:,:,i);
    clear g H;
end
clear Y;
Y = B3(:,:,end)*X;
Y = Y';

Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix3 = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))

if snr_matrix3(1, 1) > snr_matrix3(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Third Mixing Matrix (EASI)','NumberTitle','off');
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
clear Y;
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
A = [0.26,0.13;0.49,0.90];
%A = [0.57,0.4;0.71,0.28];

S = [s1, s2];

X = A * S';
B4 = eye(2, 2);

lambda = 11e-3;

for i=1:size(X, 2)
    Y(:, i) = B4(:,:,i) * X(:, i);
    y = Y(:, i);
    g = -(tanh(y) + 0.0001*exp(-0.5*y)).^3;
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B4(:,:,i+1) = B4(:,:,i) - lambda * H * B4(:,:,i);
    clear g H;
end
clear Y;
Y = B4(:,:,end)*X;
Y = Y';

Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix4 = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))

if snr_matrix4(1, 1) > snr_matrix4(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Fourth Mixing Matrix (EASI)','NumberTitle','off');
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
clear Y;
%A = [0.61,0.54;0.58,0.87];
%A = [0.99,0.97;0.95,0.989];
%A = [0.65,0.64;0.48,0.54];
%A = [0.26,0.13;0.49,0.90];
A = [0.57,0.4;0.71,0.28];

S = [s1, s2];

X = A * S';
B5 = eye(2, 2);

lambda = 12e-3;

for i=1:size(X, 2)
    Y(:, i) = B5(:,:,i) * X(:, i);
    y = Y(:, i);
    g = -(tanh(y) + 0.0001*exp(-0.5*y)).^3;
    H = ( ((y*y' - eye(2))/(1 + lambda*(y')*y)) + ((g*y' - y*g')/(1 + lambda*abs((y')*g))) );
    B5(:,:,i+1) = B5(:,:,i) - lambda * H * B5(:,:,i);
    clear g H;
end
clear Y;
Y = B5(:,:,end)*X;
Y = Y';

Y(:,1) = Y(:,1) ./ sqrt(Y(:,1)' *Y(:,1));
Y(:,2) = Y(:,2) ./ sqrt(Y(:,2)' *Y(:,2));


snr_matrix5 = SNR(s1(size(s1, 1)/4:end, :), s2(size(s1, 1)/4:end, :), Y(size(s1, 1)/4:end, :))

if snr_matrix5(1, 1) > snr_matrix5(1, 2)
    img1 = Y(:,1) * im1_flatten_E + im1_flatten_mean;
    img2 = Y(:,2) * im2_flatten_E + im2_flatten_mean;
else
    img1 = Y(:,1) * im2_flatten_E + im2_flatten_mean;
    img2 = Y(:,2) * im1_flatten_E + im1_flatten_mean;
end

img1_recovered = reshape(img1,size1(1),size1(2));
img2_recovered = reshape(img2,size2(1),size2(2));

figure('Name','Fifth Mixing Matrix (EASI)','NumberTitle','off');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('The ith row of the SNR matrix gives SNR of ith output with respect to all sources.')
disp('--------------------------------------------------------------------------------------')
disp('In adaptive applications, we can use only EASI algorithm. And also whenever source signals have a long length')
disp('(like high resolution images) FastICA may not work due to large amount of computations. So we have to use EASI instead.')
disp('Since MIM (Mutual Info. Min.) algorithm is not adaptive, it is not suitable fo image signals.')