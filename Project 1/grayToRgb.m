%{
GRAY TO RGB
%}

function [rgbImages] = grayToRgb(grayImages)
    % normalize the gray images from 255 -> 1, if necessary
    if (max(grayImages(:)) > 1 && max(grayImages(:)) <= 255)
        grayImages = grayImages / 255;
    end

    grayImagesSize = size(grayImages);
    numGrayImages = grayImagesSize(3);
    for i = 1:numGrayImages
        rgbImages(:, :, :, i) = cat(3, grayImages(:, :, i), grayImages(:, :, i), grayImages(:, :, i));
    end
end

