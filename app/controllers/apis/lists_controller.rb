module Apis
    class ListsController < ApiController
        # POST /lists/create
        def create
            name = params['name']
            board_id = params['board_id']
            index = List.where(board_id: board_id).exists? ? List.where(board_id: board_id).order(index: :desc).first['index'] + 1 : 1

            if list = List.create(name: name, board_id: board_id, index: index)
                id = list.id
                render json: response200({ id: id })
            else
                render json: response400
            end
        end

        # PUT lists/update
        def update
            list = List.find(params[:id])
            unless list.present?
                render json: response404
                return
            end
            list.name = params[:name]
            unless list.save
                render json: response400
                return
            end 
            render json: response200
        end

        # DELETE lists/destroy
        def destroy
            list = List.find(params[:id])
            unless list.present?
                render json: response404
                return
            end
            ActiveRecord::Base.transaction do
                list.destroy
                new_index = List.where('`board_id` = ?', list.board_id).where('`index` > ?', list.index).update_all('`index` = `index` - 1')
            end
            render json: response200
        rescue ActiveRecord::RecordInvalid
            render json: response400
        end

        def move
            id = params[:id]
            to_id = params[:to_id]
            
            from_list = List.find(id)
            unless from_list.present?
                render json: response404
                return
            end
            from_index = from_list.index
            board_id = from_list.board_id

            to_list = List.find(to_id)
            unless to_list.present?
                to_index = -1
            else
                to_index = to_list.index
            end
                
            end
            ActiveRecord::Base.transaction do
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
            end
            render json: response200
        rescue ActiveRecord::RecordInvalid
            render json: response400
        end
    end
end