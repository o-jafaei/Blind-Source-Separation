function si_hat = kernel_si(Y)
         
         y1 = Y(:,1);
         y2 = Y(:,2);
         
         [f1,xi1] = ksdensity(y1,'NumPoints',length(y1));
         [f2,xi2] = ksdensity(y2,'NumPoints',length(y2));
         f1 = f1';
         f2 = f2';
         xi1 = xi1';
         xi2 = xi2';
         df1 = diff(f1) ./ diff(xi1);
         df2 = diff(f2) ./ diff(xi2);
         
         si_hat_ = [-df1 ./ f1(2:end) , -df2 ./ f2(2:end)];
         si_hat = zeros(length(y1), 2);
         si_hat(:,1)=interp1(xi1(2:end),si_hat_(:,1),y1);
         si_hat(:,2)=interp1(xi2(2:end),si_hat_(:,2),y2);
end