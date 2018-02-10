%{
TEMPORAL SIMPLE FILTER
%}

function [thresholdDerivativeList] = temporalSimpleFilter(imgList, threshold)
    numImages = size(imgList);
    numImages = numImages(3) - 1;
    derivativeList=zeros(size(imgList));
    for i = 2:numImages
        derivativeList(:, :, i) = (imgList(:, :, i+1) - imgList(:, :, i-1)) / 2;
    end

    absDerivativeList = abs(derivativeList);
    thresholdDerivativeList = zeros(size(absDerivativeList));
    thresholdDerivativeList(absDerivativeList > threshold) = 1;
end

