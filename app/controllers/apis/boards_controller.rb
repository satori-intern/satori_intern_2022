module Apis
    class BoardsController < ApiController
        # API: get_board_data
        def get_board_data
            id = params[:id]
            board = Board.find(id)
            lists = List.where(board_id: id).order(:index)
            board_data = {
                name: board[:name],
                lists: []
            }
            lists.each do |list|
                p list[:id]
                items = Item.where(list_id: list[:id]).order(:index)
                list_tmp = list.slice(:id, :name)
                list_tmp.store(:items, items.map{|item| item.slice(:id, :name, :detail)})
                board_data[:lists].push(list_tmp)
            end
            render json: board_data
        end
    end
end
