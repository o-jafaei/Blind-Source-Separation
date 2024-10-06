function si_hat = poly_si(Y)
%     K_K1 = zeros(4,4);
%     K_K2 = zeros(4,4);
%     Kprime1 = zeros(4,1);
%     Kprime2 = zeros(4,1);
%  
%     for i=1:length(Y(:,1))
%         K1 = [ 1;
%             Y(i,1);
%             Y(i,1)^2;
%             Y(i,1)^3];
%         K_K1 = K_K1 + K1*K1';
%         
%         K2 = [ 1;
%             Y(i,2);
%             Y(i,2)^2;
%             Y(i,2)^3];
%         K_K2 = K_K2 + K2*K2';
%         
%         Kprime1 = Kprime1 +    [0;
%                                 1;
%                                 2*Y(i,1);
%                                 3*Y(i,1)^2]; 
%         Kprime2 = Kprime2 +    [0;
%                                 1;
%                                 2*Y(i,2);
%                                 3*Y(i,2)^2];        
%     end
% 
%     theta1 = ( inv(K_K1./length(Y(:,1))) ) * (Kprime1./length(Y(:,1)));
%     theta2 = ( inv(K_K2./length(Y(:,2))) ) * (Kprime2./length(Y(:,2)));
%     theta = [theta1, theta1];
%     theta = theta';
%     for j=1:length(Y(:,1))
%         si_hat(j,1) = theta(1,:) * [ 1;
%                                     Y(j,1);
%                                     Y(j,1)^2;
%                                     Y(j,1)^3];
%                             
%          si_hat(j,2) = theta(2,:) * [ 1;
%                                     Y(j,2);
%                                     Y(j,2)^2;
%                                     Y(j,2)^3];                    
%         
%     end
    m2 = sum(Y.^2, 1)/length(Y(:,1));
    m4 = sum(Y.^4, 1)/length(Y(:,1));
    m6 = sum(Y.^6, 1)/length(Y(:,1));
    
    theta1 = (m6 - 3*m2.*m4)./(m2.*m6 - m4.^2);
    theta3 = (3*m2.^2 - m4)./(m2.*m6 - m4.^2);
    
    
    si_hat = theta1.*Y + theta3.*(Y.^3);


end