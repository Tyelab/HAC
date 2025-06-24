function [zdata, mu, sigma]=special_Zscore(data, interval_start, interval_end)
% [zdata]=special_Zscore(data, interval_start, interval_end)
% this function takes in a matrix, data, and an index, given by
% interval_start:interval_end. it then computes the mean and std of
% data over interval_start:interval_end entries and uses this to
% standardize the data.
%
% Input
%   data           - matrix of values to be zscored
%   interval_start - integer, start of  interval to calculate mean,std
%   interval_end   - integer, end of interval to calculate mean,std
% Output
%   zdata
%
% Usage example
%     [~, M]=size(subject_data);
%     [zdata]=special_Zscore(subject_data, 1, floor(M/2))
%

[~,M]=size(data);
if M==1
    % special case for vector
    
    x = data( interval_start:interval_end);
    mu = mean(x);
    sigma = std(x,0);
    zdata = (data-mu)./(sigma);% subject data zscore
else
    x = data(:, interval_start:interval_end);
    mu1 = mean(x,2);
    sig1 =std(x,0,2);
    %disp([mu1 sig1]) % for debugging
    allZeros = (mu1 == 0 & sig1 == 0);
    sig1(allZeros) = 1;
% NOTE: If the mean/sigma value of x is identically 0, replace with mean of
% 0 and sigma of 1; otherwise, this introduces NAN and INF into the matrix.   

    mu = repmat(mu1,1,M);
    sigma = repmat(sig1,1,M);
    zdata = (data-mu)./(sigma);% subject data zscore
    % note, we add eps (the error point round off for floating numbers to avoid
    % a possible division by 0
    
end