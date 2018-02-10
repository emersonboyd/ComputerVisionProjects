function [DetMatrix] = CMatrix(verticalPrewitt, horizontalPrewitt)
    verticalHorizontalPrewitt = verticalPrewitt .* horizontalPrewitt;

    verticalPrewittSquared = verticalPrewitt .* verticalPrewitt;

    horizontalPrewittSquared = horizontalPrewitt .* horizontalPrewitt;

    boxFilterSize = 7;
    boxFilter = ones(boxFilterSize, boxFilterSize)./(boxFilterSize * boxFilterSize);

    boxFilterVerticalHorizontalPrewitt = imfilter(verticalHorizontalPrewitt, boxFilter);
    boxFilterVerticalPrewitt = imfilter(verticalPrewittSquared, boxFilter);
    boxFilterHorizontalPrewitt = imfilter(horizontalPrewittSquared, boxFilter);

    sizeMatrix = size(verticalHorizontalPrewitt);
    sizeX = sizeMatrix(1);
    sizeY = sizeMatrix(2);

    DetMatrix = zeros(sizeX, sizeY);
    for i = 1:sizeX
        for j = 1:sizeY
            C = [boxFilterVerticalPrewitt(i, j) boxFilterVerticalHorizontalPrewitt(i, j);
                 boxFilterVerticalHorizontalPrewitt(i, j) boxFilterHorizontalPrewitt(i, j)];
            D = eig(C);
            det = D(1) * D(2);
            trace = D(1) + D(2);
            DetMatrix(i,j) = det - (0.05 * (trace^2));
        end
    end
end

