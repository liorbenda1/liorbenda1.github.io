import { ProjectCard } from '@/components/ProjectCard';
import { Activity, Dna, Droplet, Waves, Layers, Cpu, Eye, Video } from 'lucide-react';

export const metadata = {
    title: 'Projects | Lior Bendavid',
    description: 'Portfolio of engineering applications combining signal analyses, system verifications, and physical implementations.'
};

const projects = [
    {
        title: "Eulerian Video Magnification (Multimodal Signal Validation & rPPG Pipeline)",
        description: "Engineering refactor of an academic rPPG script. Computationally isolates and magnifies subtle color variations in human skin from standard video, correlating with a gold-standard ECG.",
        constraints: "Rest State tracking is decent (MAE ≈ 10 bpm) but Active State performance degrades exponentially due to motion instability (MAE ≈ 30 bpm).",
        tags: ["MATLAB", "Signal Processing", "Video Processing", "Peak Detection"],
        icon: Video,
        category: "Flagship",
        href: "/projects/evm-heart-rate"
    },
    {
        title: "Pediatric Anesthesia Data Analysis (Multimodal Sensor Fusion & Anomaly Detection)",
        description: "Developed a 4-year data analysis pipeline correlating continuous physiological signals (HR, SpO₂) with discrete observational markers to optimize protocols. Applied heavy segmentation, powerline noise reduction, and robust statistical evaluation.",
        constraints: "Required handling extreme signal artifacts due to uncooperative subjects. Validated via rigorous noise-floor thresholding and consensus-driven exclusion heuristics, prioritizing data integrity over sample size.",
        tags: ["MATLAB", "SQL", "Sensor Data", "Signal Processing"],
        icon: Activity,
        category: "Flagship",
        href: "/projects/pediatric-anesthesia"
    },
    {
        title: "Magnetic Vortex Nanodiscs (Magnetomechanical Systems)",
        description: "Evaluated remote mechanical actuation via magnetic nanoparticles. Characterized using Dynamic Light Scattering/VSM and validated via fluorescence imaging pipelines. Proved force viability surpassing mechanosensitive thresholds.",
        constraints: "Prone to nanoparticle aggregation yielding non-uniform force distribution. Validated stability through strict protocol adherence during synthesis and discarding noisy imaging runs demonstrating saturation.",
        tags: ["Systems Biophysics", "Nanomaterials", "Image Processing", "MATLAB"],
        icon: Layers,
        category: "Flagship",
        href: "/projects/nanodiscs"
    },
    {
        title: "Genomics / CRISPR (Stochastic Modeling & Feature Engineering)",
        description: "Predictive modeling of sequence-specific cutting efficiencies using Python and MATLAB architectures. Engineered high-dimensional features incorporating density metrics, spatial bias, and thermodynamic parameters via Random Forest and Lasso regression.",
        constraints: "Dataset highly imbalanced and prone to overfitting. Validated via strict k-fold cross-validation and feature-importance sanity checks to ensure generalizability beyond the training distribution.",
        tags: ["Python", "MATLAB", "Machine Learning", "Feature Engineering"],
        icon: Dna,
        category: "Flagship",
        href: "/projects/igem-crispr"
    },
    {
        title: "3D Printed Artery Models (Fluid Dynamics & Spectral Analysis in Synthetic Systems)",
        description: "Fabricated SLA 3D models of healthy and restricted flow channels in an elastic resin. Analyzed pressure changes and resonance in a closed-loop system capturing dynamic pressure data via LabVIEW and analyzing in MATLAB.",
        constraints: "Synthetic resin compliance deviated from physiological tissue. Validated by calibrating baseline system resonance and focusing calculations exclusively on relative pressure deltas rather than absolute values.",
        tags: ["3D Printing", "Fluid Dynamics", "LabVIEW", "MATLAB"],
        icon: Waves,
        category: "Simulation & Hardware"
    },
    {
        title: "Analog-to-Digital Interfacing & Signal Conditioning",
        description: "Built an instrumentation amplifier circuit to acquire microvolt-level signals, determining proper Bode gain profiles and digitizing analog signals effectively using microcontrollers while complying strictly with Nyquist limits.",
        constraints: "High susceptibility to 50Hz mains noise and environmental EMI. Validated by implementing hardware low-pass filtering, shielded cabling, and software-side digital notch filters, confirming SNR specifications.",
        tags: ["Hardware Engineering", "Signal Conditioning", "Microcontrollers"],
        icon: Cpu,
        category: "Simulation & Hardware"
    },
    {
        title: "Beer-Lambert Absorption Optics",
        description: "Designed a controlled experimental pipeline capturing laser intensity data across solutions natively through mobile CMOS sensors and MATLAB image processing. Quantified attenuation coefficients through automated pixel-intensity extraction.",
        constraints: "Results severely impacted by ambient light variations and glass geometry reflections. Validated by establishing strict dark-room conditions, isolating the region of interest programmatically, and averaging multiple acquisitions.",
        tags: ["Optics", "MATLAB", "Image Processing"],
        icon: Eye,
        category: "Biological & Clinical"
    },
    {
        title: "Cell Culture Proliferation Metrics",
        description: "Rigorous experimental design to optimize substrate concentration for cellular proliferation. Calculated comprehensive scaling mathematics and implemented viability counting pipelines with deep assay repetition logic.",
        constraints: "High variance in manual counting and environmental contamination risks. Validated by implementing blinded counting techniques, rigorous statistical power controls, and discarding trials exhibiting anomalous baseline mortality.",
        tags: ["Experimental Design", "Data Pipelines", "Image Analysis"],
        icon: Droplet,
        category: "Biological & Clinical"
    }
];

export default function ProjectsPage() {
    return (
        <main className="flex-1 w-full max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-16 flex flex-col gap-16">
            <div className="flex flex-col gap-4">
                <h1 className="text-4xl font-heading font-bold text-slate-100">Projects Portfolio</h1>
                <p className="text-lg text-slate-400 max-w-3xl">
                    An overview of my engineering applications combining signal analyses, system verifications, and physical implementations. Select a domain below or browse the full catalogue.
                </p>
            </div>

            <div className="flex flex-col gap-20">
                <section>
                    <div className="flex items-center gap-4 mb-8">
                        <h2 className="text-2xl font-heading font-semibold text-slate-200">Flagship Work</h2>
                        <div className="h-px flex-1 bg-slate-800/60" />
                    </div>
                    <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {projects.filter(p => p.category === "Flagship").map(proj => (
                            <ProjectCard key={proj.title} {...proj} />
                        ))}
                    </div>
                </section>

                <section>
                    <div className="flex items-center gap-4 mb-8">
                        <h2 className="text-2xl font-heading font-semibold text-slate-200 whitespace-nowrap">Hardware & Signal Simulation</h2>
                        <div className="h-px flex-1 bg-slate-800/60" />
                    </div>
                    <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {projects.filter(p => p.category === "Simulation & Hardware").map(proj => (
                            <ProjectCard key={proj.title} {...proj} />
                        ))}
                    </div>
                </section>

                <section>
                    <div className="flex items-center gap-4 mb-8">
                        <h2 className="text-2xl font-heading font-semibold text-slate-200 whitespace-nowrap">Biological & Clinical Contexts</h2>
                        <div className="h-px flex-1 bg-slate-800/60" />
                    </div>
                    <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {projects.filter(p => p.category === "Biological & Clinical").map(proj => (
                            <ProjectCard key={proj.title} {...proj} />
                        ))}
                    </div>
                </section>
            </div>
        </main>
    );
}
