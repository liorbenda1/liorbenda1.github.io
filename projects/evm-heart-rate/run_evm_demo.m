%% run_evm_demo.m
% Portfolio-friendly demo entry point for:
% - ECG HR estimation (rest + active)
% - Video ROI extraction + HR estimation (rest + active)
% - Comparison plots + summary statistics

clc; close all;

% Resolve project paths based on this script location (NOT the current folder)
projectRoot = fileparts(mfilename("fullpath"));
addpath(genpath(fullfile(projectRoot, "src")));

%% Configuration
cfg = struct();

% --- Path setup ---
cfg.projectRoot = fileparts(mfilename('fullpath'));   % folder containing run_evm_demo.m
cfg.dataDir = fullfile(projectRoot, "data", "demo");   % default: use included demo dataset

% Prefer saving inside the project if writable; otherwise fallback to userpath
cfg.resultsDir  = fullfile(cfg.projectRoot, 'results');
if ~exist(cfg.resultsDir, 'dir'); mkdir(cfg.resultsDir); end

% Write-permission check + fallback
try
    testfile = fullfile(cfg.resultsDir, '_write_test.tmp');
    fid = fopen(testfile, 'w');  assert(fid ~= -1);
    fclose(fid); delete(testfile);
catch
    cfg.resultsDir = fullfile(userpath, 'EVM_results');
    if ~exist(cfg.resultsDir, 'dir'); mkdir(cfg.resultsDir); end
end

% Data folder is relative to the repo
cfg.dataDir = fullfile(projectRoot, "data", "demo");   % keep data out of git

% Results: prefer ./results (inside repo) if writable; otherwise fallback to userpath
repoResultsDir = fullfile(projectRoot, "results");
cfg.resultsDir = repoResultsDir;

try
    if ~exist(cfg.resultsDir, "dir"); mkdir(cfg.resultsDir); end
    fid = fopen(fullfile(cfg.resultsDir, ".write_test"), "w");
    if fid < 0; error("Cannot write to results dir"); end
    fclose(fid);
    delete(fullfile(cfg.resultsDir, ".write_test"));
catch
    up = userpath;
    if contains(up, ";"); up = extractBefore(up, ";"); end
    cfg.resultsDir = fullfile(up, "EVM_results");
    if ~exist(cfg.resultsDir, "dir"); mkdir(cfg.resultsDir); end
end

fprintf('Project root: %s\n', char(cfg.projectRoot));
fprintf('Data dir:     %s\n', char(cfg.dataDir));
fprintf('Results dir:  %s\n', char(cfg.resultsDir));

cfg.ecgRestFile   = fullfile(cfg.dataDir, "restHR.txt");
cfg.ecgActiveFile = fullfile(cfg.dataDir, "activeHR.txt");

cfg.videoRestFile   = fullfile(cfg.dataDir, "restHR1.mp4");
cfg.videoActiveFile = fullfile(cfg.dataDir, "activeHR1.mp4");

% --- Video input mode ---
% "original"  -> use cfg.videoRestFile / cfg.videoActiveFile
% "magnified" -> use cfg.videoRestMagFile / cfg.videoActiveMagFile (pre-generated EVM outputs)
% "prompt"    -> ask the user to pick files via file dialog
cfg.videoMode = "original";
cfg.videoPromptIfMissing = true;

% Optional magnified video filenames (only used when videoMode="magnified")
cfg.videoRestMagFile   = fullfile(cfg.dataDir, "rest_mag.avi");
cfg.videoActiveMagFile = fullfile(cfg.dataDir, "active_mag.avi");

% ECG sampling rate (Hz)
cfg.fsECG = 1000;

% ECG preprocessing
cfg.useNotch = true;
cfg.mainsHz  = 50;          % Israel: 50 Hz (set 60 if needed)
cfg.ecgBandpassHz = [0.5 40];

% Video signal options
cfg.channel = "G";          % "R" / "G" / "B" (green often best for rPPG)
cfg.videoBandpassBPM = [42 180];  % passband in bpm
cfg.smoothWinSec = 0.25;    % moving average window (seconds)

% Peak detection constraints (physiology)
cfg.minHRbpm = 40;
cfg.maxHRbpm = 180;

