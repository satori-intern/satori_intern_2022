<template>
<div class="card">
    <div class="d-flex">
        <div class="p-2 align-self-center w-100">{{Item.name}}</div>
        <div class="p-2 flex-shrink-1">
            <button type="button" class="btn btn-outline-info align-self-center">
                <span class="material-icons">info</span>
            </button>
        </div>
    </div>
</div>
</template>

<script>
export default {
    name: "Item",
    props: {
        item: {
            type: Object,
            default: () => {
                return {};
            },
        },
    },
    data() {
        return {
            Item: this.item,
        };
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style scoped>
</style>
