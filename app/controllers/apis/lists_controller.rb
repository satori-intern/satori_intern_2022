module Apis
    class ListsController < ApiController
        # POST /lists/create
        def create
            name = params['name']
            board_id = params['board_id']
            index = List.where(board_id: board_id).exists? ? List.where(board_id: board_id).order(index: :desc).first['index'] + 1 : 1
            
            list = List.create(name: name, board_id: board_id, index: index)
            unless list.valid?
                response_bad_request(list.errors.messages)
                return
            end
            id = list.id
            response_success({ id: id })
        rescue ActiveRecord::NotNullViolation => e
            response_bad_request(e)
        rescue ActiveRecord::RecordInvalid => e
            response_bad_request(e)
        rescue ActiveRecord::RecordNotFound => e
            response_not_found(e)
        end

        # PUT lists/update
        def update
            list = List.find(params[:id])
                
            list.name = params[:name]
            list.save!
            unless list.valid?
                response_bad_request(list.errors.messages)
                return
            end
            response_success
        rescue ActiveRecord::NotNullViolation => e
            response_bad_request(e)
        rescue ActiveRecord::RecordInvalid => e
            response_bad_request(e)
        rescue ActiveRecord::RecordNotFound => e
            response_not_found(e)
        end

        # DELETE lists/destroy
        def destroy
            list = List.find(params[:id])

            ActiveRecord::Base.transaction do
                list.destroy
                new_index = List.where('`board_id` = ?', list.board_id).where('`index` > ?', list.index).update_all('`index` = `index` - 1')
            end
            response_success
        rescue ActiveRecord::NotNullViolation => e
            response_bad_request(e)
        rescue ActiveRecord::RecordInvalid => e
            response_bad_request(e)
        rescue ActiveRecord::RecordNotFound => e
            response_not_found(e)
        end

        def move
            id = params[:id]
            to_id = params[:to_id]
            
            from_list = List.find(id)
            from_index = from_list.index
            board_id = from_list.board_id

        
            unless List.where('`id` = ?', to_id).exists?
                to_index = 0
            else
                to_index = List.find(to_id).index
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
                from_list.save!
            end
            response_success
        rescue ActiveRecord::NotNullViolation => e
            response_bad_request(e)
        rescue ActiveRecord::RecordInvalid => e
            response_bad_request(e)
        rescue ActiveRecord::RecordNotFound => e
            response_not_found(e)
        end
    end
end