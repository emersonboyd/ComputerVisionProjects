function [ matchedPoints1, matchedPoints2 ] = getMatchedPoints(corrX, corrY)

numMatchedPoints = sum(sum(corrX > 0));
matchedPoints1 = zeros(numMatchedPoints, 2);
matchedPoints2 = zeros(numMatchedPoints, 2);

sizeX = size(corrX, 1);
sizeY = size(corrX, 2);

matchedPointsCount = 0;
for i = 1:sizeX
    for j = 1:sizeY
        if (corrX(i,j) > 0 && corrY(i,j) > 0)
            matchedPointsCount = matchedPointsCount + 1;
            matchedPoints1(matchedPointsCount, :) = [i j];
            matchedPoints2(matchedPointsCount, :) = [corrX(i,j) corrY(i,j)];
        end
    end
end

end

