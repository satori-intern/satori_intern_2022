<template>
  <div class="bg-info">
    <EditModal :itemInfo="itemInfo" :listTitle="listTitle" :listId="listId" :index="index" @editFinish="editFinish" @removeFinish="removeFinish" v-if="modal"></EditModal>
    <h3 class="text-light p-1">{{board.name}}</h3>
    <div class="container p-1">
      <div class="row">
        <draggable v-model="board.lists" group="lists" class="row">
          <div v-for="(list, index) in board.lists" :key="list.id" class="col-12 col-md-4 col-lg-3">
            <List :list-items="list.items" :list-title="list.name" :id="list.id" :index="index" @ListToBoardInfo=ListToBoardInfo ref="remove" />
          </div>
          <div class="col-12 col-md-4 col-lg-3">
            <button type="button" class="btn btn-outline-light d-flex align-self-center">
              <span class="material-icons">add</span> リストを追加する
            </button>
          </div>
        </draggable>
      </div>
    </div>
  </div>
</template>

<script>
import List from "./List";
import draggable from "vuedraggable";
import axios from "axios";
import EditModal from './EditModal'
export default {
  name: "Board",
  components: {
    List,
    draggable,
    EditModal,
  },
  mounted() {
    this.boardId = location.pathname.split("/")[2]
    axios.post("/boards/get_board_data", { id: this.boardId }).then((response) => {
      this.board = response.data;
      console.log(response.data);
    });
  },
  data() {
    return {
      modal: false,
      itemInfo: "",
      listTitle: "",
      listId: "",
      board: {},
      boardId: "",
      index: "",
    };
  },
  methods: {
    editFinish: function (itemInfo) {
      console.log(itemInfo)
      //api処理
      this.modal = false
    },
    removeFinish: function (id, index) {
      this.modal = false
      //api処理
      this.$refs.remove[index].removeItem(id)
    },
    ListToBoardInfo: function (itemInfo, listTitle, listId, listIndex) {
      this.itemInfo = itemInfo
      this.listTitle = listTitle
      this.listId = listId
      this.modal = true
      this.index = listIndex
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style scoped>
@media only screen and (max-width: 768px) {
  .box {
    margin-bottom: 10px;
  }
}
</style>
