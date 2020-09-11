<template>
  <div class="bg-info">
    <EditModal
      :itemInfo="itemInfo"
      :listTitle="listTitle"
      :listId="listId"
      @editFinish="editFinish"
      @removeFinish="removeFinish"
      v-if="modal"
    ></EditModal>
    <h3 class="text-light p-1">{{board.name}}</h3>
    <div class="container p-1">
      <div class="row a">
        <draggable
          v-model="board.lists"
          group="lists"
          :animation="500"
          class="row"
          draggable=".list"
          @end="moveListId"
        >
          <div v-for="list in board.lists" :key="list.id" class="col-12 col-md-4 col-lg-3 list">
            <List
              :list-copy="list"
              @disList="disappearList"
              @ListToBoardInfo="ListToBoardInfo"
              ref="remove"
            />
          </div>
          <div class="col-12 col-md-4 col-lg-3">
            <AddBtn @catchNewName="addList" :add-type="addType" />
          </div>
        </draggable>
      </div>
    </div>
  </div>
</template>

<script>
import List from "./List";
import AddBtn from "./AddBtn";
import draggable from "vuedraggable";
import axios from "axios";
import EditModal from "./EditModal";

export default {
  name: "Board",
  components: {
    List,
    draggable,
    AddBtn,
    EditModal,
  },
  data() {
    return {
      board: {},
      boardId: "",
      addType: "リスト",
      modal: false,
      itemInfo: "",
      listTitle: "",
      listId: "",
    };
  },
  mounted() {
    this.boardId = location.pathname.split("/")[2];
    axios
      .post("/boards/get_board_data", {
        id: this.boardId,
      })
      .then((response) => {
        this.board = response.data;
      });
  },
  methods: {
    disappearList: function (delListId) {
      this.board.lists = this.board.lists.filter((n) => n.id !== delListId);
    },
    addList: function (newName) {
      const newItemId = axios
        .post("/lists/create", {
          name: newName,
          board_id: this.boardId,
        })
        .then((res) => res.data.id)
        .then((newListId) => {
          const newList = {
            id: newListId,
            name: newName,
            items: [],
          };
          this.board.lists.push(newList);
        });
    },
    moveListId: function (event) {
      const oldIndex = event.oldIndex;
      const newIndex = event.newIndex;

      const bordId = this.board.lists[newIndex].id;
      const bordIdBefore =
        newIndex - 1 >= 0 ? this.board.lists[newIndex - 1].id : null;

      axios
        .post("/lists/move", {
          id: bordId,
          to_id: bordIdBefore,
        })
        .then((response) => {
        });
    },
    editFinish: function (itemInfo) {
      //api処理
      axios
        .put("/items/update", {
          id: itemInfo.id,
          name: itemInfo.name,
          detail: itemInfo.detail,
        })
        .then((response) => {});
      this.modal = false;
    },
    removeFinish: function (itemId, listId) {
      this.modal = false;
      this.board.lists.forEach((element) => {
        if (element.id === listId) {
          element.items.splice(
            element.items.indexOf(
              element.items.find((item) => item.id === itemId)
            ),
            1
          );
        }
      });
      //api処理
      axios
        .delete("/items/destroy", {
          params: {
            id: itemId,
          },
        })
        .then((response) => {});
    },
    ListToBoardInfo: function (itemInfo, listTitle, listId) {
      this.itemInfo = itemInfo;
      this.listTitle = listTitle;
      this.listId = listId;
      this.modal = true;
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style scoped>
.a {
  user-select: none;
  -moz-user-select: none;
  /* Firefox */
  -webkit-user-select: none;
  /* Safari、Chromeなど */
  -ms-user-select: none;
  /* IE10かららしい */
}
.card {
  margin-bottom: 10px;
}

div.container.p-1 {
  width: 100%;
}

div.row {
  width: 100%;
  margin-left: 5px;
}
</style>
