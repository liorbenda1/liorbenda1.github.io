# Project Plan: Lior Bendavid - Full-Stack Biomedical Portfolio

## 1. Executive Summary
Develop a high-end, responsive portfolio website that solidifies Lior Bendavid's identity as a **"Full-Stack Biomedical Engineer"**. The site will highlight the rare combination of rigorous experimental design, clinical/regulated systems validation (SAP go-live), and computational data pipelines (Python/MATLAB/SQL). 

**Design Ethos**: "Modern Dark / Medical-Academic" - clean, grid-based, highly legible, and sophisticated, reflecting precision and reliability.

---

## 2. Technology Stack
* **Framework**: [Next.js](https://nextjs.org/) (App Router) for performant, SEO-friendly static generation and smooth page transitions.
* **Styling**: [Tailwind CSS](https://tailwindcss.com/) to build a custom, visually striking dark-themed UI without heavy CSS files.
* **Icons**: [Lucide React](https://lucide.dev/) for crisp, consistent, and professional iconography (e.g., database, activity, microchip, stethoscope).
* **Animations**: Tailwind's built-in transitions / Framer Motion for subtle micro-interactions (hover states on project cards, smooth section reveals).
* **Deployment**: GitHub Pages / Vercel (static export).

---

## 3. Site Architecture

### 3.1 Home (`/`)
* **Hero Section**: 
  * *Headline*: "Data-driven Biomedical Engineer"
  * *Subheadline*: "Turning messy biological measurements into reliable, decision-grade insights."
  * *Call-to-Action*: View Projects / Read CV.
* **Core Competencies (3-Column Grid with Lucide Icons)**:
  1. *Clinical & Systems Validation* (SAP, Workflow integrity)
  2. *Computational Pipelines* (MATLAB, Python, SQL, Signal Processing)
  3. *Experimental & Hardware Rigor* (3D Printing, Biopac, Optics)
* **Flagship Featured Project**: 
  * Elevated card layout for **Pediatric Dental Anesthesia Data Project**, showcasing the pipeline: Segmentation → Filtration → Stats → Visualization.

### 3.2 Projects Showcase (`/projects`)
A filterable grid of projects categorized by domain to show breadth without clutter:
* **Flagships**:
  * Pediatric Dental Anesthesia (Data Pipeline / Clinical)
  * Magnetic Vortex Nanodiscs (Research / Biophysics)
  * iGEM CRISPR Efficiency Model (Data Science / ML)
* **Systems & Hardware**:
  * 3D Printed Artery Hemodynamics (LabVIEW / MATLAB)
  * Sampling Amplifier + ECG Digitization (Arduino / Nyquist)
* **Biological / Clinical Proofs**:
  * Laminin Cell Culture Miniproject
  * Optics 2 / Beer-Lambert experiments

### 3.3 About (`/about`)
* **Narrative**: The structural "engineering-first" thinker who understands how data is born (sensors, clinical workflow) and how it must be validated.
* **Timeline**: 
  * TAU B.Sc. Biomedical Engineering
  * IDF (Electro-Optics) & Reserves
  * Sheba Medical Center (Information Systems Implementor / SAP)
* **Skills Taxonomy**: Clear lists of Programming (Python/MATLAB/SQL), Lab Hardware, and Systems Engineering tools.

---

## 4. Design System & Aesthetics

* **Color Palette**: 
  * *Backgrounds*: Deep Slate/Zinc (`bg-slate-900` to `bg-slate-950`) for a premium "dark mode" feel.
  * *Cards/Surfaces*: Subtly lighter slate with 1px borders (`border-slate-800`).
  * *Accents*: Medical Teal or Electric Blue (`text-teal-400` or `text-blue-400`) to highlight key terms, links, and icons.
* **Typography**: 
  * UI/Headings: **Inter** or **Outfit** for a sleek, modern tech feel.
  * Body: **Roboto** or **Inter** for maximum readability of technical summaries.
* **UI Components**:
  * **Project Cards**: Image/Concept banner at top, concise description, tech-stack pill badges (e.g., [MATLAB], [SQL], [R&D]), and subtle lift on hover.
  * **Pill Badges**: Used liberally to tag skills and project domains.

---

## 5. Implementation Phases

1. **Setup & Scaffolding**: Initialize Next.js app with Tailwind CSS and Lucide React. Set up global CSS for the "Modern Dark" theme.
2. **Component Development**: Build reusable UI components (Navbar, Footer, ProjectCard, Badge, SectionHeader).
3. **Content Integration**: Migrate summaries from `CONTEXT.md` into static JSON or Markdown files to populate the Projects and About pages.
4. **Refinement & Polish**: Add responsive breakpoints, micro-animations, and visual testing. Ensure SEO best practices (meta tags, semantic HTML).
