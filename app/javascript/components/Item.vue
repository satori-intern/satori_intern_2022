<template>
  <div class="card">
    <div class="d-flex">
      <div class="p-2 align-self-center w-100">{{item_.name}}</div>
      <div class="p-2 flex-shrink-1">
        <button type="button" class="btn btn-outline-info align-self-center" @click="modalBtn">
          <span class="material-icons">info</span>
        </button>
      </div>
    </div>
    <p v-if="showModal" :item_="item_">
      <input v-model="item_.name" />
    </p>
    <!-- dummy -->
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
    item: {
      type: Object,
    },
  },
  data() {
    return {
      item_: this.item,
      showModal: false,
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
