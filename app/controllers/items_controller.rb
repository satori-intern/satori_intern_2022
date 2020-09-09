class ItemsController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    def create
        # params = JSON.parse request.body.read
        name = params['name']
        list_id = params['list_id']
        index = Item.where(list_id: list_id).exists? ? Item.where(list_id: list_id).order(index: :desc).first['index'] + 1 : 1

        if item = Item.create(name: name, list_id: list_id, index: index)
            id = item.id
            render json: { id: id }
        else
            render json: { message: 'error' }
        end
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
