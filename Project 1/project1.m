%{
PROJECT 1 MAIN CODE
%}

clc
clear all
close all
`
imageType = 1;

if (imageType == 1)
    firstImageNumber = 0;
    lastImageNumber = 484;
    imageFolder = 'EnterExitCrossingPaths2cor';
    imagePrefix = 'EnterExitCrossingPaths2cor';
elseif (imageType == 2)
    firstImageNumber = 1;
    lastImageNumber = 1070;
    imageFolder = 'Office';
    imagePrefix = 'img01_';
elseif (imageType == 3)
    firstImageNumber = 2;
    lastImageNumber = 354;
    imageFolder = 'RedChair';
    imagePrefix = 'advbgst1_21_';
end

imageSuffix = '.jpg';

imgList=[];
for i = firstImageNumber:lastImageNumber
    fullFileName = strcat(imageFolder, '/', imagePrefix, sprintf('%04d', i), imageSuffix);
    img = imread(fullFileName);
    
    red = img(:,:,1); % Red channel
    green = img(:,:,2); % Green channel
    blue = img(:,:,3); % Blue channel
    grayscale = (red + green + blue);
    
    imgList(:, :, i+1) = grayscale;
end

%{
temporal1DGaussianFilteredThresholds = [110, 127; 150, 177];
temporal1DGaussianFilteredList1 = temporal1DGaussianFilter(imgList, 1.0, temporal1DGaussianFilteredThresholds);
temporal1DGaussianFilteredList2 = temporal1DGaussianFilter(imgList, 1.2, temporal1DGaussianFilteredThresholds);
temporal1DGaussianFilteredList3 = temporal1DGaussianFilter(imgList, 1.5, temporal1DGaussianFilteredThresholds);
temporal1DGaussianFilteredList4 = temporal1DGaussianFilter(imgList, 2.0, temporal1DGaussianFilteredThresholds);
simpleFilteredList1 = temporalSimpleFilter(imgList, 10);
simpleFilteredList2 = temporalSimpleFilter(imgList, 15);
simpleFilteredList3 = temporalSimpleFilter(imgList, 20);
boxFilter3 = boxFilter(imgList, 3);
boxFilter5 = boxFilter(imgList, 5);
spacial2DGaussianFilter1 = spacial2DGaussianFilter(imgList, 1.0);
spacial2DGaussianFilter2 = spacial2DGaussianFilter(imgList, 1.2);
spacial2DGaussianFilter3 = spacial2DGaussianFilter(imgList, 1.5);
spacial2DGaussianFilter4 = spacial2DGaussianFilter(imgList, 2);

makeVideo(grayToRgb(temporal1DGaussianFilteredList1), '1D Gaussian Temporal STD = 1.0');
makeVideo(grayToRgb(temporal1DGaussianFilteredList2), '1D Gaussian Temporal STD = 1.2');
makeVideo(grayToRgb(temporal1DGaussianFilteredList3), '1D Gaussian Temporal STD = 1.5');
makeVideo(grayToRgb(temporal1DGaussianFilteredList4), '1D Gaussian Temporal STD = 2.0');
makeVideo(grayToRgb(simpleFilteredList1), 'Simple Temporal Threshold = 10');
makeVideo(grayToRgb(simpleFilteredList2), 'Simple Temporal Threshold = 15');
makeVideo(grayToRgb(simpleFilteredList3), 'Simple Temporal Threshold = 20');
makeVideo(grayToRgb(temporalSimpleFilter(spacial2DGaussianFilter1, 15)), '2D Gaussian STD = 1.0'); % the best video
makeVideo(grayToRgb(temporalSimpleFilter(spacial2DGaussianFilter2, 15)), '2D Gaussian STD = 1.2');
makeVideo(grayToRgb(temporalSimpleFilter(spacial2DGaussianFilter3, 15)), '2D Gaussian STD = 1.5');
makeVideo(grayToRgb(temporalSimpleFilter(spacial2DGaussianFilter4, 15)), '2D Gaussian STD = 2');
makeVideo(grayToRgb(temporalSimpleFilter(boxFilter3, 15)), 'Box Filter 3');
makeVideo(grayToRgb(temporalSimpleFilter(boxFilter5, 15)), 'Box Filter 5');
makeVideo(grayToRgb(temporal1DGaussianFilter(spacial2DGaussianFilter1, 1.2, temporal1DGaussianFilteredThresholds)), '2D Gaussian STD = 1.0 with 1D Gaussian Temporal STD = 1.2'); 
makeVideo(grayToRgb(imgList), 'Grayscale Original Video')
%}