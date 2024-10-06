function snr = SNR(s1, s2, Y)
alpha11 = (Y(:,1)' * s1)/(s1' * s1);
alpha12 = (Y(:,1)' * s2)/(s2' * s2);
alpha21 = (Y(:,2)' * s1)/(s1' * s1);
alpha22 = (Y(:,2)' * s2)/(s2' * s2);
SNR11 = max(10 * log10 (mean(s1.^2) /  mean( (s1-Y(:,1)/alpha11).^2 ) ), 10 * log10 (mean(s1.^2) /  mean( (s1+Y(:,1)/alpha11).^2 ) ));
SNR12 = max(10 * log10 (mean(s2.^2) /  mean( (s2-Y(:,1)/alpha12).^2 ) ), 10 * log10 (mean(s2.^2) /  mean( (s2+Y(:,1)/alpha12).^2 ) ));
SNR21 = max(10 * log10 (mean(s1.^2) /  mean( (s1-Y(:,2)/alpha21).^2 ) ), 10 * log10 (mean(s1.^2) /  mean( (s1+Y(:,2)/alpha21).^2 ) ));
SNR22 = max(10 * log10 (mean(s2.^2) /  mean( (s2-Y(:,2)/alpha22).^2 ) ), 10 * log10 (mean(s2.^2) /  mean( (s2+Y(:,2)/alpha22).^2 ) ));

snr = [SNR11, SNR12; SNR21, SNR22];
end