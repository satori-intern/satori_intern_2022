<template>
  <div class="card">
    <div class="card-body bg-light">
      <h4 class="card-title">{{list_title}}</h4>
      <div v-for="(item, key) in items" :key="key">
        <p><Item :item="item" /></p>
      </div>
      <button type="button" class="btn btn-outline-info d-flex align-self-center"><span class="material-icons">add</span> アイテムを追加</button>
    </div>
  </div>
</template>

<script>
import Item from "./Item";

export default {
  name: "List",
  props: {
    list_title: {
      type: String,
      default: "list_title",
    },
    items: {
      type: Array,
      default: ["items"],
    },
  },
  components: {
    Item,
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
