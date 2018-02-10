function [newWarpedImage] = blendImages(image1, image2, XOffset, YOffset)
    sizeImage1 = size(image1);
    sizeImage1X = sizeImage1(1);
    sizeImage1Y = sizeImage1(2);
    sizeImage2 = size(image2);
    sizeImage2X = sizeImage2(1);
    sizeImage2Y = sizeImage2(2);
    
    image1XOffset = 0;
    image1YOffset = 0;
    image2XOffset = 0;
    image2YOffset = 0;
    
    if (XOffset < 0) 
        image2XOffset = abs(XOffset);
    else
        image1XOffset = XOffset;
    end
    if (YOffset < 0)
        image2YOffset = abs(YOffset);
    else
        image1YOffset = YOffset;
    end
    
    newWarpedImageX = max(sizeImage1X, sizeImage2X) + abs(XOffset);
    newWarpedImageY = max(sizeImage1Y, sizeImage2Y) + abs(YOffset);
    newWarpedImage = ones(newWarpedImageX, newWarpedImageY, 3) * -1;
    
    if (XOffset < 0 && YOffset < 0)
        for i = 1:sizeImage1X
            for j = 1:sizeImage1Y            
                newWarpedImage(i, j, :) = image1(i, j, :);
            end
        end    
    
        for k = 1:sizeImage2X
            for l = 1:sizeImage2Y
                if (newWarpedImage(k + abs(image2XOffset), l + abs(image2YOffset), :) == -1)
                    newWarpedImage(k + abs(image2XOffset), l + abs(image2YOffset), :) = image2(k,l, :);
                else
                    pixelAverage = (image2(k,l, :) + newWarpedImage(k + abs(image2XOffset), l + abs(image2YOffset), :)) / 2;
                    newWarpedImage(k + abs(image2XOffset), l + abs(image2YOffset), :) = pixelAverage;
                end
            end
        end
    end
    
    if (XOffset > 0 && YOffset > 0)
        for i = 1:sizeImage2X
            for j = 1:sizeImage2Y            
                newWarpedImage(i, j, :) = image2(i, j, :);
            end
        end    
    
        for k = 1:sizeImage1X
            for l = 1:sizeImage1Y
                if (newWarpedImage(k + abs(image1XOffset), l + abs(image1YOffset), :) == -1)
                    newWarpedImage(k + abs(image1XOffset), l + abs(image1YOffset), :) = image1(k,l, :);
                else
                    pixelAverage = (image1(k,l, :) + newWarpedImage(k + abs(image1XOffset), l + abs(image1YOffset), :)) / 2;
                    newWarpedImage(k + abs(image1XOffset), l + abs(image1YOffset), :) = pixelAverage;
                end
            end
        end
    end
    
    newWarpedImage(newWarpedImage == -1) = 0;
end

