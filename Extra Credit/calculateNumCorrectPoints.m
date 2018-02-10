function [inliers1, inliers2, fValues] = calculateNumCorrectPoints(F, points1, points2)

numPoints = size(points1, 1);
fValues = zeros(numPoints, 1);

fThreshold = .002;

j = 0;
for i = 1:numPoints
    p1 = [points1(i, :) 1];
    p2 = [points2(i, :) 1];
    
    fVal = p2 * F * p1';
    fValues(i, :) = fVal;
    
    if (abs(fVal) < fThreshold)
        j = j + 1;
        inliers1(j, :) = points1(i, :);
        inliers2(j, :) = points2(i, :);
    end
end
