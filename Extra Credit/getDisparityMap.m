function [disparityMapHorizontal, disparityMapVertical] = getDisparityMap(image1, image2)

    disparityMapHorizontal = disparity(image1, image2, 'Method', 'SemiGlobal');
    
    rotatedImage1 = imrotate(image1, 90);
    rotatedImage2 = imrotate(image2, 90);
    disparityMapVertical = disparity(rotatedImage1, rotatedImage2, 'Method', 'SemiGlobal');
    
    disparityMapVertical = imrotate(disparityMapVertical, -90);
    
    % normalize the disparity map between 0-255
    disparityMapHorizontal(disparityMapHorizontal < 0) = 0;
    disparityMapVertical(disparityMapVertical < 0) = 0;
    disparityMapHorizontal = normalizeMatrix(disparityMapHorizontal, 0, 255);
    disparityMapVertical = normalizeMatrix(disparityMapVertical, 0, 255);
end

