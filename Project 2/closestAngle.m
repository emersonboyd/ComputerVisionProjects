function [angle] = closestAngle(orientation)
    compareArray = [0 45 90 135];
    if (abs(mod(orientation,180)) >= (180-22.5))
        angle = 0;
    else
        for i = 1:4
            if (abs(mod(orientation,180)-compareArray(i)) <= 22.5)
                angle = compareArray(i);
            end
        end
    end
end
