module Apis
    class ItemsController < ApiController
        def create
            # params = JSON.parse request.body.read
            name = params['name']
            list_id = params['list_id']
            index = Item.where(list_id: list_id).exists? ? Item.where(list_id: list_id).order(index: :desc).first['index'] + 1 : 1

            if item = Item.create(name: name, list_id: list_id, index: index, detail: '')
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
            item = Item.find(id)
            item.name = name
            item.detail = detail
            item.save
            render json: {}
        end

        def destroy
            id = params[:id]
            item = Item.find(id)
            Item.where("`list_id` = ?", item.list_id)
                .where("`index` > ?", item.index)
                .update_all('`index` = `index` - 1')
            item.destroy
            render json: {}
        end

        def move
            id = params[:id]
            to_id = params[:to_id]
            to_list_id = params[:list_id].to_i
            
            if id
                from_item = Item.find(id)
                from_index = from_item.index
                from_list_id = from_item.list_id
            else
                raise NoValueError
            end
            if to_id
                to_item = Item.find(to_id)
                to_index = to_item.index
                if to_item.list_id != to_list_id
                    raise InvalidDataError
                end
            else
                to_index = -1
            end
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
            from_item.save

            render json: {}
        end
    end
end