function bland_altman(x, y, figNum, ttl)
%BLAND_ALTMAN Create a Bland–Altman plot for two paired measurements.
% x, y: vectors of equal length (paired)
% figNum: figure number
% ttl: title string

x = x(:); y = y(:);
n = min(numel(x), numel(y));
x = x(1:n); y = y(1:n);

m = (x + y)/2;
d = y - x;          % difference (Video - ECG)

md = mean(d);
sd = std(d);
loa1 = md + 1.96*sd;
loa2 = md - 1.96*sd;

if ~isempty(figNum)
    figure(figNum); clf;
else
    figure; 
end

scatter(m, d, 'filled');
hold on;
yline(md, '--', 'Mean diff');
yline(loa1, '--', '+1.96 SD');
yline(loa2, '--', '-1.96 SD');
hold off;

xlabel('Mean of measurements (bpm)');
ylabel('Difference (Video - ECG) (bpm)');
title(ttl);

grid on;

end
