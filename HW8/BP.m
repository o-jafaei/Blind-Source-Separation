function s_estim = BP(A, b, algorithm_type)

A_new = [A, -A]; 

if algorithm_type == 1
    options = optimoptions('linprog', 'Algorithm', 'dual-simplex');
else    
    options = optimoptions('linprog', 'Algorithm', 'interior-point');
end

m = size(A, 2);
f = ones(m*2, 1); 
lower_bound = zeros(m*2, 1);
x = linprog(f, [], [], A_new, b, lower_bound, [], options); 

for j = 1:m
    first_val = x(j);
    second_val = x(j + m);
    if first_val ~= 0
        s_estim(j) = first_val;
    elseif second_val ~= 0
        s_estim(j) = -second_val;
    else
        if abs(first_val) >= abs(second_val)
            s_estim(j) = first_val;
        elseif abs(second_val) > 1e-4
            s_estim(j) = -second_val;
        else
            s_estim(j) = first_val;
        end
    end
end
s_estim = s_estim';
end