function [hrBpm, tHr, pkLocs] = estimate_hr_from_ecg(ecg, t, fs, maxHRbpm)
%ESTIMATE_HR_FROM_ECG Peak-based HR estimation from filtered ECG.
% Returns:
%  - hrBpm: instantaneous HR (bpm) between consecutive peaks
%  - tHr: time stamps aligned to the first peak of each interval
%  - pkLocs: indices of detected peaks

minPeriodSec = 60/maxHRbpm;
minPeakDistance = max(1, round(0.8 * fs * minPeriodSec));

prom = 0.5 * std(ecg);
if prom == 0
    prom = 1e-6;
end

[~, pkLocs] = findpeaks(ecg, ...
    'MinPeakDistance', minPeakDistance, ...
    'MinPeakProminence', prom);

if numel(pkLocs) < 2
    warning("Too few ECG peaks detected. Try adjusting filters or peak parameters.");
    hrBpm = [];
    tHr = [];
    return;
end

ibi = diff(pkLocs) / fs;      % inter-beat interval (sec)
hrBpm = 60 ./ ibi;
tHr = t(pkLocs(1:end-1));
end
