<template>
<div class="card">
    <div class="card-body bg-light">
        <h4 class="card-title">{{list_title}}</h4>
        <draggable v-model="listItems" :key="listId" group="board" @end="moveItem">
            <div v-for="item in listItems" :key="item.id">
                <Item :item="item" />
            </div>
        </draggable>
        <button type="button" class="btn btn-outline-info d-flex align-self-center">
            <span class="material-icons">add</span> アイテムを追加
        </button>
    </div>
</div>
</template>

<script>
import Item from "./Item";
import draggable from "vuedraggable";
export default {
    name: "List",
    components: {
        Item,
        draggable,
    },
    props: {
        listTitle: {
            type: String,
            default: "",
        },
        items: {
            type: Array,
            default: () => {
                return [];
            },
        },
        id: {
            type: Number,
            default: 1,
        },
    },
    data() {
        return {
            list_title: this.listTitle,
            listItems: this.items,
            listId: this.id,
        };
    },
    methods: {
        moveItem: function (event) {
            console.log(event);
        },
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style scoped>
</style>
