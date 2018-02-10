function [H] = generateHFromPoints(x1, y1, xNew1, yNew1, x2, y2, xNew2, yNew2, x3, y3, xNew3, yNew3, x4, y4, xNew4, yNew4)
    A1 = [x1 y1 1; x2 y2 1; x3 y3 1; x4 y4 1];
    B1 = [xNew1; xNew2; xNew3; xNew4];
    A2 = A1;
    B2 = [yNew1; yNew2; yNew3; yNew4];
    A3 = A2;
    B3 = [1; 1; 1; 1];

    H1 = linsolve(A1,B1);
    H2 = linsolve(A2,B2);
    H3 = linsolve(A3,B3);
    H = [transpose(H1); transpose(H2); transpose(H3)];
end

