class ListsController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    # POST /lists/create
    def create
        # params = JSON.parse request.body.read
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

    def update
        id = params[:id]
        name = params[:name]
        # TODO
        render json: {}
    end

    # DELETE lists/destroy
    def destroy
        list = List.find(params[:id])
        list.destroy
        new_index = List.where('`board_id` = ?', list.board_id).where('`index` > ?', list.index).update_all('`index` = `index` - 1')
    end

    def move
        id = params[:id]
        toid = params[:to_id]
        # TODO
        render json: {}
    end
end
