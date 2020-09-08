<template>
  <div class="bg-info">
    <h4>
    <div class="container p-1">
      <div class="row">
        <div
          class="col-12 col-md-4 col-lg-3"
          v-for="(items, list_title) in lists"
          :key="list_title"
        >
          <List :items="items" :list_title="list_title" />
        </div>
        <div class="col-12 col-md-4 col-lg-3">
          <button type="button" class="btn btn-outline-light d-flex align-self-center"><span class="material-icons">add</span> リストを追加する</button>
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
      lists: {
        TODO: ["今日の献立を考える", "ご飯を食べる"],
        Doing: ["天気を予想する"],
        Done: ["家計簿をつける", "予算を立てる"],
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
@media only screen and (max-width:768px){
    .box{margin-bottom:10px;}
}
</style>
