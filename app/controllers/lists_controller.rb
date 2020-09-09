class ListsController < ApplicationController
    def create
        name = params[:name]
        board_id = params[:board_id]
        id = 0
        # TODO
        render json: {id: id}
    end

    def update
        id = params[:id]
        name = params[:name]
        # TODO
        render json: {}
    end

    def destroy
        id = params[:id]
        # TODO
        render json: {}
    end

    def move
        id = params[:id]
        toid = params[:to_id]
        # TODO
        render json: {}
    end
end
