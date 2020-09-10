class BoardsController < ApplicationController
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
end
