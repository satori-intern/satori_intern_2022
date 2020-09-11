<template>
  <div class="card">
    <button
      type="button"
      class="btn btn-outline-danger w-100 font-weight-bold"
      @mouseover="hoverDelBtn"
      @mouseleave="leaveDelBtn"
      @click="delList"
      v-if="showEditBtn"
    >
      <span class="material-icons">clear</span>
      {{delConf}}
    </button>
    <div class="card-body bg-light">
      <div class="d-flex">
        <h4 v-if="!showEditBtn" class="p-2 align-self-center w-100">{{title}}</h4>
        <input
          v-model="title"
          v-if="showEditBtn"
          type="text"
          class="form-control p-2 align-self-center w-100"
        />
        <div class="p-2 flex-shrink-1">
          <button
            type="button"
            class="btn btn-outline-info align-self-center"
            @click="switchEditBtn"
          >
            <span class="material-icons">create</span>
          </button>
        </div>
      </div>
      <draggable
        v-model="list.items"
        :key="list.id"
        group="board"
        @start="moveId"
        :animation="500"
      >
        <div v-for="item in list.items" :key="item.id">
          <Item :item-copy="item" @ItemToListInfo="ItemToListInfo" />
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
      newName: "",
      addType: "アイテム",
      showEditBtn: false,
      delConf: "",
    };
  },
  created() {
    this.$watch(
      () => [this.list.items],
      // valueやoldValueの型は上で返した配列になる
      (val, oldval) => {
        this.moveItem(val, oldval);
      },
      {
        deep: true,
      }
    );
  },
  methods: {
    hoverDelBtn: function () {
      this.delConf = "取り消せません！";
    },
    leaveDelBtn: function () {
      this.delConf = "";
    },
    switchEditBtn: function () {
      this.showEditBtn = this.showEditBtn ? false : true;
      if (!this.showEditBtn) {
        axios
          .put("/lists/update", { id: this.list.id, name: this.title })
          .then((res) => console.log(res));
      }
    },
    addItem: function (newName) {
      const addListId = this.list.id;
      const newItemId = axios
        .post("/items/create", { name: newName, list_id: addListId })
        .then((res) => res.data.id)
        .then((newItemId) => {
          const newItem = {
            id: newItemId,
            name: newName,
            detail: "",
          };
          this.list.items.push(newItem);
        });
    },
    delList: function () {
      axios
        .delete("/lists/destroy", { params: { id: this.list.id } })
        .then((res) => {
          console.log(res);
          this.$emit("disList", this.list.id);
        });
    },
    moveItem: function (val, oldVal) {
      const oldLists = oldVal[0];
      const newLists = val[0];

      //減ったほうのlists
      if (newLists.length < oldLists.length) return;
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
          ({ id }) => id === beforeMoveId
        );
        //動かしたアイテムのidのひとつ上
        afterMoveId =
          movedIdIndex - 1 >= 0 ? newLists[movedIdIndex - 1].id : null;
      }
      //同じリスト内の移動のとき
      if (newLists.length === oldLists.length) {
        beforeMoveId = oldLists[this.moveOldIndex].id;
        //動かしたアイテムのidのインデックス
        const movedIdIndex = newLists.findIndex(
          ({ id }) => id === beforeMoveId
        );
        //動かしたアイテムのidのひとつ上
        afterMoveId =
          movedIdIndex - 1 >= 0 ? newLists[movedIdIndex - 1].id : null;
      }
      let changeListId = this.list.id;
      axios
        .post("/items/move", {
          id: beforeMoveId,
          to_id: afterMoveId,
          list_id: changeListId,
        })
        .then((response) => {});
    },
    moveId: function (event) {
      this.moveOldIndex = event.oldIndex;
    },
    ItemToListInfo: function (itemInfo) {
      this.$emit("ListToBoardInfo", itemInfo, this.title, this.list.id);
    },
  },
};
</script>
