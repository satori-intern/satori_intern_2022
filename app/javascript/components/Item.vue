<template>
  <div class="card">
    <div class="d-flex">
      <div class="p-2 align-self-center w-100">{{item.name}}</div>
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
      this.showModal = this.showModal ? false : true;
    },
  },
  props: {
    itemItem: {
      type: Object,
    },
  },
  data() {
    return {
      item: this.itemItem,
      showModal: false,
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
