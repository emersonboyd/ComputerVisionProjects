function [inliersX, inliersY] = ransac(F, matchedPoints1, matchedPoints2, imageSizeX, imageSizeY)

    [inliers1, inliers2, fValue] = calculateNumCorrectPoints(F, matchedPoints1, matchedPoints2);

    totalInliersSize = size(inliers1);
    inliersLength = totalInliersSize(1);

    inliersX = zeros(imageSizeX, imageSizeY);
    inliersY = zeros(imageSizeX, imageSizeY);

    for k = 1:inliersLength
        x = inliers1(k, 1);
        y = inliers1(k, 2);

        inliersX(x,y) = inliers2(k,1);
        inliersY(x,y) = inliers2(k,2);
    end
end


