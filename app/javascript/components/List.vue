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
import axios from "axios"

export default {
  name: "List",
  methods: {
    addItem: function (newName) {
      const addListId = this.id;
      const newItemId = axios
        .post("/item/create", { name: newName, list_id: addListId })
        .then((res) => res.data.id);
      const newItem = {
        id: newItemId,
        name: newName,
        detail: "",
      };
      this.items.push(newItem);
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