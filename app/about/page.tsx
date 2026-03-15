import { FileText, Award, Briefcase, GraduationCap } from 'lucide-react';
import { Badge } from '@/components/Badge';

export const metadata = {
    title: 'About | Lior Bendavid',
    description: 'About Lior Bendavid, Professional Experience, Education, and Skills Taxonomy.'
};

export default function AboutPage() {
    return (
        <main className="flex-1 w-full max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 flex flex-col gap-20">

            <section className="flex flex-col gap-6">
                <h1 className="text-4xl font-heading font-bold text-slate-100">About Me</h1>
                <p className="text-lg text-slate-400 leading-relaxed">
                    I am a <strong>Data-driven Biomedical Engineer</strong>. My core mission is to turn high-noise analog and digital measurements into reliable, decision-grade insights. I achieve this by combining rigorous signal processing, reproducible computational workflows, and a deep understanding of how empirical data is generated and validated in complex environments.
                </p>
                <p className="text-lg text-slate-400 leading-relaxed">
                    Whether I'm isolating specific frequency bands from noisy sensor data, computationally modeling stochastic efficiencies, or supporting a large-scale ERP Go-Live, my approach remains the same: I structure the problem logically, actively look for confounding variables, and build explainable, robust solutions.
                </p>
            </section>

            <section className="flex flex-col gap-10">
                <h2 className="text-3xl font-heading font-semibold text-slate-100 flex items-center gap-3 border-b border-slate-800/60 pb-3">
                    <Briefcase className="text-teal-400 h-8 w-8" /> Professional Experience
                </h2>

                <div className="flex flex-col pl-3">
                    <div className="relative border-l-2 border-slate-800/60 pb-12 pl-8">
                        <div className="absolute w-4 h-4 bg-teal-500 rounded-full -left-[9px] top-1 ring-4 ring-slate-950" />
                        <h3 className="text-2xl font-semibold text-slate-200 tracking-tight">Information Systems Implementor</h3>
                        <p className="text-teal-400 text-sm font-medium mt-1 mb-4">Ministry of Health / Sheba Medical Center | 2025 - Present</p>
                        <p className="text-slate-400 leading-relaxed text-[15px]">
                            Implementing and supporting large-scale SAP-based healthcare information systems in a mission-critical enterprise environment. Responsible for validating complex operational workflows, investigating data integrity anomalies, and aligning end-users to ensure seamless adoption without compromising system fidelity.
                        </p>
                    </div>

                    <div className="relative border-l-2 border-slate-800/60 pb-12 pl-8">
                        <div className="absolute w-4 h-4 bg-slate-700 rounded-full -left-[9px] top-1 ring-4 ring-slate-950" />
                        <h3 className="text-2xl font-semibold text-slate-200 tracking-tight">Logistics Manager</h3>
                        <p className="text-slate-500 text-sm font-medium mt-1 mb-4">ADB Group | 2018 - 2019</p>
                        <p className="text-slate-400 leading-relaxed text-[15px]">
                            Managed inventory and distribution operations, optimized workflows, and resolved operational problems in dynamic settings. Handled high-touch customer communication during a previous Salesman role (2017-2018).
                        </p>
                    </div>

                    <div className="relative border-l-2 border-transparent pb-4 pl-8">
                        <div className="absolute w-4 h-4 bg-slate-700 rounded-full -left-[9px] top-1 ring-4 ring-slate-950" />
                        <h3 className="text-2xl font-semibold text-slate-200 tracking-tight">Military Service & Reserves</h3>
                        <p className="text-slate-500 text-sm font-medium mt-1 mb-4">IDF | 2013 - 2016, 2023 - Present</p>
                        <p className="text-slate-400 leading-relaxed text-[15px]">
                            Served as an Electro-Optic missile operator in the Artillery Corps (Meitar Unit), requiring disciplined procedure execution and comfort with complex technical equipment under high-pressure scenarios. Currently serving in Reserves (Infantry Brigade 5).
                        </p>
                    </div>
                </div>
            </section>

            <section className="flex flex-col gap-10">
                <h2 className="text-3xl font-heading font-semibold text-slate-100 flex items-center gap-3 border-b border-slate-800/60 pb-3">
                    <GraduationCap className="text-teal-400 h-8 w-8" /> Education
                </h2>

                <div className="bg-slate-900/40 border border-slate-800/60 rounded-2xl p-8 transition-colors hover:border-slate-700">
                    <h3 className="text-2xl font-semibold text-slate-200">B.Sc. Biomedical Engineering</h3>
                    <p className="text-teal-400 text-sm font-medium mt-1 mb-6">Tel Aviv University (TAU) | 2020 - 2025</p>
                    <p className="text-slate-400 mb-6 leading-relaxed">
                        Focus spanning systems modeling, signal processing, and hardware verification. Heavy emphasis on practical project outcomes, data integrity, and strict validation logic over theoretical rote learning.
                    </p>
                    <div className="flex flex-wrap gap-2">
                        {["Python Programming", "Signal & Image Processing", "Biomechanics", "Optics & Lasers", "Systems Genomics", "Biomedical Instrumentation", "Mechanics of Cells & Tissues"].map(course => (
                            <Badge key={course} className="bg-slate-800 text-slate-300 font-normal">{course}</Badge>
                        ))}
                    </div>
                </div>
            </section>

            <section className="flex flex-col gap-10">
                <h2 className="text-3xl font-heading font-semibold text-slate-100 flex items-center gap-3 border-b border-slate-800/60 pb-3">
                    <Award className="text-teal-400 h-8 w-8" /> Skills Taxonomy
                </h2>

                <div className="grid md:grid-cols-2 gap-6">
                    <div className="bg-slate-900/40 border border-slate-800/60 rounded-2xl p-8 flex flex-col gap-6">
                        <h3 className="text-xl font-heading font-semibold text-slate-200">Programming & Data</h3>
                        <div className="flex flex-wrap gap-2">
                            <Badge className="bg-teal-500/10 text-teal-300 border border-teal-500/20">MATLAB</Badge>
                            <Badge className="bg-teal-500/10 text-teal-300 border border-teal-500/20">Python</Badge>
                            <Badge className="bg-teal-500/10 text-teal-300 border border-teal-500/20">SQL</Badge>
                            <Badge>React / Next.js</Badge>
                            <Badge>Tailwind CSS</Badge>
                            <Badge>NumPy/Pandas</Badge>
                        </div>
                    </div>

                    <div className="bg-slate-900/40 border border-slate-800/60 rounded-2xl p-8 flex flex-col gap-6">
                        <h3 className="text-xl font-heading font-semibold text-slate-200">Hardware & Lab</h3>
                        <div className="flex flex-wrap gap-2">
                            <Badge>Biopac Sensors</Badge>
                            <Badge>Arduino Mega</Badge>
                            <Badge>SLA 3D Printing (Form 3)</Badge>
                            <Badge>Microscopy & Optics</Badge>
                            <Badge>DLS / VSM</Badge>
                            <Badge>Assays (LIVE/DEAD)</Badge>
                        </div>
                    </div>

                    <div className="bg-slate-900/40 border border-slate-800/60 rounded-2xl p-8 flex flex-col gap-6 md:col-span-2">
                        <h3 className="text-xl font-heading font-semibold text-slate-200">Methods & Engineering Context</h3>
                        <div className="flex flex-wrap gap-2">
                            <Badge className="bg-blue-500/10 text-blue-300 border border-blue-500/20">Signal Filtering & Noise Reduction</Badge>
                            <Badge className="bg-blue-500/10 text-blue-300 border border-blue-500/20">Statistical Testing</Badge>
                            <Badge className="bg-blue-500/10 text-blue-300 border border-blue-500/20">Systems/SAP Implementation</Badge>
                            <Badge>Feature Engineering</Badge>
                            <Badge>SolidWorks</Badge>
                            <Badge>LabVIEW</Badge>
                        </div>
                    </div>
                </div>
            </section>

        </main>
    );
}
