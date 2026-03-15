import Link from 'next/link';
import { ArrowLeft, Layers, Microscope, Beaker, CheckCircle2, Factory } from 'lucide-react';
import { Badge } from '@/components/Badge';

export const metadata = {
    title: 'Magnetic Nanodiscs Actuators | Lior Bendavid',
    description: 'Optimization of Surface Functionalization for Magnetomechanical Actuators.'
};

export default function NanodiscsPage() {
    return (
        <main className="flex-1 w-full max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 flex flex-col gap-16">
            <div className="flex flex-col gap-6">
                <Link href="/projects" className="inline-flex items-center gap-2 text-slate-400 hover:text-teal-400 transition-colors w-fit font-medium text-sm">
                    <ArrowLeft size={16} /> Back to Projects
                </Link>
                <div className="flex flex-col gap-4 mt-4">
                    <h1 className="text-4xl sm:text-5xl font-heading font-extrabold text-slate-100 tracking-tight leading-tight">
                        Magnetic Nanodiscs Actuators <span className="block text-2xl sm:text-3xl text-teal-400 font-semibold mt-2">(Optimization of Surface Functionalization for Magnetomechanical Actuators)</span>
                    </h1>
                    <div className="flex flex-wrap gap-2 mt-2">
                        <Badge className="bg-teal-500/10 text-teal-300 border border-teal-500/20">Interface Optimization</Badge>
                        <Badge className="bg-blue-500/10 text-blue-300 border border-blue-500/20">Material Selection</Badge>
                        <Badge>Protocol Development</Badge>
                        <Badge>DLS / SEM</Badge>
                        <Badge>Validation Framework</Badge>
                    </div>
                </div>
            </div>

            <section className="flex flex-col gap-6">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Factory className="text-teal-400 h-6 w-6" /> Executive Summary & Role
                </h2>
                <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-6">
                    <p className="text-slate-400 leading-relaxed text-balance">
                        This project focuses on the engineering challenge of translating theoretical physics into a functional Remote Mechanical Actuation Strategy. My specific role centered around developing a <strong>Modified Protocol</strong> to improve the Functionalization Efficiency and torque transmission of Magnetic Vortex Nanodiscs (MNDs). I led a feasibility study evaluating various high-performance coatings—specifically PEG, Lipids, and Antibody Conjugates—to achieve reliable interface optimization without compromising the critical magnetic torque required for actuation.
                    </p>
                </div>
            </section>

            <section className="flex flex-col gap-8">
                <h2 className="text-2xl font-heading font-semibold text-slate-200 flex items-center gap-2 border-b border-slate-800/60 pb-2">
                    <Layers className="text-teal-400 h-6 w-6" /> Project Workflow
                </h2>

                <div className="grid sm:grid-cols-2 gap-6 mt-2">
                    <div className="bg-[#111827] border border-slate-800 rounded-xl p-6 flex flex-col gap-3 relative overflow-hidden group hover:border-slate-700 transition-colors">
                        <div className="absolute top-0 left-0 w-1 h-full bg-red-500/50"></div>
                        <div className="flex items-center gap-3">
                            <Microscope className="text-red-400" size={20} />
                            <h3 className="text-lg font-medium text-slate-200">1. System Analysis</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Evaluated the functional limitations of the original PMAO (Poly(maleic anhydride-alt-1-octadecene)) coatings, which established baseline operational bottlenecks in actuator binding.
                        </p>
                    </div>

                    <div className="bg-[#111827] border border-slate-800 rounded-xl p-6 flex flex-col gap-3 relative overflow-hidden group hover:border-slate-700 transition-colors">
                        <div className="absolute top-0 left-0 w-1 h-full bg-blue-500/50"></div>
                        <div className="flex items-center gap-3">
                            <Layers className="text-blue-400" size={20} />
                            <h3 className="text-lg font-medium text-slate-200">2. Material Selection</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Researched and selected high-performance polymers (PEG) and natural biopolymers (Polysaccharides) based explicitly on their chemical stability characteristics and GRAS (Generally Regarded as Safe) status profiles.
                        </p>
                    </div>

                    <div className="bg-[#111827] border border-slate-800 rounded-xl p-6 flex flex-col gap-3 relative overflow-hidden group hover:border-slate-700 transition-colors">
                        <div className="absolute top-0 left-0 w-1 h-full bg-emerald-500/50"></div>
                        <div className="flex items-center gap-3">
                            <Beaker className="text-emerald-400" size={20} />
                            <h3 className="text-lg font-medium text-slate-200">3. Protocol Development</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Drafted and iteratively refined a sonication-based application method to guarantee uniform coating coverage across the actuator batch, mitigating agglomeration failures.
                        </p>
                    </div>

                    <div className="bg-[#111827] border border-slate-800 rounded-xl p-6 flex flex-col gap-3 relative overflow-hidden group hover:border-slate-700 transition-colors">
                        <div className="absolute top-0 left-0 w-1 h-full bg-purple-500/50"></div>
                        <div className="flex items-center gap-3">
                            <CheckCircle2 className="text-purple-400" size={20} />
                            <h3 className="text-lg font-medium text-slate-200">4. Validation Framework</h3>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            Designed a rigorous testing suite employing DLS, SEM, and Cytotoxicity assays (MTT/alamarBlue) to explicitly ensure the new coatings maintained the essential saturation magnetization of the nanodiscs.
                        </p>
                    </div>
                </div>
            </section>

        </main>
    );
}
