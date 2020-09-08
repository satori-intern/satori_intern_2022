<template>
  <div class="bg-info">
    <h4>{{board.board_name}}</h4>
    <div class="container p-1">
      <div class="row">
        <div
          class="col-12 col-md-4 col-lg-3"
          v-for="(list, key) in board.lists"
          :key="key"
        >
          <List :items="list.items" :list_title="list.name" />
        </div>
        <div class="col-12 col-md-4 col-lg-3">
          <button type="button" class="btn btn-outline-light d-flex align-self-center">
            <span class="material-icons">add</span> リストを追加する
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import List from "./List";

export default {
  name: "Board",
  data() {
    return {
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
