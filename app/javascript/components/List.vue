<template>
  <div class="card">
    <div class="card-body bg-light">
      <h4 class="card-title">{{title}}</h4>
      <div v-for="(item, key) in items" :key="key">
        <p>
          <Item :item-item="item" />
        </p>
      </div>
      <AddBtn @catchNewName="addItem" :add-type="addType" />
    </div>
  </div>
</template>

<script>
import Item from "./Item";
import AddBtn from "./AddBtn";

export default {
  name: "List",
  methods: {
    switchAddItem: function () {
      this.showAddItem = this.showAddItem ? false : true;
    },
    addItem: function (newName) {
      const addListId = this.id;
      const newItemId = 0; // axiosで取得する
      const newItem = {
        id: newItemId,
        name: newName,
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
    AddBtn
  },
  data() {
    return {
      newName: "",
      addType: "アイテム",
      title: this.listTitle,
      items: this.listItems,
      id: this.listId,
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
