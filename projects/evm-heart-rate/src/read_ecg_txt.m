function [ecg, t] = read_ecg_txt(path, fs, maxDurationSec)
%READ_ECG_TXT Load ECG from a .txt file (assumes first column is signal).
d = importdata(path);
if isstruct(d) && isfield(d, "data")
    x = d.data(:,1);
else
    x = d(:,1);
end

if ~isempty(maxDurationSec)
    nMax = min(length(x), round(maxDurationSec*fs));
    x = x(1:nMax);
end

ecg = x(:);
t = (0:length(ecg)-1)'/fs;
end
