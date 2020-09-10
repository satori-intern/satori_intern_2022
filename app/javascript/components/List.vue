<template>
<div class="card">
    <div class="card-body bg-light">
        <h4 class="card-title">{{title}}</h4>
        <draggable v-model="list.items" :key="list.id" group="board" @start="moveId" :options="{animation:500}">
            <div v-for="item in list.items" :key="item.id">
                <Item :item-copy="item" />
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
        listCopy: {
            type: Object,
            default: () => {
                return {};
            },
        },
    },
    data() {
        return {
            title: this.listCopy.name,
            list: this.listCopy,
            moveOldIndex: 0,
        };
    },
    created() {
        this.$watch(
            () => [this.list.items],
            // valueやoldValueの型は上で返した配列になる
            (val, oldval) => {
                this.moveItem(val, oldval);
            }, {
                deep: true,
            }
        );
    },
    methods: {
        moveItem: function (val, oldVal) {
            const oldLists = oldVal[0];
            const newLists = val[0];

            //減ったほうのlists
            if (newLists.length < oldLists.length) return;
            console.log(oldLists, newLists);
            let beforeMoveId;
            let afterMoveId;

            //増えた方のlists
            if (newLists.length > oldLists.length) {
                //動かすアイテムのid
                beforeMoveId = newLists.filter((elem) => {
                    return !oldLists.some((list) => {
                        return elem.id === list.id;
                    });
                })[0].id;
                //動かしたアイテムのidのインデックス
                const movedIdIndex = newLists.findIndex(
                    ({
                        id
                    }) => id === beforeMoveId
                );
                //動かしたアイテムのidのひとつ上
                afterMoveId =
                    movedIdIndex - 1 >= 0 ? newLists[movedIdIndex - 1].id : null;
                console.log(beforeMoveId, afterMoveId);
            }
            //同じリスト内の移動のとき
            if (newLists.length === oldLists.length) {
                beforeMoveId = oldLists[this.moveOldIndex].id;
                //動かしたアイテムのidのインデックス
                const movedIdIndex = newLists.findIndex(
                    ({
                        id
                    }) => id === beforeMoveId
                );
                //動かしたアイテムのidのひとつ上
                afterMoveId =
                    movedIdIndex - 1 >= 0 ? newLists[movedIdIndex - 1].id : null;
            }
            let changeListId = this.list.id;
            console.log(
                "beforeMoveId:",
                beforeMoveId,
                "afterMoveId:",
                afterMoveId,
                "changeListId:",
                changeListId
            );
            return beforeMoveId, afterMoveId, changeListId;
        },
        moveId: function (event) {
            this.moveOldIndex = event.oldIndex;
            console.log(event);
        },
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style scoped>
</style>
