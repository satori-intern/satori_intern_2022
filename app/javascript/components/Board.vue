<template>
  <div class="bg-info">
    <h3 class="text-light p-1">{{board.board_name}}</h3>
    <div class="container p-1">
      <div class="row">
        <div class="col-12 col-md-4 col-lg-3" v-for="(list, key) in board.lists" :key="key">
          <List :list-items="list.items" :list-title="list.name" :list-id="list.id" />
        </div>
        <div class="col-12 col-md-4 col-lg-3">
          <button
            type="button"
            class="btn btn-outline-light d-flex align-self-center"
            @click="switchAddList"
          >
            <span class="material-icons">add</span> リストを追加する
          </button>
          <div class="input-group" v-if="showAddList">
            <input
              type="text"
              class="form-control"
              placeholder="リスト名"
              v-model="newListName"
            />
            <div class="input-group-append">
              <button class="btn btn-success" type="button" @click="addList">追加</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import List from "./List";

export default {
  name: "Board",
  methods: {
    switchAddList: function () {
      this.showAddList = this.showAddList ? false : true;
    },
    addList: function() {
      const addBoardId = 0 //location.pathname.replace()でとる？
      const newListName = this.newListName
      const newListId = 0 // axiosで取得する
      const newList = {
        id: newListId,
        name: newListName,
        items: []
      }
      this.board.lists.push(newList)
      this.showAddList = false
    }
  },
  data() {
    return {
      newListName: "",
      showAddList: false,
      board: {
        board_name: "イルカ",
        lists: [
          {
            id: 0,
            name: "TODO",
            items: [
              {
                id: 1,
                name: "今日の献立を考える",
                detail: "今日はお肉が良さそう",
              },
              {
                id: 2,
                name: "ご飯を食べる",
                detail: "お腹減ったな〜",
              },
            ],
          },
          {
            id: 3,
            name: "Doing",
            items: [
              {
                id: 4,
                name: "天気を予想する",
                detail: "今日は風が騒がしいな...",
              },
            ],
          },
          {
            id: 5,
            name: "Done",
            items: [
              {
                id: 6,
                name: "家計簿をつける",
                detail: "え、今月の収支ヤバすぎ！？",
              },
              {
                id: 7,
                name: "予算を立てる",
                detail: "給付金をあてにしよう",
              },
            ],
          },
        ],
      },
    };
  },
  components: {
    List,
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
