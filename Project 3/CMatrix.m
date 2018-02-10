function [C, T] = CMatrix(verticalPrewitt, horizontalPrewitt, It, boxFilterSize)

verticalHorizontalPrewitt = verticalPrewitt .* horizontalPrewitt;
verticalPrewittSquared = verticalPrewitt .* verticalPrewitt;
horizontalPrewittSquared = horizontalPrewitt .* horizontalPrewitt;

verticalTemporal = verticalPrewitt .* It;
horizontalTemporal = horizontalPrewitt .* It;

boxFilter = ones(boxFilterSize, boxFilterSize)./(boxFilterSize * boxFilterSize);

boxFilterVerticalHorizontalPrewitt = imfilter(verticalHorizontalPrewitt, boxFilter);
boxFilterVerticalPrewitt = imfilter(verticalPrewittSquared, boxFilter);
boxFilterHorizontalPrewitt = imfilter(horizontalPrewittSquared, boxFilter);
boxFilterVerticalTemporal = imfilter(verticalTemporal, boxFilter);
boxFilterHorizontalTemporal = imfilter(horizontalTemporal, boxFilter);

sizeMatrix = size(verticalHorizontalPrewitt);
sizeX = sizeMatrix(1);
sizeY = sizeMatrix(2);

C = zeros(sizeX, sizeY, 2, 2);
T = zeros(sizeX, sizeY, 2, 1);
for i = 1:sizeX
    for j = 1:sizeY
        C(i,j,:,:) = [boxFilterHorizontalPrewitt(i, j) boxFilterVerticalHorizontalPrewitt(i, j);
             boxFilterVerticalHorizontalPrewitt(i, j) boxFilterVerticalPrewitt(i, j)];
        T(i,j,:,:) = [boxFilterHorizontalTemporal(i, j); boxFilterVerticalTemporal(i, j)];
    end
end
        
end

