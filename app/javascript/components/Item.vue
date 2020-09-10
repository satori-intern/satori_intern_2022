<template>
<div class="card">
    <div class="d-flex">
        <div class="p-2 align-self-center w-100">{{item.name}}</div>
        <div class="p-2 flex-shrink-1">
            <button type="button" class="btn btn-outline-info align-self-center" @click="modalBtn">
            <!-- <button type="button" class="btn btn-outline-info align-self-center" @click="openModal"> -->
                <span class="material-icons">info</span>
                <EditModal :val="item" @close="modalBtn" v-if="showModal"></EditModal>
                <!-- <SampleModal @close="closeModal" v-if="showModal"></SampleModal> -->
            </button>
        </div>
    </div>
</div>
</template>

<script>
import EditModal from "./EditModal"
// import SampleModal from './SampleModal'
export default {
    name: "Item",
    components: {
        EditModal,
        // SampleModal,
    },
    methods: {
        modalBtn() {
            console.log(this.showModal)
            this.showModal = this.showModal ? false : true;
            console.log(this.showModal)
            console.log('modalBtn')
        },
        openModal() {
            this.showModal = true
            console.log('open')
            },
        closeModal() {
            this.showModal = false
            console.log('close')
        },
    },
    props: {
        itemItem: {
            type: Object,
        },
    },
    data() {
        return {
            item: this.itemItem,
            showModal: true,
        };
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style scoped>
</style>
