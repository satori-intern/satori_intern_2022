<template>
  <div class="card">
    <div class="card-body bg-light">
      <h4 class="card-title">{{title}}</h4>
      <draggable v-model="items" :key="listId" group="board" @start="moveId">
        <div v-for="item in items" :key="item.id">
          <Item :item-item="item" />
        </div>
      </draggable>
      <AddBtn @catchNewName="addItem" :add-type="addType" />
    </div>
  </div>
</template>

<script>
import Item from "./Item";
import AddBtn from "./AddBtn";
import axios from "axios";
import draggable from "vuedraggable";

export default {
  name: "List",
  components: {
    Item,
    draggable,
    AddBtn,
  },
  props: {
    listTitle: {
      type: String,
      default: "",
    },
    listItems: {
      type: Array,
      default: () => {
        return [];
      },
    },
    id: {
      type: Number,
      default: 1,
    },
    listTitle: {
      type: String,
    },
  },
  data() {
    return {
      title: this.listTitle,
      items: this.listItems,
      listId: this.id,
      moveOldIndex: 0,
      newName: "",
      addType: "アイテム",
    };
  },
  created() {
    this.$watch(
      () => [this.items],
      // valueやoldValueの型は上で返した配列になる
      (val, oldval) => {
        this.moveItem(val, oldval);
      }
    );
  },
  methods: {
    addItem: function (newName) {
      const addListId = this.listId;
      const newItemId = axios
        .post("/items/create", { name: newName, list_id: addListId })
        .then((res) => res.data.id);
      const newItem = {
        id: newItemId,
        name: newName,
        detail: "",
      };
      this.items.push(newItem);
    },

    moveItem: function (val, oldVal) {
      const oldLists = oldVal[0];
      const newList = val[0];
      let beforeMoveId;
      let afterMoveId;
      //減ったほうのlists
      if (newList.length < oldLists.length) return;
      //増えた方のlists
      if (newList.length > oldLists.length) {
        //動かすアイテムのid
        beforeMoveId = newList.filter((elem) => {
          return !oldLists.some((list) => {
            return elem.id === list.id;
          });
        })[0].id;
        //動かしたアイテムのidのインデックス
        const movedIdIndex = newList.findIndex(({ id }) => id === beforeMoveId);
        //動かしたアイテムのidのひとつ上
        afterMoveId =
          movedIdIndex - 1 >= 0 ? newList[movedIdIndex - 1].id : null;
        console.log(beforeMoveId, afterMoveId);
      }
      //同じリスト内の移動のとき
      if (newList.length === oldLists.length) {
        beforeMoveId = oldLists[this.moveOldIndex].id;
        //動かしたアイテムのidのインデックス
        const movedIdIndex = newList.findIndex(({ id }) => id === beforeMoveId);
        //動かしたアイテムのidのひとつ上
        afterMoveId =
          movedIdIndex - 1 >= 0 ? newList[movedIdIndex - 1].id : null;
        console.log(beforeMoveId, afterMoveId);
      }
      return beforeMoveId, afterMoveId;
    },
    moveId: function (event) {
      this.moveOldIndex = event.oldIndex;
    },
  },
};
</script>
