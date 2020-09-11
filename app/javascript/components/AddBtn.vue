<template>
  <div>
    <button type="button" :class="btnClass" @click="switchAdd">
      <span class="material-icons">add</span>
      {{addType}}を追加
    </button>
    <div class="input-group" v-if="showAdd">
      <input type="text" class="form-control" placeholder="名前" v-model="newName" />
      <div class="input-group-append">
        <button class="btn btn-success" type="button" @click="sendNewName">追加</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AddBtn",
  data() {
    return {
      showAdd: false,
      newName: "",
      btnClass:
        this.addType == "リスト"
          ? "btn btn-outline-light d-flex align-self-center"
          : "btn btn-outline-info d-flex align-self-center",
    };
  },
  methods: {
    switchAdd: function () {
      this.showAdd = this.showAdd ? false : true;
    },
    sendNewName: function () {
      this.$emit("catchNewName", this.newName);
      this.newName = ""
    },
  },
  props: {
    addType: {
      type: String,
    },
  },
};
</script>