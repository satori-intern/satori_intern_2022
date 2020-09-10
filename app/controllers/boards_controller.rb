class BoardsController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    # show boards list
    def index
        p current_user
        assignments = Assignment
            .where('`user_id` = ?', current_user.id)
        @boards = []
        assignments.each do |assignment|
            @boards.push(Board.find(assignment.board_id))
        end
    end

    # create board
    def new
    end

    def create
        current_user.boards.create(name: params[:name])
        redirect_to :action => 'index'
    end

    # edit board
    def edit
        @board = Board.find(params[:id])
    end

    def update
        board = Board.find(params[:id])
        board.name = params[:name]
        board.save
        redirect_to :action => 'index'
    end

    # destroy board
    def destroy
        board = Board.find(params[:id])
        board.destroy
        redirect_to :action => 'index'
    end

    # show page
    def show
        @board = Board.find(params[:id])
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
