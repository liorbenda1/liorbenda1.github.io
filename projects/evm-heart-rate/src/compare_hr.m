function metrics = compare_hr(t1, x1, t2, x2, label)
%COMPARE_HR Align two HR time-series and compute summary metrics.
% t1/x1: ECG HR
% t2/x2: Video HR

metrics = struct();
metrics.label = label;

if isempty(x1) || isempty(x2)
    metrics.ok = false;
    return;
end

% Use the shorter time vector as reference for interpolation
if numel(t1) <= numel(t2)
    tRef = t1(:);
    xRef = x1(:);
    xOther = interp1(t2(:), x2(:), tRef, 'linear', 'extrap');
else
    tRef = t2(:);
    xOther = x2(:);
    xRef = interp1(t1(:), x1(:), tRef, 'linear', 'extrap');
end

% Restrict to overlap window (avoid extrap artifacts)
tMin = max(min(t1), min(t2));
tMax = min(max(t1), max(t2));
mask = (tRef >= tMin) & (tRef <= tMax);

tA = tRef(mask);
ecgA = xRef(mask);
vidA = xOther(mask);

% Basic metrics
metrics.ok = true;
metrics.t = tA;
metrics.ecg = ecgA;
metrics.vid = vidA;

metrics.mean_ecg = mean(ecgA);
metrics.mean_vid = mean(vidA);
metrics.rel_err = abs(metrics.mean_ecg - metrics.mean_vid) / metrics.mean_ecg;

metrics.std_ecg = std(ecgA);
metrics.std_vid = std(vidA);
metrics.mae = mean(abs(ecgA - vidA));

% Paired t-test (if available)
try
    [h, p] = ttest(ecgA, vidA);
    metrics.ttest_h = h;
    metrics.ttest_p = p;
catch
    metrics.ttest_h = NaN;
    metrics.ttest_p = NaN;
end

end
