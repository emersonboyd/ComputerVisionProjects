function [ normalizedMatrix ] = normalizeMatrix(matrix, normMin, normMax)

    matrixMin = min(min(matrix));
    matrixMax = max(max(matrix));
    matrixRange = matrixMax - matrixMin;
    
    matrix0To1 = (matrix - matrixMin) / matrixRange;
    
    normRange = normMax - normMin;
    normalizedMatrix = (matrix0To1 * normRange) + normMin;

end
