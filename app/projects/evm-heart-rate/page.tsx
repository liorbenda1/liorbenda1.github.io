import Link from 'next/link';
import { ArrowLeft, Activity, Code, Settings, FileText, AlertTriangle, ExternalLink, Terminal } from 'lucide-react';
import { Badge } from '@/components/Badge';
import Image from 'next/image';

export const metadata = {
    title: 'EVM Heart Rate | Lior Bendavid',
    description: 'Eulerian Video Magnification (Multimodal Signal Validation & rPPG Pipeline).'
};

export default function EVMProjectPage() {
    return (
        <main className="flex-1 w-full max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 flex flex-col gap-16">
            <div className="flex flex-col gap-6">
                <Link href="/projects" className="inline-flex items-center gap-2 text-slate-400 hover:text-teal-400 transition-colors w-fit font-medium text-sm">
                    <ArrowLeft size={16} /> Back to Projects
                </Link>
                <div className="flex flex-col gap-4 mt-4">
                    <h1 className="text-4xl sm:text-5xl font-heading font-extrabold text-slate-100 tracking-tight leading-tight">
                        Eulerian Video Magnification <span className="block text-2xl sm:text-3xl text-teal-400 font-semibold mt-2">(Multimodal Signal Validation & rPPG Pipeline)</span>
                    </h1>
                    <div className="flex flex-wrap gap-2 mt-2">
                        <Badge className="bg-teal-500/10 text-teal-300 border border-teal-500/20">MATLAB</Badge>
                        <Badge className="bg-blue-500/10 text-blue-300 border border-blue-500/20">Signal Processing</Badge>
                        <Badge>Video Processing</Badge>
                        <Badge>Peak Detection</Badge>
                        <Badge>Bland–Altman</Badge>
                    </div>
                </div>
            </div>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <FileText className="text-teal-400 h-6 w-6" /> Executive Summary
                </h2>
                <p className="text-lg text-slate-400 leading-relaxed text-balance">
                    This project is an engineering refactor of an academic rPPG (remote photoplethysmography) script into a robust, reproducible evaluation pipeline. It computationally isolates and magnifies subtle color variations in human skin from standard video, correlates them with a gold-standard ground-truth ECG, and performs rigorous error characterization.
                </p>
                <div className="flex gap-4">
                    <a href="https://github.com/liorbenda1/evm-hr-calculation" target="_blank" rel="noreferrer" className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-teal-500 text-teal-950 font-semibold hover:bg-teal-400 transition-colors">
                        <Code size={18} /> View GitHub Repository
                    </a>
                </div>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Settings className="text-teal-400 h-6 w-6" /> Engineering Contributions
                </h2>
                <ul className="list-disc list-inside space-y-3 text-slate-400 leading-relaxed">
                    <li><strong className="text-slate-200">Reproducibility Architecture:</strong> Structured legacy codebase into a resilient, cross-platform pipeline allowing researchers to seamlessly load and evaluate arbitrary video inputs and ECG texts via automated dialogs.</li>
                    <li><strong className="text-slate-200">Evaluation Framing:</strong> Built automated alignment and visualization logic to evaluate peak-to-peak accuracy against the ground truth.</li>
                    <li><strong className="text-slate-200">Error Surface Mapping:</strong> Integrated automated Bland-Altman statistical analysis loops to clearly decouple systematic bias from variance.</li>
                </ul>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <AlertTriangle className="text-orange-400 h-6 w-6" /> System Limitations & Reality Check
                </h2>
                <div className="bg-orange-950/20 border border-orange-900/30 rounded-xl p-6">
                    <p className="text-orange-200/80 leading-relaxed mb-4">
                        A core tenet of Systems & Signal Engineering is an honest accounting of failure boundary conditions. From the evaluation runs:
                    </p>
                    <ul className="list-disc list-inside space-y-2 text-orange-200/70 text-sm">
                        <li><strong>Rest State (Quasi-Static ROI):</strong> Mean HR tracks relatively well against ECG. However, the video measurement variance remains non-trivial (Mean Absolute Error ≈ 10 bpm) due to inherent hardware noise floors and background illumination bleed.</li>
                        <li><strong>Active State (Dynamic ROI):</strong> Performance degrades exponentially. Motion instability induces systematic underestimation (Mean Absolute Error ≈ 30 bpm). The simple spatial averaging mechanism fails robustly under shear transformations and occlusions.</li>
                    </ul>
                    <p className="text-orange-200/80 leading-relaxed mt-4 italic text-sm">
                        Next steps for a production pipeline would demand spectral HR estimators, dynamic ROI facial milestone tracking, and confidence scoring overlays to reject unreadable frames.
                    </p>
                </div>
            </section>

            <section className="flex flex-col gap-8">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Activity className="text-teal-400 h-6 w-6" /> Validation Gallery
                </h2>

                <div className="grid md:grid-cols-2 gap-8">
                    <div className="flex flex-col gap-3">
                        <div className="relative aspect-video rounded-xl overflow-hidden border border-slate-800 bg-slate-900">
                            {/* In a real app we would use next/image with full path */}
                            <Image src="/projects/evm/Band-Altman_graphs.png" alt="Bland-Altman Statistical Plot" fill className="object-cover" />
                        </div>
                        <p className="text-center text-sm text-slate-400 font-medium">Bland-Altman Statistical Plot characterizing agreement errors.</p>
                    </div>

                    <div className="flex flex-col gap-3">
                        <div className="relative aspect-video rounded-xl overflow-hidden border border-slate-800 bg-slate-900">
                            <Image src="/projects/evm/HRs_ECG-video_aligned.png" alt="Aligned Signals Over Time" fill className="object-cover" />
                        </div>
                        <p className="text-center text-sm text-slate-400 font-medium">Aligned Signal comparison displaying drift correlation.</p>
                    </div>

                    <div className="flex flex-col gap-3 md:col-span-2 max-w-2xl mx-auto w-full">
                        <div className="relative aspect-video rounded-xl overflow-hidden border border-slate-800 bg-slate-900">
                            <Image src="/projects/evm/ECG_video_peaks.png" alt="ECG and Video Peaks" fill className="object-cover" />
                        </div>
                        <p className="text-center text-sm text-slate-400 font-medium">Peak Detection isolation on raw filtered waveforms.</p>
                    </div>
                </div>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Terminal className="text-teal-400 h-6 w-6" /> How to Run
                </h2>
                <p className="text-slate-400 leading-relaxed">
                    Clone the repository into your local MATLAB environment and trigger the simplified entrypoint script.
                </p>
                <div className="bg-[#1e1e1e] border border-slate-800 rounded-xl overflow-hidden">
                    <div className="flex items-center px-4 py-2 border-b border-slate-800 bg-slate-900">
                        <div className="flex gap-2">
                            <div className="w-3 h-3 rounded-full bg-red-500/20"></div>
                            <div className="w-3 h-3 rounded-full bg-yellow-500/20"></div>
                            <div className="w-3 h-3 rounded-full bg-green-500/20"></div>
                        </div>
                        <span className="ml-4 text-xs font-mono text-slate-500">MATLAB Console</span>
                    </div>
                    <div className="p-4 overflow-x-auto">
                        <pre className="text-sm font-mono text-slate-300 leading-relaxed">
                            <code><span className="text-teal-400">% 1. Clone repository & enter directory</span>
                                cd('evm-hr-calculation')

                                <span className="text-teal-400">% 2. Execute main pipeline script</span>
                                <span className="text-blue-400">run</span> run_evm_demo

                                <span className="text-teal-400">% 3. To run with a custom local video file</span>
                                <span className="text-slate-300">cfg.videoMode = </span><span className="text-orange-300">"prompt"</span><span className="text-slate-300">;</span></code>
                        </pre>
                    </div>
                </div>
            </section>
        </main>
    );
}
