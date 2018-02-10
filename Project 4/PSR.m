function [ psrValue ] = PSR(response, maxRow, maxCol)

    boxFilterSize = 3;
    boxRadius = floor(boxFilterSize / 2);
    
    sizeX = size(response, 1);
    sizeY = size(response, 2);
    
    valuesOutsidePeak = [];
    x = 1;
    
    for i = 1:sizeX
        for j = 1:sizeY
            if (i < maxRow - boxRadius || i > maxRow + boxRadius) ...
                || (j < maxCol - boxRadius || j > maxCol + boxRadius)
                    valuesOutsidePeak(x) = response(i, j);
                    x = x + 1;     
            end
        end
    end
    
    meanValue = mean(valuesOutsidePeak);
    standardDev = std(valuesOutsidePeak);
    
    psrValue = (response(maxRow, maxCol) - meanValue) / standardDev;

end

