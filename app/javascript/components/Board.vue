<template>
<div class="bg-info">
    <h3 class="text-light p-1">{{board.name}}</h3>
    <div class="container p-1">
        <div class="row a">
            <draggable v-model="board.lists" group="lists" :options="{animation:500}" class="row">
                <div v-for="list in board.lists" :key="list.id" class="col-12 col-md-4 col-lg-3 list">
                    <List :list-copy="list" />
                </div>
                <div class="col-12 col-md-4 col-lg-3">
                    <button type="button" class="btn btn-outline-light d-flex align-self-center">
                        <span class="material-icons">add</span> リストを追加する
                    </button>
                </div>
            </draggable>
        </div>
    </div>
</div>
</template>

<script>
import List from "./List";
import draggable from "vuedraggable";
import axios from "axios";

export default {
    name: "Board",
    components: {
        List,
        draggable,
    },
    mounted() {
        this.boardId = location.pathname.split("/")[2];
        axios
            .post("/boards/get_board_data", {
                id: this.boardId
            })
            .then((response) => {
                this.board = response.data;
                console.log(response.data);
            });
    },
    data() {
        return {
            board: {},
            boardId: "",
        };
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->

<style scoped>
.a {
    user-select: none;
    -moz-user-select: none;
    /* Firefox */
    -webkit-user-select: none;
    /* Safari、Chromeなど */
    -ms-user-select: none;
    /* IE10かららしい */
}

@media only screen and (max-width: 768px) {
    .box {
        margin-bottom: 10px;
    }
}
</style>
