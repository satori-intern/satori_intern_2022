class ItemsController < ApplicationController
    def create
        name = params[:name]
        list_id = params[:list_id]
        id = 0
        # TODO
        render json: {id: id}
    end

    def update
        id = params[:id]
        name = params[:name]
        detail = params[:detail]
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
