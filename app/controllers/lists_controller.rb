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

    # PUT lists/update
    def update
        list = List.find(params[:id])
        list.name = params[:name]
        list.save
        render json: {}
    end

    # DELETE lists/destroy
    def destroy
        list = List.find(params[:id])
        list.destroy
        new_index = List.where('`board_id` = ?', list.board_id).where('`index` > ?', list.index).update_all('`index` = `index` - 1')
        render json: {}
    end

    def move
        id = params[:id]
        to_id = params[:to_id]
        
        if id
            from_list = List.find(id)
            from_index = from_list.index
            board_id = from_list.board_id
        else
            raise NoValueError
        end
        if to_id
            to_list = List.find(to_id)
            to_index = to_list.index
            if board_id != to_list.board_id
                raise InvalidDataError
            end
        else
            to_index = -1
        end
        if from_index > to_index
            List.where('`board_id` = ?', board_id)
                .where('? < `index`', to_index)
                .where('`index` < ?', from_index)
                .update_all('`index` = `index` + 1')
            from_list.index = to_index + 1
        else
            List.where('`board_id` = ?', board_id)
                .where('? < `index`', from_index)
                .where('`index` <= ?', to_index)
                .update_all('`index` = `index` - 1')
            from_list.index = to_index
        end
        from_list.save

        render json: {}
    end
end
