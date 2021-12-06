// import cn from 'classnames'

export default function GameCard({ name, index, color }) {
    const bgColor = `bg-[${color}] flex flex-col flex-1 items-center justify-between p-4`
    return (
        <figure className={bgColor}> 
            <span className="bg-black rounded-full flex items-center justify-center text-white w-10 h-10">{index}</span>
            <h1 className="transform rotate-90 uppercase font-bold text-white text-6xl">{name}</h1>
        </figure>
    )
}
