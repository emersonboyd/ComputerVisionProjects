%{
BOX FILTER INEFFICIENT
%}

function [boxFilterList] = boxFilterInefficient(imgList,boxSize)
    imgListSize = size(imgList);
    xDir = imgListSize(2);
    yDir = imgListSize(1);
    zDir = imgListSize(3);
    startPixel = boxSize - floor(boxSize/2);
    endPixelX = xDir - floor(boxSize/2);
    endPixelY = yDir - floor(boxSize/2);
    boxFilterList = imgList;
    
    for i = startPixel:endPixelX
        for j = startPixel:endPixelY
            for k = 1:zDir
                pixelValue = 0;
                for l = 1:boxSize
                    for m = 1:boxSize
                        pixelValue = pixelValue + imgList((j + m - (ceil(boxSize/2))), (i + l - (ceil(boxSize/2))), k);
                    end
                end
                boxFilterList(j,i,k) = pixelValue/(boxSize^2);
            end
        end
    end
end

