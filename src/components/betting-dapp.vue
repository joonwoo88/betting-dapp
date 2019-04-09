<template>
    <div>
        <DappMetamask />
        <BettingComponent />
    </div>
</template>

<script>
import DappMetamask from '@/components/dapp-metamask'
import BettingComponent from '@/components/betting-component'

export default {
    name: 'betting-dapp',
    components: {
        DappMetamask,
        BettingComponent
    },
    beforeCreate() {
        console.log('registerWeb Action dispatched')
        this.$store.dispatch('registerWeb3')
    }
}
</script>
<style scoped>
</style>