<template>
  <div class="card">
    <div class="card-body bg-light">
      <h4 class="card-title">{{title}}</h4>
      <div v-for="(item, key) in items" :key="key">
        <p>
          <Item :item-item="item" />
        </p>
      </div>
      <button
        type="button"
        class="btn btn-outline-info d-flex align-self-center"
        @click="switchAddItem"
      >
        <span class="material-icons">add</span> アイテムを追加
      </button>
      <div class="input-group" v-if="showAddItem">
        <input type="text" class="form-control" placeholder="アイテム名" v-model="newItemName" />
        <div class="input-group-append">
          <button class="btn btn-success" type="button" @click="addItem">追加</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Item from "./Item";

export default {
  name: "List",
  methods: {
    switchAddItem: function () {
      this.showAddItem = this.showAddItem ? false : true;
    },
    addItem: function () {
      const addListId = this.id;
      const newItemName = this.newItemName;
      const newItemId = 0; // axiosで取得する
      const newItem = {
        id: newItemId,
        name: newItemName,
        detail: "",
      };
      this.items.push(newItem);
      this.showAddItem = false;
    },
  },
  props: {
    listTitle: {
      type: String,
    },
    listItems: {
      type: Array,
    },
    listId: {
      type: Number,
    },
  },
  components: {
    Item,
  },
  data() {
    return {
      newItemName: "",
      title: this.listTitle,
      items: this.listItems,
      id: this.listId,
      showAddItem: false,
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
