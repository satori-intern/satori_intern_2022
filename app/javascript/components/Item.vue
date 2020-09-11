<template>
  <div class="card">
    <div>
      <div class="d-flex align-self-center float-left w-75"><p style="word-wrap:break-word;">{{item.name}}</p></div>
      <div class="d-flex align-self-center float-right">
        <button type="button" class="btn btn-outline-info" @click="modalBtn">
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
      this.$emit('ItemToListInfo', this.item)
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