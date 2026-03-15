function [hrBpm, tHr, pkLocs] = estimate_hr_from_video(sig, t, fs, maxHRbpm)
%ESTIMATE_HR_FROM_VIDEO Peak-based HR estimation from processed ROI signal.

minPeriodSec = 60/maxHRbpm;
minPeakDistance = max(1, round(0.8 * fs * minPeriodSec));

prom = 0.5 * std(sig);
if prom == 0
    prom = 1e-6;
end

[~, pkLocs] = findpeaks(sig, ...
    'MinPeakDistance', minPeakDistance, ...
    'MinPeakProminence', prom);

if numel(pkLocs) < 2
    warning("Too few video peaks detected. Try changing ROI/channel/filter/peak params.");
    hrBpm = [];
    tHr = [];
    return;
end

ibi = diff(pkLocs) / fs;
hrBpm = 60 ./ ibi;
tHr = t(pkLocs(1:end-1));
end
