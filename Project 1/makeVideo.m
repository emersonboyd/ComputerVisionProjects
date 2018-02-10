%{
MAKE VIDEO
%}

function [] = makeVideo( images, name )
    % create the video writer with 30fps
    writerObj = VideoWriter(strcat(name,'.avi'));
    writerObj.FrameRate = 30;
    % open the video writer
    open(writerObj);
    % write the frames to the video
    for i=1:length(images)
        % convert the image to a frame
        frame = im2frame(images(:,:,:,i));
        writeVideo(writerObj, frame);
    end
    % close the writer object
    close(writerObj);
end

