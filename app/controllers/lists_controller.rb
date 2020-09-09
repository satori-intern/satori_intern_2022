class ListsController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    # POST /lists/create
    def create
        params = JSON.parse request.body.read
        name = params['name']
        board_id = params['board_id']
        index = List.where(board_id: board_id).exists? ? List.where(board_id: board_id).order(index: :desc).first['index'] + 1 : 1

        if list = List.create(name: name, board_id: board_id, index: index)
            id = list.id
            render json: { id: id }
        else
            render json: { message: 'error' }
        end
    end

    def edit
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
