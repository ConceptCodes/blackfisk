import Head from 'next/head'
import Nav from '../components/Nav'
import GameCard from '../components/GameCard'

export default function Home() {
  return (
    <div className="flex flex-col max-h-full">
      <Head>
        <title>Blackfisk</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Nav />
      <main className="flex flex-grow">
        <section className="flex flex-grow bg-black text-white flex-col space-y-3 p-5">
          <article className="space-y-3"> 
            <h1 className="text-4xl md:text-8xl">Blackfisk</h1>
            <h2 className="text-2xl text-gray-200">/black-fi-sku/</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco</p>
          </article>
        </section>
        <GameCard color="#249F9C" title="pvp" index={1} />
        <GameCard color="#ED1B76" title="streamer" index={2} />
      </main>
    </div>
  )
}
