module Apis
    class ItemsController < ApiController
        def create
            # params = JSON.parse request.body.read
            name = params['name']
            list_id = params['list_id']
            index = Item.where(list_id: list_id).exists? ? Item.where(list_id: list_id).order(index: :desc).first['index'] + 1 : 1

            item = Item.create(name: name, list_id: list_id, index: index, detail: '')
            unless item.valid?
                response_bad_request(item.errors.messages)
                return
            end
            id = item.id
            response_success({ id: id })
        rescue ActiveRecord::NotNullViolation => e
            response_bad_request(e)
        rescue ActiveRecord::RecordInvalid => e
            response_bad_request(e)
        rescue ActiveRecord::RecordNotFound => e
            response_not_found(e)
        end

        def update
            item = Item.find(params[:id])

            item.name = params[:name]
            item.detail = params[:detail]
            item.save!
            unless item.valid?
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

        def destroy
            item = Item.find(params[:id])
            
            ActiveRecord::Base.transaction do
                Item.where("`list_id` = ?", item.list_id)
                    .where("`index` > ?", item.index)
                    .update_all('`index` = `index` - 1')
                item.destroy
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
            to_list_id = params[:list_id].to_i
            
            from_item = Item.find(id)
            from_index = from_item.index
            from_list_id = from_item.list_id

            unless Item.where('`id` = ?', to_id).exists?
                List.find(to_list_id)
                to_index = 0
            else
                to_item = Item.find(to_id)
                to_index = to_item.index
                to_list_id = to_item.list_id
                if to_list_id != to_list_id
                    response_bad_request('The destination list ID and the list ID of the destination item are different.')
                    return
                end
            end
            ActiveRecord::Base.transaction do
                if from_list_id != to_list_id
                    # 他のリストに移動させるなら
                    # 移動前のアイテムの後ろのindexすべてを-1する
                    Item.where('`list_id` = ?', from_list_id)
                        .where('? < `index`', from_index)
                        .update_all('`index` = `index` - 1')
                    # 移動後のアイテムの後ろのindexすべてを+1する
                    Item.where('`list_id` = ?', to_list_id)
                        .where('? < `index`', to_index)
                        .update_all('`index` = `index` + 1')
                    # listの移動
                    from_item.list_id = to_list_id
                    from_item.index = to_index + 1
                elsif from_index > to_index
                    Item.where('`list_id` = ?', to_list_id)
                        .where('? < `index`', to_index)
                        .where('`index` < ?', from_index)
                        .update_all('`index` = `index` + 1')
                    from_item.index = to_index+1
                else
                    Item.where('`list_id` = ?', to_list_id)
                        .where('? < `index`', from_index)
                        .where('`index` <= ?', to_index)
                        .update_all('`index` = `index` - 1')
                    from_item.index = to_index
                end
                from_item.save!
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