% ROI: either preset rectangle [x y w h] or empty to pick interactively
cfg.roiRestPreset   = [];   % e.g. [590 85 60 30]
cfg.roiActivePreset = [];

% Analysis duration (seconds). Set [] to use full signals.
cfg.maxDurationSec = 30;


%% Load ECG + estimate HR
if ~isfile(cfg.ecgRestFile) || ~isfile(cfg.ecgActiveFile)
    fprintf("ECG files missing. Please select REST and ACTIVE ECG .txt files...\n");
    [f1,p1] = uigetfile({'*.txt','ECG text (*.txt)'}, 'Select REST ECG file', cfg.dataDir);
    assert(~isequal(f1,0), "No REST ECG selected.");
    cfg.ecgRestFile = fullfile(p1,f1);

    [f2,p2] = uigetfile({'*.txt','ECG text (*.txt)'}, 'Select ACTIVE ECG file', cfg.dataDir);
    assert(~isequal(f2,0), "No ACTIVE ECG selected.");
    cfg.ecgActiveFile = fullfile(p2,f2);
end

assert_file_exists(cfg.ecgRestFile);
assert_file_exists(cfg.ecgActiveFile);

[restECG, tRestECG]     = read_ecg_txt(cfg.ecgRestFile,   cfg.fsECG, cfg.maxDurationSec);
[activeECG, tActiveECG] = read_ecg_txt(cfg.ecgActiveFile, cfg.fsECG, cfg.maxDurationSec);

restECG_f   = preprocess_ecg(restECG,   cfg.fsECG, cfg.ecgBandpassHz, cfg.useNotch, cfg.mainsHz);
activeECG_f = preprocess_ecg(activeECG, cfg.fsECG, cfg.ecgBandpassHz, cfg.useNotch, cfg.mainsHz);

[restHR_ecg, tRestHR_ecg, restPkLocs]         = estimate_hr_from_ecg(restECG_f,   tRestECG,   cfg.fsECG, cfg.maxHRbpm);
[activeHR_ecg, tActiveHR_ecg, activePkLocs]   = estimate_hr_from_ecg(activeECG_f, tActiveECG, cfg.fsECG, cfg.maxHRbpm);


%% Resolve video inputs (original / magnified / prompt)

mode = lower(string(cfg.videoMode));

if mode == "magnified"
    restVidPath   = cfg.videoRestMagFile;
    activeVidPath = cfg.videoActiveMagFile;
elseif mode == "original"
    restVidPath   = cfg.videoRestFile;
    activeVidPath = cfg.videoActiveFile;
elseif mode == "prompt"
    restVidPath   = "";
    activeVidPath = "";
else
    error('cfg.videoMode must be "original", "magnified", or "prompt".');
end

% If missing, optionally prompt the user to select files
if (~isfile(restVidPath) || ~isfile(activeVidPath)) && cfg.videoPromptIfMissing
    fprintf("Video files missing for mode=%s. Please select them...\n", mode);

    [f1,p1] = uigetfile({'*.mp4;*.avi','Video files (*.mp4, *.avi)'}, 'Select REST video', cfg.dataDir);
    assert(~isequal(f1,0), "No REST video selected.");
    restVidPath = fullfile(p1,f1);

    [f2,p2] = uigetfile({'*.mp4;*.avi','Video files (*.mp4, *.avi)'}, 'Select ACTIVE video', cfg.dataDir);
    assert(~isequal(f2,0), "No ACTIVE video selected.");
    activeVidPath = fullfile(p2,f2);
end

% Final hard check
assert_file_exists(restVidPath);
assert_file_exists(activeVidPath);

[restSig, tRestVid, roiRest]       = read_video_roi_rgb(restVidPath, cfg.channel, cfg.roiRestPreset, cfg.maxDurationSec);
[activeSig, tActiveVid, roiActive] = read_video_roi_rgb(activeVidPath, cfg.channel, cfg.roiActivePreset, cfg.maxDurationSec);

fsRestVid = 1/mean(diff(tRestVid));
fsActiveVid = 1/mean(diff(tActiveVid));

