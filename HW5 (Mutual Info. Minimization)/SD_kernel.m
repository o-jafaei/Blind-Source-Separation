function [Y, B] = SD_kernel(X, mu)
B = eye(2);
max_length = length(X(1,:));
new_order = randperm(max_length);
for i=1:20
    Yn = transpose(X(:,new_order)) * B;
    Y = Yn(2:end, :);
    si = kernel_si(Y);
    C = (si' * transpose(X(:, 2:end)))./max_length;
    D = C - (inv(B))'; 
    B = B - mu*D;
    B(1,:)=B(1,:)/sqrt(B(1,:) * B(1,:)');
    B(2,:)=B(2,:)/sqrt(B(2,:) * B(2,:)');
    
end


end