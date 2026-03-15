%% Load video

rest_video = VideoReader('restHR2.mp4');
active_video = VideoReader('activeHR2.mp4');

rest_video_mag = VideoReader('restHR2-ideal-from-1-to-3.7-alpha-80-level-7-chromAtn-1.avi');
active_video_mag = VideoReader('activeHR2-ideal-from-1-to-3.7-alpha-100-level-6-chromAtn-1.avi');

% rest_video_mag = VideoReader('restHR2-ideal-from-0.91667-to-1.0833-alpha-80-level-7-chromAtn-1.avi');
% active_video_mag = VideoReader('activeHR2-ideal-from-1.8333-to-2.25-alpha-100-level-6-chromAtn-1.avi');

% Defining time parameters
fs_vid = 30;
ts_vid = 1/fs_vid;
t_restVid = 0:ts_vid:(length(restECG)-1)*ts_vid;
t_activeVid = 0:ts_vid:(length(activeECG)-1)*ts_vid;

%% ROI
original_restFrame = readFrame(rest_video);

% Displaying the frame
figure();
imshow(original_restFrame);

% ROI - drawing rectangle
restPosition = [590 85 60 30];
hold on
restForehead_mag = images.roi.Rectangle(gca,'Position',restPosition); 
hold off

% Displaying the forehead at rest
figure();
restForehead_mag = imcrop(original_restFrame,restPosition);
imshow(restForehead_mag);



original_activeFrame = readFrame(active_video);
% Displaying the frame
figure();
imshow(original_activeFrame);
% ROI - drawing rectangle
activePosition = [600 80 60 30];
hold on
activeForehead = images.roi.Rectangle(gca,'Position',activePosition); 
hold off

% Displaying the forehead at rest
figure();
activeForehead = imcrop(original_activeFrame,activePosition);
imshow(activeForehead);
%% First 30 Frames of the Original Rest Video

% First 30 Frames of the Original Video with ROI
figure();
for i = 1:30
    restFrames = read(rest_video, i);
    rest_roiFrame = imcrop(restFrames, restPosition);
    subplot(5, 6, i);
    imshow(rest_roiFrame);
    title(sprintf('Frame %d', i));
end

sgt = sgtitle('First 30 Frames of Original Rest Video (ROI)');
sgt.FontSize = 12;

%% First 30 Frames of the Original Active Video (for some reason, when run in
% succesion with the previous block, the 1 graph comes up blanks, but when
% run one by one, the graphs produce normally)

figure();
for i = 1:30
    activeFrames = read(active_video, i);
    active_roiFrame = imcrop(activeFrames, activePosition);
    subplot(5, 6, i);
    imshow(active_roiFrame);
    title(sprintf('Frame %d', i));
end
sgt2 = sgtitle('First 30 Frames of Original Active Video (ROI)');
sgt2.FontSize = 12;







%% First 30 Frames of the Magnified Video

% First 30 Frames of the Magnified Video with ROI
figure();
for i = 1:30
    magnified_restFrames = read(rest_video_mag, i);
    rest_roiFrame = imcrop(magnified_restFrames, restPosition);
    subplot(5, 6, i);
    imshow(rest_roiFrame);
    title(sprintf('Frame %d', i));
end
sgt = sgtitle('First 30 Frames of the Magnified Rest Video (ROI)');
sgt.FontSize = 12;


figure();
for i = 1:30
    magnified_activeFrames = read(active_video_mag, i);
    active_roiFrame = imcrop(magnified_activeFrames, activePosition);
    subplot(5, 6, i);
    imshow(active_roiFrame);
    title(sprintf('Frame %d', i));
end
sgt = sgtitle('First 30 Frames of the Magnified Active Video (ROI)');
sgt.FontSize = 12;


%% RGB

i = 1;
while hasFrame(rest_video_mag)
    restFrame_mag = readFrame(rest_video_mag);
    restForehead_mag = imcrop(restFrame_mag, restPosition);
    R_rest(i) = mean(restForehead_mag(:,:,1),'all');
    G_rest(i) = mean(restForehead_mag(:,:,2),'all');
    B_rest(i) = mean(restForehead_mag(:,:,3),'all');
    i = i + 1;
end
% Showing the RGB signals
figure();
hold on
plot(R_rest,'r');
plot(G_rest,'g');
plot(B_rest,'b');
title('RGB Signals as a Function of the Rest Video Frames');
xlabel('Frame');
ylabel('Power');
legend('Red','Green','Blue');
hold off


i = 1;
while hasFrame(active_video_mag)
    activeFrame_mag = readFrame(active_video_mag);
    activeForehead_mag = imcrop(activeFrame_mag, activePosition);
    R_active(i) = mean(activeForehead_mag(:,:,1),'all');
    G_active(i) = mean(activeForehead_mag(:,:,2),'all');
    B_active(i) = mean(activeForehead_mag(:,:,3),'all');
    i = i + 1;
