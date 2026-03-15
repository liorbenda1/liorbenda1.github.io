import { ArrowRight, Database, Microchip, Stethoscope, Activity, FileText } from 'lucide-react';
import Link from 'next/link';
import { ProjectCard } from '@/components/ProjectCard';

export default function Home() {
  return (
    <main className="flex-1 flex flex-col items-center">
      <section className="w-full flex flex-col items-center justify-center py-24 px-4 sm:px-6 lg:px-8 text-center bg-gradient-to-b from-slate-950 to-slate-900 border-b border-slate-800/60">
        <div className="max-w-3xl flex flex-col items-center animate-in fade-in slide-in-from-bottom-8 duration-1000">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-teal-500/10 text-teal-400 text-sm font-medium mb-6">
            <Activity size={16} />
            <span>Available for R&D, Data, and V&V roles</span>
          </div>
          <h1 className="text-4xl sm:text-5xl md:text-6xl font-heading font-extrabold text-slate-100 tracking-tight leading-tight mb-6">
            Turning high-noise data into <span className="text-teal-400">reliable insights.</span>
          </h1>
          <p className="text-lg sm:text-xl text-slate-400 mb-10 max-w-2xl text-balance">
            I am a Biomedical Engineer blending experimental rigor with computational analysis and complex systems validation.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 w-full sm:w-auto mt-4">
            <Link href="/projects" className="inline-flex items-center justify-center gap-2 px-6 py-3 rounded-lg bg-teal-500 text-teal-950 font-semibold hover:bg-teal-400 transition-colors">
              View Projects <ArrowRight size={18} />
            </Link>
            <Link href="/about" className="inline-flex items-center justify-center gap-2 px-6 py-3 rounded-lg bg-slate-800 text-slate-100 font-semibold hover:bg-slate-700 transition-colors border border-slate-700">
              <FileText size={18} /> Read My Story
            </Link>
          </div>
        </div>
      </section>

      <section className="w-full max-w-5xl px-4 sm:px-6 lg:px-8 py-24 flex flex-col items-center gap-12">
        <div className="text-center">
          <h2 className="text-3xl font-heading font-bold text-slate-100 mb-4">Core Competencies</h2>
          <p className="text-slate-400 text-lg">The bridging skills that bring reliability to medical technology.</p>
        </div>

        <div className="grid md:grid-cols-3 gap-8 w-full mt-4">
          <div className="p-8 rounded-2xl bg-slate-900/50 border border-slate-800 flex flex-col items-start gap-5 transition-colors hover:border-slate-700">
            <div className="h-12 w-12 rounded-xl bg-blue-500/10 text-blue-400 flex items-center justify-center">
              <Database size={24} />
            </div>
            <h3 className="text-xl font-semibold text-slate-100 font-heading">Clinical & Systems Validation</h3>
            <p className="text-slate-400 text-sm leading-relaxed">
              Experienced with structured medical data and hospital Go-Live operations. Ensuring systems adhere to strict workflows and data integrity standards.
            </p>
          </div>

          <div className="p-8 rounded-2xl bg-slate-900/50 border border-slate-800 flex flex-col items-start gap-5 transition-colors hover:border-slate-700">
            <div className="h-12 w-12 rounded-xl bg-teal-500/10 text-teal-400 flex items-center justify-center">
              <Microchip size={24} />
            </div>
            <h3 className="text-xl font-semibold text-slate-100 font-heading">Computational Pipelines</h3>
            <p className="text-slate-400 text-sm leading-relaxed">
              Building robust data pipelines in MATLAB, Python, and SQL to filter noise, segment data, and perform rigorous statistical validation.
            </p>
          </div>

          <div className="p-8 rounded-2xl bg-slate-900/50 border border-slate-800 flex flex-col items-start gap-5 transition-colors hover:border-slate-700">
            <div className="h-12 w-12 rounded-xl bg-purple-500/10 text-purple-400 flex items-center justify-center">
              <Stethoscope size={24} />
            </div>
            <h3 className="text-xl font-semibold text-slate-100 font-heading">Experimental Rigor</h3>
            <p className="text-slate-400 text-sm leading-relaxed">
              Designing hardware and wet-lab setups (3D printing, optics, assays) with deep honesty regarding limitations, error sources, and practical fidelity.
            </p>
          </div>
        </div>
      </section>

      <section className="w-full bg-slate-900/50 border-t border-slate-800/60 py-24 px-4 sm:px-6 lg:px-8 flex flex-col items-center">
        <div className="w-full max-w-5xl flex flex-col gap-10">
          <div className="flex justify-between items-end mb-4">
            <div>
              <h2 className="text-3xl font-heading font-bold text-slate-100 mb-2">Flagship Work</h2>
              <p className="text-slate-400">A selection of my strongest projects mapping reality to insights.</p>
            </div>
            <Link href="/projects" className="hidden sm:inline-flex text-teal-400 hover:text-teal-300 font-medium items-center gap-1 transition-colors">
              All Projects <ArrowRight size={16} />
            </Link>
          </div>

          <ProjectCard
            title="Pediatric Anesthesia (Multimodal Sensor Fusion & Anomaly Detection)"
            description="Developed a 4-year data analysis pipeline correlating physiological signals (HR, SpO₂) with environmental markers to optimize protocols. Applied robust filtration and extracted reliable statistical conclusions regarding system methods and subject profiles."
            constraints="Data integrity degraded by subject movement artifacts and sensor detachment. Mitigated via rigorous noise-floor thresholding and semi-automated exclusion heuristics."
            tags={["MATLAB", "SQL", "Sensor Data", "Signal Processing", "Statistical Analysis"]}
            icon={Activity}
            href="/projects" // Usually links to a detailed case study or github
          />
        </div>
      </section>
    </main>
  );
}
