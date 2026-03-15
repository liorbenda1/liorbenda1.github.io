%% Load video

video = VideoReader('restHR2.mp4');

% rest_video_mag = VideoReader('restHR2-ideal-from-1-to-3.7-alpha-80-level-7-chromAtn-1.avi');


video_mag = VideoReader('restHR2-butter-from-0.5-to-10-alpha-80-lambda_c-80-chromAtn-0.avi');

% Defining time parameters
fs_vid = 30;
ts_vid = 1/fs_vid;
t_vid = 0:ts_vid:video_mag.Duration;


%% ROI
original_Frame = readFrame(video);

% Displaying the frame
figure();
imshow(original_Frame);

% ROI - drawing rectangle
Position = [280 373 600 350];
hold on
Forehead_mag = images.roi.Rectangle(gca,'Position',Position); 
hold off

% Displaying the forehead at rest
figure();
Forehead_mag = imcrop(original_Frame,Position);
imshow(Forehead_mag);


%% First 30 Frames of the Original Rest Video

% First 30 Frames of the Original Video with ROI
figure();
for i = 1:30
    Frames = read(video, i);
    roiFrame = imcrop(Frames, Position);
    subplot(5, 6, i);
    imshow(roiFrame);
    title(sprintf('Frame %d', i));
end

sgt = sgtitle('First 30 Frames of Original Video (ROI)');
sgt.FontSize = 12;




%% First 30 Frames of the Magnified Video

% First 30 Frames of the Magnified Video with ROI
figure();
for i = 1:30
    magnified_Frames = read(video_mag, i);
    roiFrame = imcrop(magnified_Frames, Position);
    subplot(5, 6, i);
    imshow(roiFrame);
    title(sprintf('Frame %d', i));
end
sgt = sgtitle('First 30 Frames of the Magnified Rest Video (ROI)');
sgt.FontSize = 12;



%% RGB

i = 1;
while hasFrame(video_mag)
    Frame_mag = readFrame(video_mag);
    Forehead_mag = imcrop(Frame_mag, Position);
    R(i) = mean(Forehead_mag(:,:,1),'all');
    G(i) = mean(Forehead_mag(:,:,2),'all');
    B(i) = mean(Forehead_mag(:,:,3),'all');
    i = i + 1;
end
% Showing the RGB signals
figure();
hold on
plot(R,'r');
plot(G,'g');
plot(B,'b');
title('RGB Signals as a Function of the Video Frames');
xlabel('Frame');
ylabel('Power');
legend('Red','Green','Blue');
hold off


%%
t_R = t_vid(1:length(R));
% Define the window size for the moving average filter
windowSize = 25; % Adjust the window size as needed

% Apply the moving average filter to the signal
smoothed_R = movmean(R, windowSize);

plot(t_R, R, 'b', t_R, smoothed_R, 'r');
legend('Original Signal', 'Filtered Signal');
xlabel('Time');
ylabel('Signal Amplitude');

%% Cleaning Red color signals

% 
% % Define the specifications of the bandpass filter
% fpass = [0.1 1]; % Passband frequencies (in Hz)
% order = 2; % Filter order
% 
% % Design bandpass filter using the specifications
% filterObj = designfilt('bandpassiir', 'FilterOrder', order, 'HalfPowerFrequency1', fpass(1), 'HalfPowerFrequency2', fpass(2), 'SampleRate', fs_vid);
% filtered_R = filtfilt(filterObj, smoothed_R);
% % Plot the original and filtered signals
% plot(t_R, R, 'b', t_R, filtered_R, 'r', t_R,  smoothed_R, 'm');
% legend('Original Signal', 'Filtered Signal');
% xlabel('Time');
% ylabel('Signal Amplitude');


%% Finding peaks of Red signal

[VideoPks, VideoPksLocs] = findpeaks(smoothed_R, 'MinPeakProminence', 3.5, 'MinPeakDistance', 70);

% Displaying the filtered data and its peaks

figure();
plot(t_R, smoothed_R, t_R(VideoPksLocs), VideoPks, 'o');
title('EVM signal - Rest');
xlabel('Time [sec]');
ylabel('Voltage [mV]');


%% Calculating HR

video_diff = diff(t_vid(VideoPksLocs));
RR_vid = 60./video_diff;
RR_vid_avg = mean(RR_vid)


