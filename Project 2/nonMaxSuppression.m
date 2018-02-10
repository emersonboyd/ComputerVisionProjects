function [outputMatrix] = nonMaxSuppression(orientation, magnitude, R)
    totalSize = size(orientation);
    sizeX = totalSize(1);
    sizeY = totalSize(2);

    outputMatrix = R;

    for i = 2:sizeX-1
        for j = 2:sizeY-1
            angle = closestAngle(orientation(i,j));
            if (angle == 0)
                compareIndex1 = magnitude(i, j-1);
                compareIndex2 = magnitude(i, j+1);
            elseif (angle == 45)
                compareIndex1 = magnitude(i-1, j+1);
                compareIndex2 = magnitude(i+1, j-1);
            elseif (angle == 90)
                compareIndex1 = magnitude(i-1, j);
                compareIndex2 = magnitude(i+1, j);

            elseif (angle == 135)
                compareIndex1 = magnitude(i-1, j-1);
                compareIndex2 = magnitude(i+1, j+1);
            end
            if (or((magnitude(i,j) < compareIndex1),(magnitude(i,j) < compareIndex2)))
                outputMatrix(i,j) = 0;
            else
                outputMatrix(i,j) = R(i,j);
            end
        end
    end
end

