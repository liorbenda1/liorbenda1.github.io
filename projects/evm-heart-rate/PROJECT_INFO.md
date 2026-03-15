I’m building a portfolio website. Continue from my existing site structure and add a project page/section for my MATLAB project repo:

Repo: liorbenda1/evm-hr-calculation on GitHub (MATLAB project)

Context / What we did

We took my original university project code (EVM/rPPG heart-rate from face video + compare vs ECG) and refactored it into a portfolio-friendly, reproducible repository:

Created a single entry script: run_evm_demo.m

Organized helpers under src/

Added plotting and evaluation outputs:

summary.csv

ECG peaks plots

processed video ROI signal + peaks

HR comparison plot (aligned ECG vs video)

Bland–Altman plots (rest + active)

Fixed multiple robustness issues:

paths based on mfilename('fullpath') (not pwd)

results dir permissions fallback to userpath/EVM_results if needed

fixed broken README markdown (missing code fence closures)

implemented video input toggle using cfg.videoMode:

"original" uses MP4/AVI

"magnified" uses pre-generated EVM magnified AVIs if available

"prompt" opens a file picker so other users can run with their own videos

Removed a bug where the script prompted for videos then overwrote restVidPath/activeVidPath with hard-coded filenames. Now it uses the selected/appropriate paths.

Added ECG “prompt if missing” behavior (file picker) so others can bring their own ECG text files too.

We aligned the repo narrative with my final academic report by explicitly stating:

The report used course EVM (“face/face2”) to generate magnified videos.

This repo is an engineering refactor focused on the analysis + evaluation pipeline, and supports both original and magnified inputs.

Key results (to describe honestly)

From my runs:

Rest: mean HR close to ECG, but tracking is noisy (video variance higher; MAE around ~10 bpm).

Active: performance degrades significantly (systematic underestimation; MAE ~30 bpm). Motion/ROI instability likely dominates.
This is still portfolio-worthy because I quantified performance, visualized errors, and explained limitations.

What I want on the website

Create a clean portfolio project entry/page with:

Short summary (what it is, why it matters)

My contributions (refactor + reproducibility + evaluation)

Tech stack (MATLAB, signal processing, video processing, peak detection, Bland–Altman)

Outputs/figures section (embed 1–2 key images if available, otherwise placeholders)

HR comparison plot

Bland–Altman plot (rest or active)

Links:

GitHub repo link

Optional: link to the final report PDF if I provide it

A short “Limitations & next steps” section:

motion robustness, ROI tracking, better rPPG color normalization, spectral HR estimator, confidence scoring

Keep it consistent with my site style: modern, dark vibes, clean grid cards, minimal text, strong headings.

Implementation notes for the site

Add a project card on the main projects grid and a dedicated project detail page (or modal).

Include a “Run it locally” snippet (very short):

run run_evm_demo

set cfg.videoMode="prompt" for user data

Do NOT dump all code; link to GitHub instead.

Generate the website content + layout markup consistent with my existing portfolio framework.