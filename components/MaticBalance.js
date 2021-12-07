import { formatUnits } from '@ethersproject/units'
import { useTokenBalance } from '@usedapp/core'

const MATIC = '0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0'

export default function MaticBalance({ account }) {
  const tokenBalance = useTokenBalance(MATIC, account)

  return (
    <div>
      {tokenBalance && <div className="p-2 rounded-xl bg-green-200 text-green-900">${formatUnits(tokenBalance, 18)}</div>}
    </div>
  )
}