restSig_f   = preprocess_video_signal(restSig, fsRestVid, cfg.videoBandpassBPM, cfg.smoothWinSec);
activeSig_f = preprocess_video_signal(activeSig, fsActiveVid, cfg.videoBandpassBPM, cfg.smoothWinSec);

[restHR_vid, tRestHR_vid, restVidPkLocs]         = estimate_hr_from_video(restSig_f, tRestVid, fsRestVid, cfg.maxHRbpm);
[activeHR_vid, tActiveHR_vid, activeVidPkLocs]   = estimate_hr_from_video(activeSig_f, tActiveVid, fsActiveVid, cfg.maxHRbpm);

%% Compare (align + metrics)
restMetrics   = compare_hr(tRestHR_ecg, restHR_ecg, tRestHR_vid, restHR_vid, "Rest");
activeMetrics = compare_hr(tActiveHR_ecg, activeHR_ecg, tActiveHR_vid, activeHR_vid, "Active");

summaryTbl = metrics_to_table(restMetrics, activeMetrics);
disp(summaryTbl);
writetable(summaryTbl, fullfile(cfg.resultsDir, "summary.csv"));

%% FIGURE 1: ECG signals + detected peaks
figure(1); clf;
subplot(2,1,1);
plot(tRestECG, restECG_f); hold on;
plot(tRestECG(restPkLocs), restECG_f(restPkLocs), 'o'); hold off;
title('Rest ECG (filtered) + Peaks');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(tActiveECG, activeECG_f); hold on;
plot(tActiveECG(activePkLocs), activeECG_f(activePkLocs), 'o'); hold off;
title('Active ECG (filtered) + Peaks');
xlabel('Time (s)'); ylabel('Amplitude');

%% FIGURE 2: Video ROI signal (processed) + peaks
figure(2); clf;
subplot(2,1,1);
plot(tRestVid, restSig_f); hold on;
plot(tRestVid(restVidPkLocs), restSig_f(restVidPkLocs), 'o'); hold off;
title(sprintf('Rest Video ROI Signal (%s channel) + Peaks', cfg.channel));
xlabel('Time (s)'); ylabel('a.u.');

subplot(2,1,2);
plot(tActiveVid, activeSig_f); hold on;
plot(tActiveVid(activeVidPkLocs), activeSig_f(activeVidPkLocs), 'o'); hold off;
title(sprintf('Active Video ROI Signal (%s channel) + Peaks', cfg.channel));
xlabel('Time (s)'); ylabel('a.u.');

%% FIGURE 3: HR comparison (aligned)
figure(3); clf;
subplot(2,1,1);
plot(restMetrics.t, restMetrics.ecg, '-'); hold on;
plot(restMetrics.t, restMetrics.vid, '-'); hold off;
title('Rest HR: ECG vs Video (aligned)');
xlabel('Time (s)'); ylabel('HR (bpm)');
legend('ECG','Video');

subplot(2,1,2);
plot(activeMetrics.t, activeMetrics.ecg, '-'); hold on;
plot(activeMetrics.t, activeMetrics.vid, '-'); hold off;
title('Active HR: ECG vs Video (aligned)');
xlabel('Time (s)'); ylabel('HR (bpm)');
legend('ECG','Video');

%% FIGURE 4-5: Bland–Altman
bland_altman(restMetrics.ecg, restMetrics.vid, 4, "Bland–Altman: Rest (Video - ECG)");
bland_altman(activeMetrics.ecg, activeMetrics.vid, 5, "Bland–Altman: Active (Video - ECG)");

%% Save figures
saveas(figure(1), fullfile(cfg.resultsDir, "ecg_signals.png"));
saveas(figure(2), fullfile(cfg.resultsDir, "video_signals.png"));
saveas(figure(3), fullfile(cfg.resultsDir, "hr_comparison.png"));
saveas(figure(4), fullfile(cfg.resultsDir, "bland_altman_rest.png"));
saveas(figure(5), fullfile(cfg.resultsDir, "bland_altman_active.png"));

%% Print ROI (for reproducibility)
fprintf("\nROI Rest   = [%d %d %d %d]\n", round(roiRest));
fprintf("ROI Active = [%d %d %d %d]\n\n", round(roiActive));
