import React from 'react';
import { Badge } from '@/components/Badge';
import { LucideIcon } from 'lucide-react';
import { cn } from '@/lib/utils';

interface ProjectCardProps {
    title: string;
    description: string;
    constraints?: string;
    tags: string[];
    icon?: LucideIcon;
    href?: string;
}

export function ProjectCard({ title, description, constraints, tags, icon: Icon, href }: ProjectCardProps) {
    const CardContent = (
        <>
            <div>
                <div className="flex items-center gap-3 mb-4">
                    {Icon && (
                        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-teal-500/10 text-teal-400">
                            <Icon size={20} />
                        </div>
                    )}
                    <h3 className="text-xl font-heading font-semibold text-slate-100 group-hover:text-teal-400 transition-colors">
                        {title}
                    </h3>
                </div>
                <p className="text-slate-400 text-sm leading-relaxed mb-6">
                    {description}
                </p>
                {constraints && (
                    <div className="mb-6 rounded-lg bg-orange-950/20 border border-orange-900/30 p-4">
                        <div className="flex items-center gap-2 mb-2">
                            <span className="text-xs font-semibold text-orange-400 uppercase tracking-wider">Constraints & Validation</span>
                        </div>
                        <p className="text-orange-200/70 text-sm leading-relaxed">
                            {constraints}
                        </p>
                    </div>
                )}
            </div>
            <div className="flex flex-wrap gap-2">
                {tags.map(tag => (
                    <Badge key={tag}>{tag}</Badge>
                ))}
            </div>
        </>
    );

    const cardClasses = cn(
        "group relative flex flex-col justify-between rounded-xl border border-slate-800 bg-slate-900/40 p-6 transition-all",
        href ? "hover:bg-slate-800/50 hover:border-slate-700 hover:shadow-xl hover:shadow-teal-900/10" : "opacity-90"
    );

    if (href) {
        return (
            <a href={href} className={cardClasses}>
                {CardContent}
            </a>
        );
    }

    return (
        <div className={cardClasses}>
            {CardContent}
        </div>
    );
}
