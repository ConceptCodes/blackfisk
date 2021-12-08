import { ArrowLeftIcon } from "@heroicons/react/solid";
import Link from "next/link";

export default function GameCard({ title, index }) {
  const bg = `${title} flex flex-col items-center cursor-pointer justify-between  p-4`;
  return (
    <Link href={"/" + title}>
      <figure className={bg}>
        <span className="bg-black rounded-full flex items-center justify-center text-white w-10 h-10">
          {index}
        </span>
        <div className="flex">
          <h1 className="transform rotate-90 uppercase font-bold text-6xl">
            {title}
          </h1>
          {/* <ArrowLeftIcon className="h-6" /> */}
        </div>
      </figure>
    </Link>
  );
}
