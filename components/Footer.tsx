import { Github, Linkedin, Mail } from 'lucide-react';
import Link from 'next/link';

export function Footer() {
    return (
        <footer className="w-full border-t border-slate-800/60 bg-slate-950 py-8 mt-12 shrink-0">
            <div className="container mx-auto flex max-w-5xl flex-col items-center justify-between gap-4 px-4 sm:flex-row sm:px-6 lg:px-8">
                <p className="text-center text-sm leading-loose text-slate-500 sm:text-left">
                    &copy; {new Date().getFullYear()} Lior Bendavid. All rights reserved.
                </p>
                <div className="flex items-center gap-4">
                    <Link href="https://github.com" target="_blank" rel="noreferrer" className="text-slate-500 hover:text-teal-400 transition-colors">
                        <Github className="h-5 w-5" />
                        <span className="sr-only">GitHub</span>
                    </Link>
                    <Link href="https://linkedin.com" target="_blank" rel="noreferrer" className="text-slate-500 hover:text-teal-400 transition-colors">
                        <Linkedin className="h-5 w-5" />
                        <span className="sr-only">LinkedIn</span>
                    </Link>
                    <Link href="mailto:liorb@example.com" className="text-slate-500 hover:text-teal-400 transition-colors">
                        <Mail className="h-5 w-5" />
                        <span className="sr-only">Email</span>
                    </Link>
                </div>
            </div>
        </footer>
    );
}
