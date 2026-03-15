function y = preprocess_video_signal(x, fs, bandpassBpm, smoothWinSec)
%PREPROCESS_VIDEO_SIGNAL Clean ROI intensity time-series for HR estimation.
% Steps: detrend -> z-score -> moving average -> bandpass in Hz.

x = x(:);
x = detrend(x);

% z-score for scale invariance
sx = std(x);
if sx > 0
    x = (x - mean(x)) / sx;
end

% Smoothing
win = max(1, round(smoothWinSec * fs));
x = movmean(x, win);

y = x;

% Bandpass (convert bpm -> Hz)
if ~isempty(bandpassBpm)
    f1 = bandpassBpm(1)/60;
    f2 = bandpassBpm(2)/60;
    try
        bp = designfilt('bandpassiir','FilterOrder',4, ...
            'HalfPowerFrequency1', f1, 'HalfPowerFrequency2', f2, ...
            'SampleRate', fs);
        y = filtfilt(bp, y);
    catch
        warning("Video bandpass skipped (designfilt/filtfilt unavailable).");
    end
end

end
