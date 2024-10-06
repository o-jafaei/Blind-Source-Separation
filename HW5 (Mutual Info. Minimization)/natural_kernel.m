function [Y, B] = natural_kernel(X, mu)
B = eye(2);
max_length = length(X(1,:));
new_order = randperm(max_length);
for i=1:20
    Yn = transpose(X(:,new_order)) * B;
    Y = Yn(2:end, :);
    si = kernel_si(Y);
    C = (si' * Y)./max_length;
    D = C  - diag(diag(C)) + diag(diag(-1+(Y'*Y)./max_length)); 
    B = (eye(2) - mu.*D)*B;
    
end


end