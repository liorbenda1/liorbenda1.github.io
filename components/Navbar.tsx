"use client";

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { cn } from '@/lib/utils';
import { Stethoscope } from 'lucide-react';

const navItems = [
    { path: '/', label: 'Home' },
    { path: '/projects', label: 'Projects' },
    { path: '/about', label: 'About' },
];

export function Navbar() {
    const pathname = usePathname();

    return (
        <header className="sticky top-0 z-50 w-full border-b border-slate-800/60 bg-slate-950/80 backdrop-blur supports-[backdrop-filter]:bg-slate-950/60">
            <div className="container mx-auto flex h-16 max-w-5xl items-center justify-between px-4 sm:px-6 lg:px-8">
                <Link href="/" className="flex items-center gap-2 transition-colors hover:text-teal-400">
                    <Stethoscope className="h-6 w-6 text-teal-400" />
                    <span className="font-heading font-bold text-lg tracking-tight text-slate-100">Lior Bendavid</span>
                </Link>
                <nav className="flex items-center gap-6">
                    {navItems.map((item) => (
                        <Link
                            key={item.path}
                            href={item.path}
                            className={cn(
                                "text-sm font-medium transition-colors hover:text-teal-400",
                                pathname === item.path ? "text-teal-400" : "text-slate-400"
                            )}
                        >
                            {item.label}
                        </Link>
                    ))}
                </nav>
            </div>
        </header>
    );
}
