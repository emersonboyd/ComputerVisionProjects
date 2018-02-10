function [verticalPrewitt, horizontalPrewitt] = prewittFilter(image)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
verticalPrewittFilter = [-1 0 1;
                         -1 0 1;
                         -1 0 1];
                     
horizontalPrewittFilter = [-1 -1 -1;
                            0 0 0;
                            1 1 1];
         
verticalPrewitt = imfilter(image, verticalPrewittFilter, 'replicate');
horizontalPrewitt = imfilter(image, horizontalPrewittFilter, 'replicate');

end

