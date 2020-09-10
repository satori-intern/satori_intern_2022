<template>
  <transition name="modals" appear>
    <div class="modals modals-overlay" @click.self="$emit('close')">
      <div class="modals-window">
        <div class="modals-content">
            <p id="list-name">リスト名</p>
            <p id="task-tag">タスク</p>
            <input type="text" v-model="item_value.name" class='edit form-control'>
            <p id="explain-tag">説明</p>
            <input type="text" v-model="item_value.detail" class='edit form-control'>
            <button id="complete-button" class="btn btn-outline-dark btn-lg" @click="test">完了</button>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  name: 'SampleModal',
  props: ['val'],
  data() {
    return {
      removeModal: false,
      isRemove: false,
      // 編集を保存しない時に使用
      keep_item_value: this.val,
      item_value: JSON.parse(JSON.stringify(this.val)),
    }
  },
  methods: {
    test () {
      console.log(this.val)
      this.val.name = this.item_value.name
    }
  },
}
</script>

<style lang="scss" scoped>
.modals {
  &.modals-overlay {
    display: flex;
    align-items: center;
    justify-content: center;
    position: fixed;
    z-index: 30;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
  }

  &-window {
    background: #fff;
    border-radius: 4px;
    overflow: hidden;
  }

  &-content {
    padding: 10px 20px;
  }
}

// オーバーレイのトランジション
.modals-enter-active, .modals-leave-active {
  transition: opacity 0.4s;

  // オーバーレイに包含されているモーダルウィンドウのトランジション
  .modals-window {
    transition: opacity 0.4s, transform 0.4s;
  }
}

// ディレイを付けるとモーダルウィンドウが消えた後にオーバーレイが消える
.modals-leave-active {
  transition: opacity 0.6s ease 0.4s;
}

.modals-enter, .modals-leave-to {
  opacity: 0;

  .modals-window {
    opacity: 0;
    transform: translateY(-20px);
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
</style>