end

% Showing the RGB signals
figure();
hold on
plot(R_active,'r');
plot(G_active,'g');
plot(B_active,'b');
title('RGB signals as a Funtion of the Active Video Frames');
xlabel('Frame');
ylabel('Power');
legend('Red','Green','Blue');
hold off


%%
t_rest = 0:ts_vid:rest_video_mag.Duration;
t_rest = t_rest(1:length(R_rest));

t_active = 0:ts_vid:active_video_mag.Duration;
t_active = t_active(1:length(R_active));


%% Cleaning Red color signals

windowSize = 5;  

% Apply moving average filter
filtered_R_rest = movmean(R_rest, windowSize);
filtered_R_active = movmean(R_active, windowSize);

% Plot the original and filtered signals
plot(t_active, R_active, 'b', t_active, filtered_R_active, 'r');
legend('Original Signal', 'Filtered Signal');
xlabel('Time');
ylabel('Signal Amplitude');

%% Finding peaks of Red signal

[restVideoPks, restVideoPksLocs] = findpeaks(filtered_R_rest, 'MinPeakDistance', 7);
[activeVideoPks, activeVideoPksLocs] = findpeaks(filtered_R_active, 'MinPeakDistance', 7);

% Displaying the filtered data and its peaks

figure();
plot(t_rest, filtered_R_rest, t_rest(restVideoPksLocs), restVideoPks, 'o');
title('EVM signal - Rest');
xlabel('Time [sec]');
ylabel('Voltage [mV]');

figure();
plot(t_active, filtered_R_active, t_active(activeVideoPksLocs), activeVideoPks, 'o');
title('EVM signal - Active');
xlabel('Time [sec]');
ylabel('Voltage [mV]');


%% Calculating HR

rest_video_diff = diff(t_rest(restVideoPksLocs));
restHR_vid = 60./rest_video_diff;
restHR_vid_avg = mean(restHR_vid)

active_video_diff = diff(t_active(activeVideoPksLocs));
activeHR_vid = 60./active_video_diff;
activeHR_vid_avg = mean(activeHR_vid)



%% Graphing heart rates from ECG and video
figure();
subplot(2, 1, 1);
plot(restTime(restPkLocs(1:end-1)), restHR_theor, 'b');
hold on;
plot(t_restVid(restVideoPksLocs(1:end-1)), restHR_vid, 'r');
legend('ECG','VIDEO');
title('Resting Heart Rate');
xlabel('Time [sec]');
ylabel('Heart Rate [BPM]');
hold off;

subplot(2, 1, 2);
plot(activeTime(activePkLocs(1:end-1)), activeHR_theor, 'b');
hold on;
plot(t_activeVid(activeVideoPksLocs(1:end-1)), activeHR_vid, 'r');
legend('ECG','VIDEO');
title('Active Heart Rate');
xlabel('Time [sec]');
ylabel('Heart Rate [BPM]');
hold off;



%% Calculating statistics of ECG HR and Video HR

% Relative Error

restHR_rel_err = abs(rest_HR_theor_avg - restHR_vid_avg)...
    / rest_HR_theor_avg;

activeHR_rel_err = abs(active_HR_theor_avg - activeHR_vid_avg)...
    / active_HR_theor_avg;


% STD

restHR_ECG_STD = std(restHR_theor);
restHR_vid_STD = std(restHR_vid);

activeHR_ECG_STD = std(activeHR_theor);
activeHR_vid_STD = std(activeHR_vid);

% t-test

[h_rest, pval_rest, ci_rest, tstats_rest] = ttest(restHR_theor, restHR_vid(1:33));
[h_active, pval_active, ci_active, tstats_active] = ttest(activeHR_theor, activeHR_vid(1:50));

% putting statistics together

stat_titles = { 'Average HR - ECG' ; 'Average HR - EVM' ; 'Relative Error' ;...
    'P-Value' ; 'Hypothesis' ; 'STD - ECG' ; 'STD - EVM'};
rest = [ rest_HR_theor_avg ; restHR_vid_avg ; restHR_rel_err ;...
    pval_rest ; h_rest ; restHR_ECG_STD ; restHR_vid_STD ];
active = [ active_HR_theor_avg ; activeHR_vid_avg ; activeHR_rel_err ;...
    pval_active; h_active ; activeHR_ECG_STD ; activeHR_vid_STD ];
Table = table(stat_titles , rest , active)


%% Bland & Altman method
[rest_data_mean, rest_data_diff, rest_md, rest_sd] = ...
    bland_altman_R(restHR_theor, restHR_vid(1:33)');
[active_data_mean, active_data_diff, active_md, active_sd] = ...
    bland_altman_E(activeHR_theor, activeHR_vid(1:50)');


