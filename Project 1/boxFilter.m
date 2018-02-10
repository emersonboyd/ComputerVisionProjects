%{
BOX FILTER
%}

function [boxFilterList] = boxFilter(imgList,boxSize)
    imgListSize = size(imgList);
    xDir = imgListSize(2);
    yDir = imgListSize(1);
    zDir = imgListSize(3);
    startPixel = boxSize - floor(boxSize/2);
    endPixelX = xDir - floor(boxSize/2);
    endPixelY = yDir - floor(boxSize/2);
    boxFilterList = imgList;
    
    boxFilterX = (1/boxSize) * ones(1,boxSize);
    boxFilterY = transpose(boxFilterX);
    for k = 1:zDir
        boxFilterList(startPixel:endPixelY, startPixel:endPixelX, k) = conv2(conv2(imgList(:,:,k), boxFilterX, 'valid'), boxFilterY, 'valid');
    end
end

