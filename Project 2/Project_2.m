clc
clear all
close all

warning off; % warnings were spawning from the linsolve(A,B) calls

tic

imageType = 1;

imageScale = 1;

if (imageType == 1)
    folderName = 'Images/DanaHallway1/';
    fileNamePrefix = 'DSC_0';
    fileNameSuffix = '.JPG';
    fileNumberMin = 281;
    fileNumberMax = 283;
    rThreshold = 10000000;
    nccThreshold = 1.04;
elseif (imageType == 2)
    folderName = 'Images/DanaHallway2/';
    fileNamePrefix = 'DSC_0';
    fileNameSuffix = '.JPG';
    fileNumberMin = 285;
    fileNumberMax = 287;
    rThreshold = 10000000;
    nccThreshold = 1.03;
elseif (imageType == 3)
    folderName = 'Images/DanaOffice/';
    fileNamePrefix = 'DSC_0';
    fileNameSuffix = '.JPG';
    fileNumberMin = 308;
    fileNumberMax = 310;
    rThreshold = 100000000;
    nccThreshold = 1.07;
end

grayImgList = [];

numImages = 0;
for i = fileNumberMin:fileNumberMax
    fullFileName = strcat(folderName, fileNamePrefix, sprintf('%3d', i), fileNameSuffix); 
    img = imread(fullFileName);
    
    numImages = numImages + 1;
    rgbImgList(:, :, :, numImages) = double(img); % we need doubles so that we can perform necessary calculations later
    grayImgList(:, :, numImages) = rgb2gray(img);
end

% Harris Corner Detection, Non-Max Suppression and NCC 
[corrX, corrY] = getCorners(grayImgList(:,:,1), grayImgList(:,:,2), rThreshold, nccThreshold);

plotCorrelations(rgbImgList(:,:,:,1), rgbImgList(:,:,:,2), corrX, corrY);

% RANSAC
[ roughH, roughInliersX, roughInliersY ] = ransac2(grayImgList(:,:,1), grayImgList(:,:,2), corrX, corrY);
[ H, inliersX, inliersY ] = ransac2(grayImgList(:,:,1), grayImgList(:,:,2), roughInliersX, roughInliersY);

figure
plotCorrelations(rgbImgList(:,:,:,1), rgbImgList(:,:,:,2), inliersX, inliersY);

% Image Warping
warpedImage = warpImage(rgbImgList(:,:,:,1), H);

figure;
imshow(warpedImage/255);

grayWarpedImage = round(rgb2gray(warpedImage/255)*255);

% Find the Corners of the Warped Image Matching with the Second Image
[corrXWarped, corrYWarped] = getCorners(grayWarpedImage, grayImgList(:,:,2), rThreshold, nccThreshold);
[ roughHWarped, roughInliersWarpedX, roughInliersWarpedY ] = ransac2(grayWarpedImage, grayImgList(:,:,2), corrXWarped, corrYWarped);
[ HWarped, inliersXWarped, inliersYWarped ] = ransac2(grayWarpedImage, grayImgList(:,:,2), roughInliersWarpedX, roughInliersWarpedY);
XOffset = round(HWarped(1, 3));
YOffset = round(HWarped(2, 3));

% Image Blending
blendedImage = blendImages(warpedImage, rgbImgList(:,:,:,2), XOffset, YOffset);
figure
imshow(blendedImage/255);

timeElapsed = toc