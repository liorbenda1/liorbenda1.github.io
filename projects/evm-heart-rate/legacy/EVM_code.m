%% Loading file

% Read Resting HR ECG file
restData = importdata('restHR.txt');
restECG = restData.data(:, 1);

% Read Active HR ECG file
activeData = importdata('activeHR.txt');
activeECG = activeData.data(:, 1);

% Cutting the data to 30 seconds length
restECG = restECG(1:29246);
activeECG = activeECG(1:29246);

% Time vector
fs = 1000;
ts = 1/fs;
restTime = 0:ts:(length(restECG)-1)*ts;
activeTime = 0:ts:(length(activeECG)-1)*ts;


%% Finding Powerline Frequency for activeHR

% Calculate the power spectral density (PSD) of the activeECG data
N = length(activeECG); % Length of the signal
window = hamming(N); % Window function
nfft = 2^nextpow2(N); % Number of FFT points
freq = (0:nfft/2-1) * (fs/nfft); % Frequency axis

% Compute the PSD using Welch's method
[psd, freq] = pwelch(activeECG, window, 0, nfft, fs);

% Find the dominant frequency in the PSD
[~, idx] = max(psd);
powerlineFrequency = freq(idx);

% Display the estimated powerline frequency
disp(powerlineFrequency);
%% Applying Notch Filter to activeECG data

% Define the powerline frequency (e.g., 60 Hz)
powerlineFrequency = 0.1831;

% Design the notch filter
notchFilter = designfilt('bandstopiir', 'FilterOrder', 2, ...
    'HalfPowerFrequency1', powerlineFrequency-0.183, ...
    'HalfPowerFrequency2', powerlineFrequency+6, ...
    'SampleRate', 1000);

% Apply the notch filter to the activeECG data
filteredactiveECG = filtfilt(notchFilter, activeECG);


% Plot the original and filtered ECG data
t = (0:length(activeECG)-1) / fs ;

% figure;
% subplot(2,1,1);
% plot(t, activeECG);
% title('Original Active ECG Data');
% xlabel('Time (s)');
% ylabel('Amplitude');
% 
% subplot(2,1,2);
% plot(t, filteredactiveECG);
% title('Filtered Active ECG Data');
% xlabel('Time (s)');
% ylabel('Amplitude');


%% Calculating HR from ECG Data

% Resting HR calculation
[restPks, restPkLocs]  = findpeaks(restECG,'MinPeakProminence',max(restECG)*0.5);
restDiff = diff(restPkLocs);
rest_timeDiff = diff(restTime(restPkLocs));


% Active HR calculation
[activePks, activePkLocs]  = findpeaks(filteredactiveECG,'MinPeakProminence',max(filteredactiveECG)*0.5);
activeDiff = diff(activePkLocs);
active_timeDiff = diff(activeTime(activePkLocs));


% Plotting
figure;
subplot(2,1,1);
plot(restTime, restECG, 'b');
hold on;
plot(restTime(restPkLocs), restECG(restPkLocs), 'ro');
plot(activeTime, filteredactiveECG, 'r');
plot(activeTime(activePkLocs), filteredactiveECG(activePkLocs), 'mo');
hold off;
title('ECG Signals');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Resting ECG', 'Resting Peaks', 'Filtered Active ECG', 'Active Peaks');

subplot(2,1,2);
plot(restTime(restPkLocs(1:end-1)), 60./(rest_timeDiff), 'b');
hold on;
plot(activeTime(activePkLocs(1:end-1)), 60./(active_timeDiff), 'r');
hold off;
title('Heart Rate');
xlabel('Time (s)');
ylabel('Heart Rate (bpm)');
legend('Resting HR', 'Active HR');

% Adjust subplot spacing
subplot(2,1,1);
pos = get(gca, 'Position');
set(gca, 'Position', [pos(1) pos(2)+0.05 pos(3) pos(4)-0.05]);

% Calculating theoretical heart rate averages
restHR_theor = 60./rest_timeDiff;
rest_HR_theor_avg = mean(restHR_theor)

activeHR_theor = 60./active_timeDiff;
active_HR_theor_avg = mean(60./(active_timeDiff))
