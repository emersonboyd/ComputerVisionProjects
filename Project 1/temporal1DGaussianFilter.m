%{
TEMPORAL 1D GAUSSIAN FILTER
%}

function [thresholdGaussianFilteredList] = temporal1DGaussianFilter(imgList, tsigma, thresholds)
    imgListSize = size(imgList);
    numImages = imgListSize(3);
    gaussianFilteredList=zeros(size(imgList));
    filterLength = ceil(((tsigma * 5) + 1)/2)*2 - 1;
    
    startImage = ceil(filterLength/2);
    endImage = numImages - floor(filterLength/2);
    
    Gx = @(x) 1 / sqrt(2 * pi * (tsigma^2)) * exp(-1 * x^2 / (2 * (tsigma^2)));
     
    gaussianFilter = zeros(1, filterLength);
    for i = 1:filterLength
        x = i - ceil(filterLength/2);
        gaussianFilter(i) = Gx(x);
    end
    gaussianFilterSum = sum(gaussianFilter);
    
    for i = startImage:endImage
        gaussianFilteredFrame = zeros(imgListSize(1), imgListSize(2));
        for j = 1:filterLength
            currentFilterFrame = (i + j - (ceil(filterLength/2)));
            gaussianFilteredFrame = gaussianFilteredFrame + (gaussianFilter(j) * imgList(:,:,currentFilterFrame));
        end
        gaussianFilteredList(:,:,i) = gaussianFilteredFrame / gaussianFilterSum;
    end
    
    thresholdGaussianFilteredList = zeros(size(gaussianFilteredList));
    for i = 1:length(thresholds)
        thresholdGaussianFilteredList(gaussianFilteredList > thresholds(i, 1) & gaussianFilteredList < thresholds(i, 2)) = 255;
    end    
    
    figure
    histogram(gaussianFilteredList(:,:,:))
end