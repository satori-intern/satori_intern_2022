<template>
  <transition name="modal" appear>
    <div class="modal modal-overlay">
      <!-- 周りをクリックしたら変更を破棄 -->
      <div class="modal-window" @click.self="$emit('close')">
        <div class="modal-contents">
          <p id="list-name">リスト名</p>
          <p id="task-tag">タスク</p>
          <input type="text" v-model="item_value.name" class='edit form-control'>
          <p id="explain-tag">説明</p>
          <input type="text" v-model="item_value.detail" class='edit form-control'>
          <button id="complete-button" class="btn btn-outline-dark btn-lg" @click.self="$emit('close')">完了</button>
          <!-- <button id="remove-button" class="btn btn-danger btn-lg" @click="openRemoveModal()">削除</button> -->
          <!-- <removeModal @close="closeRemoveModal" v-if="removeModal"></removeModal> -->
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
// import removeModal from './removeModal.vue'
export default {
  name: 'EditModal',
  props: ['val'],
//   components: { 
//     removeModal
//   },
  data() {
    return {
      removeModal: false,
      isRemove: false,
      // 編集を保存しない時に使用
      keep_item_value: this.val,
      item_value: JSON.parse(JSON.stringify(this.val)),
    }
  },
  mounted : function(){
    console.log(this.val)
    // this.$emit('close')
  },
  methods: {
    openRemoveModal() {
      this.removeModal = true
    },
    closeRemoveModal(isRemove) {
      this.removeModal = false
      if (isRemove) {
        this.$emit('close', this.keep_item_value, !this.isRemove)
      }
    },
  },
}
</script>

<style lang="scss" scoped>
.modal {
  &.modal-overlay {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .5);
    display: table;
    transition: opacity .3s ease;
  }
  &-window {
    height: 100%;
    display: flex;
    align-items: center;
  }
  &-contents {
    width: 80%;
    max-width: 840px;
    margin: 0 auto;
    padding: 30px 2vw 40px;
    border: 2px solid #aaa;
    text-align: center;
    background: #fff;
    box-sizing: border-box;
    box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
    transition: all .3s ease;
  }
  &-footer {
    background: #ccc;
    padding: 10px;
    text-align: right;
  }
}

#list-name {
  width: 100%;
  color: #000000;
  font-size: 25px;
  font-weight: bold;
  text-align: left;
  margin-bottom: 0px;
}
#task-tag {
  width: 100%;
  color: #000000;
  font-size: 18px;
  font-weight: bold;
  text-align: left;
  margin-bottom: 0px;
}
#explain-tag {
  width: 100%;
  color: #000000;
  font-size: 18px;
  font-weight: bold;
  text-align: left;
  margin-bottom: 0px;
}
.edit{
  width: 100%;
  color: #000000;
  font-size: 15px;
  text-align: left;
  padding: 0px;
  margin-top: 7px;
  margin-bottom: 16px;
}
.btn {
  margin: 6px;
}