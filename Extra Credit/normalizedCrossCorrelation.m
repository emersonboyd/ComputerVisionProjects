function [corrX, corrY] = normalizedCrossCorrelation(grayImg1, grayImg2, nonMaxSuppress1, nonMaxSuppress2, nccThreshold)
    nccBoxFilterSize = 11;
    
    totalImageSize1 = size(grayImg1);
    imageHeight1 = totalImageSize1(1);
    imageWidth1 = totalImageSize1(2);
    totalImageSize2 = size(grayImg2);
    imageHeight2 = totalImageSize2(1);
    imageWidth2 = totalImageSize2(2);
    
    nccImg1 = zeros(size(grayImg1));
    nccImg2 = zeros(size(grayImg2));
    
    halfNccBoxFilterSizeFloored = floor(nccBoxFilterSize / 2);
    xMin = nccBoxFilterSize - halfNccBoxFilterSizeFloored;
    yMin = xMin;
    xMax1 = imageHeight1 - halfNccBoxFilterSizeFloored;
    yMax1 = imageWidth1 - halfNccBoxFilterSizeFloored;
    xMax2 = imageHeight2 - halfNccBoxFilterSizeFloored;
    yMax2 = imageWidth2 - halfNccBoxFilterSizeFloored;

    for x = xMin:xMax1
        for y = yMin:yMax1
            if (nonMaxSuppress1(x, y) == 255)
                xRange = x - halfNccBoxFilterSizeFloored : x + halfNccBoxFilterSizeFloored;
                yRange = y - halfNccBoxFilterSizeFloored : y + halfNccBoxFilterSizeFloored;
                grayImg1Snippet = grayImg1(xRange, yRange);
                nccImg1(x, y) = norm(grayImg1Snippet);
            end
        end
    end
    
    for x = xMin:xMax2
        for y = yMin:yMax2
            if (nonMaxSuppress2(x, y) == 255)
                xRange = x - halfNccBoxFilterSizeFloored : x + halfNccBoxFilterSizeFloored;
                yRange = y - halfNccBoxFilterSizeFloored : y + halfNccBoxFilterSizeFloored;
                grayImg2Snippet = grayImg2(xRange, yRange);
                nccImg2(x, y) = norm(grayImg2Snippet);
            end
        end
    end
    
    corrX = zeros(size(grayImg1));
    corrY = zeros(size(grayImg1));
    
    for x1 = xMin:xMax1
        for y1 = yMin:yMax1
            if (nonMaxSuppress1(x1,y1) == 255)
                x1Range = x1 - halfNccBoxFilterSizeFloored : x1 + halfNccBoxFilterSizeFloored;
                y1Range = y1 - halfNccBoxFilterSizeFloored : y1 + halfNccBoxFilterSizeFloored;
                grayImg1Snippet = grayImg1(x1Range, y1Range);

                c = zeros(size(grayImg2));

                for x2 = xMin:xMax2
                    for y2 = yMin:yMax2
                        if (nonMaxSuppress2(x2,y2) == 255)
                            x2Range = x2 - halfNccBoxFilterSizeFloored : x2 + halfNccBoxFilterSizeFloored;
                            y2Range = y2 - halfNccBoxFilterSizeFloored : y2 + halfNccBoxFilterSizeFloored;
                            grayImg2Snippet = grayImg2(x2Range, y2Range);

                            ccPoint = grayImg1Snippet .* grayImg2Snippet;
                            nccPoint = sum(sum(ccPoint)) / (nccImg1(x1,y1) * nccImg2(x2,y2));
                            c(x2,y2) = nccPoint;
                        end
                    end
                end
                
                [cMaxVal, cMaxIndex] = max(c(:));
                if (cMaxVal > nccThreshold)
                    [cMaxX, cMaxY] = ind2sub(size(c), cMaxIndex);
                    corrX(x1,y1) = cMaxX;
                    corrY(x1,y1) = cMaxY;
                end
            end
        end
    end
end