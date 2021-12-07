import 'tailwindcss/tailwind.css'
import '../styles/globals.css';
import {  DAppProvider } from '@usedapp/core'


function MyApp({ Component, pageProps }) {
  return <DAppProvider>
           <Component {...pageProps} />
      </DAppProvider>
}

export default MyApp
