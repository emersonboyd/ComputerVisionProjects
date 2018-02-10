function [u, v] = flowVector(CMatrix, TMatrix)

% invert the T matrix for the calculation of u and v
TMatrix = -1 * TMatrix;

sizeMatrix = size(CMatrix);
sizeX = sizeMatrix(1);
sizeY = sizeMatrix(2);
u = zeros(sizeX, sizeY);
v = zeros(sizeX, sizeY);

for i = 1:sizeX
    for j = 1:sizeY
        %x = CMatrix(i,j,:,:)\TMatrix(i,j,:);
        C(:,:) = CMatrix(i,j,:,:);
        T(:,:) = TMatrix(i,j,:);
        %T = transpose(T);
        x = C\T;
%         x2 = inv(C'*C)*C'*T;
        u(i,j) = x(1);
        v(i,j) = x(2);
    end
end

end

