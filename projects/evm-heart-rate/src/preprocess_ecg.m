function y = preprocess_ecg(x, fs, bandpassHz, useNotch, mainsHz)
%PREPROCESS_ECG Basic ECG cleanup: detrend + optional notch + bandpass.
% x: ECG vector
% fs: sampling rate (Hz)
% bandpassHz: [low high] in Hz
% useNotch: true/false
% mainsHz: 50 or 60

x = x(:);
x = x - mean(x);           % remove DC
x = detrend(x);            % remove slow trend (baseline)

y = x;

% Notch filter (mains hum) - narrow bandstop around mainsHz
if useNotch
    bw = 2;  % +/- 1 Hz around mains
    f1 = max(0.1, mainsHz - bw/2);
    f2 = mainsHz + bw/2;
    try
        nf = designfilt('bandstopiir','FilterOrder',2, ...
            'HalfPowerFrequency1', f1, 'HalfPowerFrequency2', f2, ...
            'SampleRate', fs);
        y = filtfilt(nf, y);
    catch
        % If Signal Processing Toolbox isn't available, skip notch
        warning("Notch filter skipped (designfilt/filtfilt unavailable).");
    end
end

% Bandpass filter (typical ECG content)
if ~isempty(bandpassHz)
    try
        bp = designfilt('bandpassiir','FilterOrder',4, ...
            'HalfPowerFrequency1', bandpassHz(1), ...
            'HalfPowerFrequency2', bandpassHz(2), ...
            'SampleRate', fs);
        y = filtfilt(bp, y);
    catch
        warning("Bandpass filter skipped (designfilt/filtfilt unavailable).");
    end
end

end
