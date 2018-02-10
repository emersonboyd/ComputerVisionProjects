clc
clear all
close all

imageType = 2;

if (imageType == 1)
    folderName = 'Images/cast/';
    fileNamePrefix = 'cast-';
    fileName1 = 'left';
    fileName2 = 'right';
    fileNameExtension = '.jpg';
    rThreshold = 50000000;
    nccThreshold = 1.04;
elseif (imageType == 2)
    folderName = 'Images/Cones/';
    fileNamePrefix = 'Cones_im';
    fileName1 = '2';
    fileName2 = '6';
    fileNameExtension = '.JPG';
    rThreshold = 100000000;
    nccThreshold = 1.04;
else
    error('Cannot select image with the given image type.')
end

fullFileName1 = strcat(folderName, fileNamePrefix, fileName1, fileNameExtension);
fullFileName2 = strcat(folderName, fileNamePrefix, fileName2, fileNameExtension);
image1 = imread(fullFileName1);
image2 = imread(fullFileName2);

% we need doubles so that we can perform necessary calculations later
rgbImgList(:, :, :, 1) = double(image1);
rgbImgList(:, :, :, 2) = double(image2);
grayImgList(:, :, 1) = double(rgb2gray(image1));
grayImgList(:, :, 2) = double(rgb2gray(image2));

% Harris Corner Detection, Non-Max Suppression and NCC 
[corrX, corrY] = getCorners(grayImgList(:,:,1), grayImgList(:,:,2), rThreshold, nccThreshold);

plotCorrelations(rgbImgList(:,:,:,1), rgbImgList(:,:,:,2), corrX, corrY);

% Calculate the fundamental matrix
[matchedPoints1, matchedPoints2] = getMatchedPoints(corrX, corrY);
F = estimateFundamentalMatrix(matchedPoints1, matchedPoints2);

% Perform RANSAC to find the inliers
sizeImageX = size(grayImgList(:, :, 1), 1);
sizeImageY = size(grayImgList(:, :, 1), 2);
[inliersX, inliersY] = ransac(F, matchedPoints1, matchedPoints2, sizeImageX, sizeImageY);

figure
plotCorrelations(rgbImgList(:,:,:,1), rgbImgList(:,:,:,2), inliersX, inliersY);

grayImgList = uint8(grayImgList);
[disparityMapHorizontal, disparityMapVertical] = getDisparityMap(grayImgList(:,:,1), grayImgList(:,:,2));

figure
imshow(disparityMapHorizontal, [0 255]);
figure
imshow(disparityMapVertical, [0 255]);