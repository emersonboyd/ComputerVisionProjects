function [ predX, predY ] = predictLocation( maxResponseX, maxResponseY, frameLookbacks )
    
    numDataPoints = size(maxResponseX, 1);
    dimens = ceil(numDataPoints / 2);
    
    % Hx is the Hankel matrix for the x response values
    Hx = zeros(dimens, dimens);
    
    % Hy is the Hankel matrix for the y response values
    Hy = zeros(dimens, dimens);
    
    for i = 1:dimens
        for j = 1:dimens
            cellNum = i + j - 1;
            Hx(i, j) = maxResponseX(cellNum);
            Hy(i, j) = maxResponseY(cellNum);
        end
    end
    
    % all but the last column of the H matrix is A
    Ax = Hx(:, 1:dimens-1);
    Ay = Hy(:, 1:dimens-1);
    
    % the last column of the H matrix is b
    bx = Hx(:, dimens);
    by = Hy(:, dimens);
    
    vx = Ax \ bx;
    vy = Ay \ by;
    
    cLength = dimens-1;
    Cx = zeros(1, cLength);
    Cy = zeros(1, cLength);
    
    % Cx and Cy are used with vx and vy to predict a new X and Y
    for i = 1:cLength
        Cx(1, i) = maxResponseX(numDataPoints - (dimens - i) + 1);
        Cy(1, i) = maxResponseY(numDataPoints - (dimens - i) + 1);
    end
    
    % This iterates once for each future prediction to be made
    for i = 0:frameLookbacks
        predX = Cx * vx;
        predY = Cy * vy;
        
        % We want to shift the Cx and Cy arrays left and add the
        % newly-predicted X and Y's in case we want to predict X and Y
        % again
        Cx = circshift(Cx(:, 1:cLength), [0 cLength-1]);
        Cy = circshift(Cy(:, 1:cLength), [0 cLength-1]);
        Cx(:, cLength) = predX;
        Cy(:, cLength) = predY;
    end
end

