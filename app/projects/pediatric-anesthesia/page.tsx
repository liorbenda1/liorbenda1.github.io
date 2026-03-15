import Link from 'next/link';
import { ArrowLeft, Activity, Database, Server, ShieldCheck, BarChart } from 'lucide-react';
import { Badge } from '@/components/Badge';

export const metadata = {
    title: 'Pediatric Anesthesia Data Analysis | Lior Bendavid',
    description: 'Multimodal Sensor Fusion & Anomaly Detection.'
};

export default function PediatricAnesthesiaPage() {
    return (
        <main className="flex-1 w-full max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 flex flex-col gap-16">
            <div className="flex flex-col gap-6">
                <Link href="/projects" className="inline-flex items-center gap-2 text-slate-400 hover:text-teal-400 transition-colors w-fit font-medium text-sm">
                    <ArrowLeft size={16} /> Back to Projects
                </Link>
                <div className="flex flex-col gap-4 mt-4">
                    <h1 className="text-4xl sm:text-5xl font-heading font-extrabold text-slate-100 tracking-tight leading-tight">
                        Pediatric Anesthesia Data Analysis <span className="block text-2xl sm:text-3xl text-teal-400 font-semibold mt-2">(Multimodal Signal Validation & Anomaly Detection)</span>
                    </h1>
                    <div className="flex flex-wrap gap-2 mt-2">
                        <Badge className="bg-teal-500/10 text-teal-300 border border-teal-500/20">Systems Architecture</Badge>
                        <Badge className="bg-blue-500/10 text-blue-300 border border-blue-500/20">Risk Mitigation</Badge>
                        <Badge>SQL / Relational Data</Badge>
                        <Badge>MATLAB</Badge>
                        <Badge>Sensor Integration</Badge>
                    </div>
                </div>
            </div>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <ShieldCheck className="text-teal-400 h-6 w-6" /> 1. Engineering Challenge
                </h2>
                <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6">
                    <h3 className="text-lg font-medium text-slate-200 mb-3">High-Stakes Data Acquisition in Variable Environments</h3>
                    <p className="text-slate-400 leading-relaxed text-balance">
                        Acquiring reliable subject telemetry in unconstrained, variable environments presents a critical engineering bottleneck. The challenge was to design and validate a fault-tolerant monitoring framework capable of isolating genuine physiological signals (Heart Rate, SpO₂) from high-amplitude noise induced by subject movement and environmental interference over a longitudinal, 4-year data acquisition lifecycle.
                    </p>
                </div>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Server className="text-teal-400 h-6 w-6" /> 2. System Architecture
                </h2>
                <div className="grid md:grid-cols-2 gap-6">
                    <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6 flex flex-col gap-4">
                        <div className="flex items-center gap-3">
                            <Activity className="text-blue-400" size={24} />
                            <h3 className="text-lg font-medium text-slate-200">Hardware & Sensor Integration</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Deployed a multi-node sensor array featuring high-fidelity pulse oximetry (Nellcor N550) synchronized with precise, computer-controlled local anesthesia delivery systems (STA architecture). Raw sensor telemetry was continuously buffered and streamed to a centralized acquisition hub.
                        </p>
                    </div>

                    <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6 flex flex-col gap-4">
                        <div className="flex items-center gap-3">
                            <Database className="text-purple-400" size={24} />
                            <h3 className="text-lg font-medium text-slate-200">Software & Logical Pipelines</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Engineered a robust, heavily-segmented ETL pipeline. Relational databases (SQL) managed multi-year structured datasets, while MATLAB handled aggressive powerline noise filtration, semi-automated heuristic exclusions for movement artifact boundaries, and statistical validation logic.
                        </p>
                    </div>
                </div>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <BarChart className="text-teal-400 h-6 w-6" /> 3. Quantitative Impact
                </h2>
                <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6">
                    <p className="text-slate-400 leading-relaxed mb-4">
                        The validated architecture delivered statistically significant insights, fundamentally shifting system-level safety protocols and operational risk mitigation strategies:
                    </p>
                    <ul className="list-disc list-inside space-y-3 text-slate-400 leading-relaxed">
                        <li><strong className="text-slate-200">System State Discrepancies:</strong> Quantified acute deviations in average subject telemetry during distress anomalies (e.g., peak distress indicators forced 37% and 30% baseline variance), creating analytical baselines for anomaly-prediction models.</li>
                        <li><strong className="text-slate-200">Risk Mitigation Frameworks:</strong> Statistically evaluated the interaction variables between mechanical delivery methods and specific environmental limits (e.g., adrenaline administration caps), establishing rigid safety envelopes for subsequent operations.</li>
                        <li><strong className="text-slate-200">Longitudinal Data Integrity:</strong> Validated the long-term stability of the sensor integration framework over 4 continuous years of field testing, yielding actionable, decision-grade operational records.</li>
                    </ul>
                </div>
            </section>

        </main>
    );
}
