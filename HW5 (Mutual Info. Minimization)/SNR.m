function snr = SNR(s1, s2, Y)
    SNR11 = 10 * log10 (mean(s1.^2) /  mean( (s1-Y(:,1)).^2 ) );
    SNR12 = 10 * log10 (mean(s2.^2) /  mean( (s2-Y(:,1)).^2 ) );
    SNR21 = 10 * log10 (mean(s1.^2) /  mean( (s1-Y(:,2)).^2 ) );
    SNR22 = 10 * log10 (mean(s2.^2) /  mean( (s2-Y(:,2)).^2 ) );
    snr = [SNR11, SNR12; SNR21, SNR22];
end