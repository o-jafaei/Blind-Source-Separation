clc
clear all

C = [4 -1; -1 2]; 

k1 = 20;
k2 = 200;
k3 = 2000;

mean = [0 0]; 
samples_1 = mvnrnd(mean, C, k1);
samples_2 = mvnrnd(mean, C, k2);
samples_3 = mvnrnd(mean, C, k3);

sample_covariance_1 = custom_cov(samples_1);  % The sample covariance matrix is calculated using custom_cov() function
sample_covariance_2 = custom_cov(samples_2);  % defined at the end of
sample_covariance_3 = custom_cov(samples_3);  % the m-file.

disp("Theoretical Covariance Matrix:");
disp(C);

disp("Sample Covariance Matrix (K1):");
disp(sample_covariance_1);

disp("Sample Covariance Matrix (K2):");
disp(sample_covariance_2);

disp("Sample Covariance Matrix (K3):");
disp(sample_covariance_3);

function covariance_matrix = custom_cov(samples)
    [num_samples, num_dimensions] = size(samples);
    sample_means = mean(samples);
    covariance_matrix = zeros(num_dimensions);

    for i = 1:num_dimensions
        for j = i:num_dimensions 
            covariance_matrix(i, j) = sum((samples(:, i) - sample_means(i)) .* (samples(:, j) - sample_means(j))) / (num_samples - 1);
            covariance_matrix(j, i) = covariance_matrix(i, j); 
        end
    end
end