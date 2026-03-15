function [sig, t, roi] = read_video_roi_rgb(videoPath, channel, roiPreset, maxDurationSec)
%READ_VIDEO_ROI_RGB Extract mean RGB (single channel) from an ROI across frames.
% channel: "R" / "G" / "B"
% roiPreset: [x y w h] or [] to pick interactively

v = VideoReader(videoPath);
frameRate = v.FrameRate;

% Read first frame for ROI selection
firstFrame = readFrame(v);

if isempty(roiPreset)
    figure('Name', 'Select ROI (double click to confirm)');
    imshow(firstFrame);
    title('Draw ROI and double click / press Enter');
    try
        h = drawrectangle();
        wait(h);
        roi = round(h.Position);
    catch
        h = imrect(gca, []);
        roi = round(wait(h));
    end
    close(gcf);
else
    roi = round(roiPreset);
end

% Reset reader to start
v.CurrentTime = 0;

% Decide how many frames to read
if isempty(maxDurationSec)
    nMax = inf;
else
    nMax = floor(maxDurationSec * frameRate);
end

sig = [];
i = 1;

while hasFrame(v) && i <= nMax
    fr = readFrame(v);
    roiFr = imcrop(fr, roi);

    switch upper(string(channel))
        case "R"
            x = roiFr(:,:,1);
        case "G"
            x = roiFr(:,:,2);
        case "B"
            x = roiFr(:,:,3);
        otherwise
            error("channel must be 'R', 'G', or 'B'");
    end

    sig(i,1) = mean(x, "all"); %#ok<AGROW>
    i = i + 1;
end

t = (0:length(sig)-1)'/frameRate;
end
