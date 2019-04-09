import Web3 from 'web3'
import {store} from '../store/'
const pollWeb3 = function (state) {
    let web3 = window.web3
    web3 = new Web3(web3.currentProvider)

    setInterval(() => {
        if (!web3 || !store.state.web3.web3Instance) {
            return;
        }
        
        if (web3.eth.coinbase !== store.state.web3.coinbase) {
            const newCoinbase = web3.eth.coinbase
            web3.eth.getBalance(web3.eth.coinbase, function(err, newBalance) {
                if(err) {
                    console.error(err)
                } else if (parseInt(newBalance, 10) !== store.state.web3.balance) {
                    store.dispatch('updateWeb3', {
                        coinbase: newCoinbase,
                        balance: parseInt(newBalance, 10)
                    })
                }
            })
        }


    }, 700)
}

export default pollWeb3