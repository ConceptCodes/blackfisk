import { ArrowLeftIcon } from '@heroicons/react/solid'

export default function GameCard({color, title, index}) {
    const bg = `bg-[${color}] flex flex-col items-center justify-between w-1/3  p-4`
    return (
        <figure className={bg}> 
        <span className="bg-black rounded-full flex items-center justify-center text-white w-10 h-10">{index}</span>
            <div className="space-x-3"> 
                <h1 className="transform rotate-90 uppercase font-bold text-6xl">{title}</h1>
                <span className="border-4 border-black w-20 rounded-full flex items-center justify-center p-5">
                    <ArrowLeftIcon className="h-6" />
                </span>
            </div>
    </figure>
    )
}
