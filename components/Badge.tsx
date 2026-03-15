import * as React from "react"
import { cn } from "@/lib/utils"

export interface BadgeProps extends React.HTMLAttributes<HTMLDivElement> { }

function Badge({ className, ...props }: BadgeProps) {
    return (
        <div
            className={cn(
                "inline-flex items-center rounded-full border border-transparent bg-slate-800/80 px-2.5 py-0.5 text-xs font-semibold text-slate-300 transition-colors hover:bg-slate-700 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-offset-2",
                className
            )}
            {...props}
        />
    )
}

export { Badge }
