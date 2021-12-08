import Head from 'next/head'
import Nav from '../components/Nav'
import GameCard from '../components/GameCard'
import Link from 'next/link'

const modes = ['pvp', 'streamer']

export default function Home() {
  return (
    <>
      <Head>
        <title>Blackfisk</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Nav />
      <main className="flex">
        <section className="flex flex-grow w-1/2 bg-black text-white flex-col space-y-3 p-5">
          <article className="space-y-3"> 
            <h1 className="text-4xl md:text-8xl">Blackfisk</h1>
            <h2 className="text-2xl text-gray-500">/black-fi-sku/</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco</p>
          </article>
        </section>
        { 
          modes.map((val, index) => (<GameCard title={val} index={index} />))
        }
      </main>
    </>
  )
}
