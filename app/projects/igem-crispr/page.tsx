import Link from 'next/link';
import { ArrowLeft, Dna, Database, Network, Binary, CheckCircle, Activity } from 'lucide-react';
import { Badge } from '@/components/Badge';

export const metadata = {
    title: 'CRISPR-Cas9 Mutation Predictor | Lior Bendavid',
    description: 'Machine Learning & Genomic Data Engineering for predictive biological modeling.'
};

export default function IgemCrisprPage() {
    return (
        <main className="flex-1 w-full max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 flex flex-col gap-16">
            <div className="flex flex-col gap-6">
                <Link href="/projects" className="inline-flex items-center gap-2 text-slate-400 hover:text-teal-400 transition-colors w-fit font-medium text-sm">
                    <ArrowLeft size={16} /> Back to Projects
                </Link>
                <div className="flex flex-col gap-4 mt-4">
                    <h1 className="text-4xl sm:text-5xl font-heading font-extrabold text-slate-100 tracking-tight leading-tight">
                        CRISPR-Cas9 Mutation Predictor <span className="block text-2xl sm:text-3xl text-teal-400 font-semibold mt-2">(Machine Learning & Genomic Data Engineering)</span>
                    </h1>
                    <div className="flex flex-wrap gap-2 mt-2">
                        <Badge className="bg-teal-500/10 text-teal-300 border border-teal-500/20">Machine Learning</Badge>
                        <Badge className="bg-blue-500/10 text-blue-300 border border-blue-500/20">Random Forest</Badge>
                        <Badge>Feature Engineering</Badge>
                        <Badge>MATLAB</Badge>
                        <Badge>Python</Badge>
                    </div>
                </div>
            </div>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <CheckCircle className="text-teal-400 h-6 w-6" /> 1. The Challenge
                </h2>
                <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6">
                    <h3 className="text-lg font-medium text-slate-200 mb-3">Predictive Modeling in Non-Linear Biological Systems</h3>
                    <p className="text-slate-400 leading-relaxed text-balance">
                        Predicting the precise probability of a CRISPR-Cas9 complex inducing a mutation at a specific genomic target is a highly complex, multi-variable problem. The engineering challenge was to build a reliable predictive model driven by extracted high-signal mathematical features, isolating the deterministic physical and structural properties of DNA from within a deeply stochastic biological environment.
                    </p>
                </div>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Database className="text-teal-400 h-6 w-6" /> 2. Data Processing Pipeline
                </h2>
                <div className="bg-[#111827] border border-slate-800 rounded-xl p-6">
                    <p className="text-slate-400 leading-relaxed mb-4">
                        The foundation of the model relied on a clean, deterministic data pipeline to handle massive genomic payloads natively in MATLAB:
                    </p>
                    <ul className="list-disc list-inside space-y-3 text-slate-400 leading-relaxed">
                        <li><strong className="text-slate-200">Data Ingestion:</strong> Automated the extraction of target genetic sequences directly from the standard GRCh38 human genome.</li>
                        <li><strong className="text-slate-200">Sequence Transformation:</strong> Programmatically generated the corresponding gRNA reverse complements to create the foundational string-matching dataset.</li>
                    </ul>
                </div>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Binary className="text-teal-400 h-6 w-6" /> 3. Algorithmic Approach & Feature Engineering
                </h2>
                <div className="grid sm:grid-cols-2 gap-6">
                    <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6 flex flex-col gap-4">
                        <div className="flex items-center gap-3">
                            <Dna className="text-blue-400" size={24} />
                            <h3 className="text-lg font-medium text-slate-200">High-Signal Feature Generation</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Engineered structural and expression-based mathematical features from raw sequence strings. Key features included thermodynamic Folding Energy, global dynamic parameters like Codon Usage Bias (RBCS, nTE), Gene Expression levels (RPKM), GC content matrices, and specific triplet counts.
                        </p>
                    </div>

                    <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6 flex flex-col gap-4">
                        <div className="flex items-center gap-3">
                            <Network className="text-purple-400" size={24} />
                            <h3 className="text-lg font-medium text-slate-200">Ensemble Model Selection</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Utilized a Random Forest (Ensemble Learning) architecture to successfully capture the deep, non-linear interactions between local genetic sequences and macro-structural DNA properties without severe overfitting.
                        </p>
                    </div>
                </div>
            </section>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Activity className="text-teal-400 h-6 w-6" /> 4. Optimization & Performance
                </h2>
                <div className="bg-gradient-to-br from-slate-900 to-slate-950 border border-slate-800 rounded-xl p-8 relative overflow-hidden">
                    <div className="absolute top-0 right-0 w-64 h-64 bg-teal-500/5 rounded-full blur-3xl -mr-20 -mt-20 pointer-events-none"></div>
                    <div className="relative z-10 flex flex-col md:flex-row gap-8 items-center">
                        <div className="flex-1">
                            <h3 className="text-xl font-medium text-slate-200 mb-3">Hyperparameter Evaluation</h3>
                            <p className="text-slate-400 leading-relaxed mb-4">
                                To avoid local maxima and isolate the true predictive power of the feature space, I executed a brute-force combinatorics optimization pipeline. The algorithm systematically constructed and evaluated <em>every possible feature combination</em> across 30 independent repetitions.
                            </p>
                            <p className="text-slate-400 leading-relaxed">
                                The architectural goal was to maximize the Spearman Correlation rather than raw accuracy, prioritizing the relative ranking of mutation probabilities across targets.
                            </p>
                        </div>
                        <div className="flex flex-col items-center justify-center p-6 bg-[#0f172a] rounded-2xl border border-slate-700/50 shadow-inner min-w-[200px]">
                            <span className="text-sm font-semibold text-slate-400 uppercase tracking-wider mb-2">Spearman Correlation</span>
                            <span className="text-4xl font-heading font-bold text-teal-400">0.26<span className="text-2xl text-slate-500">±.05</span></span>
                            <span className="text-xs text-slate-500 mt-3 text-center">Peak Performance Benchmark</span>
                        </div>
                    </div>
                </div>
            </section>

        </main>
    );
}
