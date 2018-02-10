function [ H, inliersX, inliersY ] = ransac2( imgList1, imgList2, corrX, corrY )
    totalImageSize1 = size(imgList1);
    imageHeight1 = totalImageSize1(1);
    imageWidth1 = totalImageSize1(2);

    j = 0;
    for x = 1:imageHeight1
        for y = 1:imageWidth1
            if ((corrX(x,y) ~= 0) && (corrY(x,y) ~= 0))
                j = j + 1;
                img1(j,:) = [x y];
                img2(j,:) = [corrX(x,y) corrY(x,y)];
            end 
        end
    end

    bestH = zeros(3,3);
    bestHNumCorrect = -1;
    bestInliers1 = zeros(1,2);
    bestInliers2 = zeros(1,2);

    for i = 1:(j*10)
        rng('shuffle');
        loc1 = ceil(rand() * j);
        loc2 = ceil(rand() * j);
        loc3 = ceil(rand() * j);
        loc4 = ceil(rand() * j);

        x1 = img1(loc1, 1);
        y1 = img1(loc1, 2);
        xNew1 = img2(loc1, 1);
        yNew1 = img2(loc1, 2);
        x2 = img1(loc2, 1);
        y2 = img1(loc2, 2);
        xNew2 = img2(loc2, 1);
        yNew2 = img2(loc2, 2);
        x3 = img1(loc3, 1);
        y3 = img1(loc3, 2);
        xNew3 = img2(loc3, 1);
        yNew3 = img2(loc3, 2);
        x4 = img1(loc4, 1);
        y4 = img1(loc4, 2);
        xNew4 = img2(loc4, 1);
        yNew4 = img2(loc4, 2);
        
        pts1 = [x1 x2 x3 x4; y1 y2 y3 y4];
        pts2 = [xNew1 xNew2 xNew3 xNew4; yNew1 yNew2 yNew3 yNew4];
        potentialH = solveHomo(pts1, pts2);
        [potentialHNumCorrect, potentialInliers1, potentialInliers2] = calculateNumCorrectPoints(img1, img2, potentialH);

        if (potentialHNumCorrect > bestHNumCorrect)
            bestH = potentialH;
            bestHNumCorrect = potentialHNumCorrect;
            bestInliers1 = potentialInliers1;
            bestInliers2 = potentialInliers2;
        end
    end

    H = bestH;
    inliers1 = bestInliers1;
    inliers2 = bestInliers2;

    totalInliersSize = size(inliers1);
    inliersLength = totalInliersSize(1);

    inliersX = zeros(size(imgList1));
    inliersY = zeros(size(imgList2));

    for k = 1:inliersLength
        x = inliers1(k, 1);
        y = inliers1(k, 2);

        inliersX(x,y) = inliers2(k,1);
        inliersY(x,y) = inliers2(k,2);
    end
end


