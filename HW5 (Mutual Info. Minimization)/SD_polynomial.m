function [Y, B] = SD_polynomial(X)
    mu = 0.16;
    B = eye(2);
    max_length = length(X(1,:));
    new_order = randperm(max_length);
    for i=1:20
        Y = transpose(X(:, new_order)) * B;
        si = poly_si(Y);
        C = (si' * X')./max_length;
        D = C - (inv(B))'; 
        B = B - mu*D;
        B(1,:)=B(1,:)/sqrt(B(1,:) * B(1,:)');
        B(2,:)=B(2,:)/sqrt(B(2,:) * B(2,:)');
    end

    Y = X' * B;
end