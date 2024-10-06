function [W, Y]=performing_ica(Z, threshold)   
m = 2;
W = eye(m, m);
e=100;
n = size(Z, 2);
for p=1:m
    w(1,:) = W(p, :);
    A = W(1:p-1, :)';
    i=1;
    while abs(e)>threshold;
        x1=0;
        x2=0;
        for k=1:n
            x1 = x1 + ( Z(:, k)*g_function(w(i,:) * Z(:, k)) )';
            x2 = x2 + gprime_function(w(i,:) * Z(:, k));
        end
        w(i+1,:) = (1/n)*(x1 - x2*w(i,:));
        if p>1
            temp = w(i+1,:)' - (A*A')*w(i+1,:)';
            w(i+1,:) = temp';
        end
        w(i+1,:) = w(i+1,:) / sqrt(w(i+1,:)*w(i+1,:)');
        
        e = abs(w(i+1,:)*w(i,:)')-1; 
   
        i = i + 1;
    end
    W(p, :) = w(end, :);
    w=[];
    e = 100;
end
  
 Y = W*Z;   
end