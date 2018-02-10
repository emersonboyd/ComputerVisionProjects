function [] = plotCorrelations(grayImg1, grayImg2, corrX, corrY)

totalImageSize1 = size(grayImg1);
imageHeight1 = totalImageSize1(1);
imageWidth1 = totalImageSize1(2);

grayImgFull = horzcat(grayImg1, grayImg2);

totalImageSizeFull = size(grayImgFull);
imageHeightFull = totalImageSizeFull(1);
imageWidthFull = totalImageSizeFull(2);

imshow(grayImgFull/255)
hold on
for x = 1:imageHeight1
    for y = 1:imageWidth1
        if ((corrX(x,y) ~= 0) && (corrY(x,y) ~= 0))
            img2XCoordinate = imageWidth1 + corrY(x,y);
            line([y img2XCoordinate], [x corrX(x,y)], 'Color', 'yellow')
        end
    end
end

axis([1 imageWidthFull 1 imageHeightFull])
daspect([1 1 1])

hold off

end

