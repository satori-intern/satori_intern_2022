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

    def share
        board = Board.find(params[:id])
        user = User.find_by(email: params[:email])
        unless user
            flash[:alert] = "存在しないユーザです"
            redirect_to :action => 'edit'
            return
        end

        if board.users.where(id: user.id).any?
            flash[:alert] = "すでに追加されているユーザです"
            redirect_to :action => 'edit'
        else
            board.users << user
            redirect_to :action => 'index'
        end
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
