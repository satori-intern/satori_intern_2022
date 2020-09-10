<template>
  <transition name="modals" appear>
    <div class="modals modals-overlay">
      <div class="modals-window">
        <div class="modals-content">
            <p id="list-name">{{ listName }}</p>
            <p id="task-tag">タスク</p>
            <input type="text" v-model="EditItemInfo.name" class='edit form-control'>
            <p id="explain-tag">説明</p>
            <!-- <input type="text" v-model="EditItemInfo.detail" class='edit form-control'> -->
            <textarea class="form-control" id="FormControlTextarea1" rows="3" v-model="EditItemInfo.detail"></textarea>
            <button id="complete-button" class="btn btn-outline-dark btn-lg" @click="edit">完了</button>
            <button id="remove-button" class="btn btn-danger btn-lg" @click="remove">削除</button>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  name: 'EditModal',
  props: ['itemInfo', 'listTitle', 'listId'],
  data() {
    return {
      EditItemInfo: JSON.parse(JSON.stringify(this.itemInfo)),
      listName: this.listTitle,
      listNum: this.listId
    }
  },
  methods: {
    edit: function () {
      this.itemInfo.name = this.EditItemInfo.name
      this.itemInfo.detail = this.EditItemInfo.detail
      console.log(this.itemInfo)
      this.$emit('editFinish')
    },
    remove: function () {
      this.$emit('removeFinish', this.itemInfo.id, this.listNum)
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
  transition: opacity 0.3s ease 0.2s;
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
  padding: 5px;
  margin-top: 7px;
  margin-bottom: 16px;
}

#FormControlTextarea1 {
  width: 100%;
  color: #000000;
  font-size: 15px;
  text-align: left;
  padding: 5px;
  margin-top: 7px;
  margin-bottom: 16px;
}
.btn {
  margin: 6px;
}
</style>