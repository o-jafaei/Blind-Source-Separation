clc
clear all
x0=[3 4];  
x=[];
mu=0.0007; %If we set mu a lower value, the convergence time increases but results would be better.
syms x1 x2
f=100*(x2-x1^2)^2 + (1-x1)^2;
fx=inline(f);
f_obj= @(x) fx(x(:,1),x(:,2)); 
%%%%%%%%%%%%%%%%%%%%%%Calculation of gradient(f)
G=gradient(f);
g=inline(G);
gradientx=@(x) g(x(:,1),x(:,2));
%%%%%%%%%%%%%%%%%%%%%%Algorithm Implementation
p=1e-3;
i=0;
while norm(gradientx(x0))>p
    x=[x;x0];
    x_new=x0-mu.*gradientx(x0)';
    x0=x_new;
    i=i+1;
end

figure;
plot(x(:,1))
hold on
plot(x(:,2))
grid on
xlabel('Iterations');
ylabel('Optimal Argument Value')
title('Convergence of x (Steepest Descent)')
legend('x_1','x_2')
