import { useEthers } from '@usedapp/core'
import MaticBalance from '../components/MaticBalance'

export default function Nav() {
    const { activateBrowserWallet, account } = useEthers()
    return (
        <header className="flex bg-white h-20 items-center justify-between p-3"> 
            <h1 className="text-xl font-bold">blackfish.eth</h1>
            { account === undefined ? 
                (<button 
                    className="capitalize border-2 p-3 font-medium hover:bg-black hover:text-white border-black" 
                    onClick={() => activateBrowserWallet()}>connect a wallet</button>) : 
                    (<div className="flex space-x-4"> 
                        <div className="p-2 rounded-xl border-4 border-black bg-[#ED1B76] text-white"><span className="font-bold">Account:</span> {account}</div>
                        {/* <MaticBalance account={account} /> */}
                    </div>)
            }
        </header>
    )
}
