clc
clear all
close all

warning off; % warnings were spawning from the linsolve(A,B) calls

tic

imageType = 1;
gaussianSmoothingSigma = 1.4;
CMatrixWindowSize = 3;

% calculates the flow vector between imageNum and imageNum+1
% so, imageNum of 1 calculates the flow vector between images 1 and 2
imageNum = 1;

if (imageType == 1)
    folderName = 'Images/toy1/';
    fileNamePrefix = 'toys';
    fileNameSuffix = '.gif';
    fileNumberMin = 1;
    fileNumberMax = 3;
elseif (imageType == 2)
    folderName = 'Images/toy2/';
    fileNamePrefix = 'toys2';
    fileNameSuffix = '.gif';
    fileNumberMin = 1;
    fileNumberMax = 3;
elseif (imageType == 3)
    folderName = 'Images/LKTest1/';
    fileNamePrefix = 'LKTest1im';
    fileNameSuffix = '.pgm';
    fileNumberMin = 1;
    fileNumberMax = 2;
elseif (imageType == 4)
    folderName = 'Images/LKTest2/';
    fileNamePrefix = 'LKTest2im';
    fileNameSuffix = '.pgm';
    fileNumberMin = 1;
    fileNumberMax = 2;
elseif (imageType == 5)
    folderName = 'Images/LKTest3/';
    fileNamePrefix = 'LKTest3im';
    fileNameSuffix = '.pgm';
    fileNumberMin = 1;
    fileNumberMax = 2;
end

grayImgList = [];

numImages = 0;
for i = fileNumberMin:fileNumberMax
    fullFileName = strcat(folderName, fileNamePrefix, sprintf('%d', i), fileNameSuffix); 
    img = imread(fullFileName);
    
    numImages = numImages + 1;
    grayImgList(:, :, numImages) = img;
end

gaussianFilterList = spacial2DGaussianFilter(grayImgList, gaussianSmoothingSigma);

[Iy, Ix] = prewittFilter(gaussianFilterList(:,:,imageNum+1));

It = gaussianFilterList(:,:,imageNum+1) - gaussianFilterList(:,:,imageNum);

[CMatrix, TMatrix] = CMatrix(Iy, Ix, It, CMatrixWindowSize);

[u, v] = flowVector(CMatrix, TMatrix);

% uncomment this line to overlay the flow vector on top of the first image
% imshow(grayImgList(:,:,imageNum)/255)

hold on
quiver(u,v)
hold off