<template>
  <div class="bg-info">
    <h3 class="text-light p-1">{{board.name}}</h3>
    <div class="container p-1">
      <div class="row">
        <draggable v-model="board.lists" group="lists" class="row">
          <div v-for="list in board.lists" :key="list.id" class="col-12 col-md-4 col-lg-3">
            <List :list-items="list.items" :list-title="list.name" :id="list.id" />
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

export default {
  name: "Board",
  methods: {
    // モーダルで編集したものの通信も行う
    addList: function (newName) {
      const newListId = axios
        .post("/lists/create", { name: newName, board_id: this.boardId })
        .then((res) => res.data.id);
      const newList = {
        id: newListId,
        name: newName,
        items: [],
      };
      this.board.lists.push(newList);
    },
  },
  components: {
    List,
    draggable,
    AddBtn
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
      board: {},
      boardId: "",
      addType: "リスト"
    };
  },
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
