import Head from 'next/head'

export default function pvp() {
    return (
        <>
        <Head>
            <title>PVP | blackfisk</title>
        </Head>
            <main className="pvp h-screen p-5">
                <header className="flex justify-between">
                    <h1 className="text-2xl font-medium">Player 1</h1>
                    <h1 className="text-2xl font-medium">Player 2</h1>
                </header>
            </main>
        </>
    )
}
