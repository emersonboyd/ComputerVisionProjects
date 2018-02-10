function [numCorrect, inliers1, inliers2] = calculateNumCorrectPoints(points1, points2, H)

totalSizePoints = size(points1);
numPoints = totalSizePoints(1);

numCorrect = 0;
j = 0;

inliers1 = zeros(1,2);
inliers2 = zeros(1,2);

accuracyThreshold = 2;

for i = 1:numPoints
    pointOld = [points1(i,1); points1(i,2); 1];
    pointNew = H * pointOld;
    if (abs(points2(i,1) - pointNew(1)) <= accuracyThreshold && abs(points2(i,2) - pointNew(2)) <= accuracyThreshold)
        j = j + 1;
        inliers1(j,1) = points1(i,1);
        inliers1(j,2) = points1(i,2);
        inliers2(j,1) = points2(i,1);
        inliers2(j,2) = points2(i,2);
        numCorrect = numCorrect + 1;
    end
end
