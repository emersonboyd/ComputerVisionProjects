function [MIL] = extractMIL(video_path)

    text_files = dir([video_path '*_MIL_TR001.txt']);
	assert(~isempty(text_files), 'No initial position and ground truth (*_gt.txt) to load.')

	f = fopen([video_path text_files(1).name]);
	MIL = textscan(f, '%f,%f,%f,%f');  %[x, y, width, height]
	MIL = cat(2, MIL{:});
	fclose(f);
    
    MIL = MIL(:,[2,1]) + MIL(:,[4,3]) / 2;
    
end

