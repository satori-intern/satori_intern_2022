<template>
  <div class="card">
    <div class="d-flex">
      <div class="p-2 align-self-center w-100">{{item.name | truncate}}</div>
      <div class="p-2 flex-shrink-1">
        <button type="button" class="btn btn-outline-info align-self-center" @click="modalBtn">
          <span class="material-icons">info</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Item",
  methods: {
    modalBtn() {
      this.$emit("ItemToListInfo", this.item);
    },
  },
  filters: {
    truncate: function (value) {
      var length = 10;
      var ommision = "...";
      if (value.length <= length) {
        return value;
      }
      return value.substring(0, length) + ommision;
    },
  },
  props: {
    itemCopy: {
      type: Object,
    },
  },
  data() {
    return {
      item: this.itemCopy,
    };
  },
};
</script>

<style scoped>
.card {
  margin-bottom: 10px;
}
</style>