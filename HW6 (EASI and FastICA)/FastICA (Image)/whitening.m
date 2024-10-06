function [Rz,Z,V]=whitening(X)   
        Rx=cov(X');
        [Q,lambdas] = eig(Rx);

        V=(lambdas^(-0.5))*(Q');
        
        Z=V*X;
        Rz=cov(Z');
end