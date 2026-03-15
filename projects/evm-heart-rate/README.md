# Eulerian Video Magnification (EVM) - Heart Rate Estimation Demo (MATLAB)

This repository is a **portfolio-friendly, reproducible refactor** of my B.Sc. project work on estimating heart rate from facial video signals and comparing it to ECG-derived heart rate.

It includes:
- ECG preprocessing + heart rate estimation
- Video ROI signal extraction + heart rate estimation (rPPG-style processing)
- Alignment, error metrics, and plots (including Bland-Altman analysis)
- A single entry script (`run_evm_demo.m`) that produces a `results/` folder with figures and summary tables

---

## How this repo relates to the final report

The submitted final report describes a workflow that used an Eulerian Video Magnification (EVM) implementation ("face/face2") to generate magnified videos before performing ROI extraction, filtering, peak detection, and statistical comparison.

This repository focuses on making the analysis/evaluation pipeline reproducible and easy to run:
- It can read **original videos** (MP4/AVI) directly, or
- It can reuse **pre-generated magnified videos** (AVI) if you already have them.

In short:
- The report documents the original academic submission workflow.
- This repo is a cleaned-up engineering refactor that supports both "original" and "magnified" inputs and reproduces the evaluation + visualization steps.

---

## Requirements

- MATLAB (recent versions)
- Recommended: Signal Processing Toolbox for the filtering/peak utilities used in the demo

---

## Project structure

```text
run_evm_demo.m          # main entry point
src/                    # helper functions
data/
  demo/                 # INCLUDED demo dataset (ECG + videos)
  local/                # optional local files (ignored by git)
results/                # generated outputs (plots + summary.csv)
legacy/                 # original scripts (optional / reference)
```

---

## Demo data included + bring your own data

This repo supports two workflows.

### Mode 1 - Run with the included demo data (default)

A small demo dataset lives under `data/demo/`, so you can observe the full pipeline without providing any files.

1. Open MATLAB in the repository folder.
2. Run:
   ```matlab
   run_evm_demo
   ```
3. Inspect the generated `results/` folder.

### Mode 2 - Bring your own data (videos + ECG)

If you want to process your own recordings:

1. Open `run_evm_demo.m`.
2. Set:
   ```matlab
   cfg.videoMode = "prompt";
   ```
   Running the script will open file pickers so you can choose the "Rest" and "Active" video files.
3. Update the ECG file paths if needed:
   ```matlab
   cfg.ecgRestFile = "path/to/your/rest.txt";
   cfg.ecgActiveFile = "path/to/your/active.txt";
   ```
4. (Optional) Place your files in `data/local/` and update the filenames in the config section to keep things organized.

---

## Quickstart checklist

1. Ensure your ECG files follow the expected plain-text format (`rest*` and `active*` samples in BPM).
2. Place the corresponding videos (original or magnified) somewhere accessible or choose them via the prompt workflow.
3. From MATLAB, run:
   ```matlab
   run_evm_demo
   ```
4. Review the contents of `results/` for figures and CSV summaries.

---

## Outputs

The script generates:

- `summary.csv` - heart rate metrics for Rest and Active segments
- `ecg_signals.png` - filtered ECG traces + detected peaks
- `video_signals.png` - processed ROI signal + detected peaks
- `hr_comparison.png` - aligned ECG HR versus Video HR
- `bland_altman_rest.png`
- `bland_altman_active.png`

---

## Notes

- Videos should be stable, well-lit, and contain a clear face ROI for best rPPG performance.
- If the repo lives in an iCloud/OneDrive synchronized folder, make sure video files are available offline before running MATLAB.
- The `data/` directory is ignored by git so you can safely store private recordings there without committing them.

---

## Large video files (Git LFS)

Some `.mp4`/`.avi` assets may be tracked with Git LFS. If cloning from scratch and the videos are missing, run:

```bash
git lfs install
git lfs pull
```

This ensures magnified videos (if any) are downloaded correctly.
