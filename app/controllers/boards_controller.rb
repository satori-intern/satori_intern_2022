class BoardsController < ApplicationController
    protect_from_forgery with: :null_session

    # show boards list
    def home
        @boards = Board.all
    end

    # create board
    def create_page
    end
    def create
        board = Board.create(name: params[:name])
        redirect_to :action => 'home'
    end

    # edit board
    def edit_page
        @board = Board.find(params[:id])
    end
    def edit
        board = Board.find(params[:id])
        board.name = params[:name]
        board.save
        redirect_to :action => 'home'
    end

    # destroy board
    def destroy_page
        @board = Board.find(params[:id])
    end
    def destroy
        board = Board.find(params[:id])
        board.destroy
        redirect_to :action => 'home'
    end

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
