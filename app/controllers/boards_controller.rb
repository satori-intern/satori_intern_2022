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
        board = current_user.boards.create(name: params[:name])
        unless board.valid?
            flash[:alert] = '不正な値です'
            redirect_to :action => 'new'
            return
        end
        redirect_to :action => 'index'
    rescue ActiveRecord::NotNullViolation => e
        flash[:alert] = '不正な値です'
        redirect_to :action => 'new'
        return
    end

    # edit board
    def edit
        @board = Board.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
        response_bad_request
    end

    def update
        board = Board.find(params[:id])
        board.name = params[:name]
        board.save!
        redirect_to :action => 'index'
    rescue ActiveRecord::RecordNotFound => e
        response_bad_request
    rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = '不正な値です'
        redirect_to :action => 'edit'
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
            flash[:notice] = "共有に成功しました"
            redirect_to :action => 'index'
        end
    rescue ActiveRecord::RecordNotFound => e
        response_bad_request
    end

    # destroy board
    def destroy
        board = Board.find(params[:id])
        board.destroy!
        redirect_to :action => 'index'
    rescue ActiveRecord::RecordNotFound => e
        response_bad_request
    rescue ActiveRecord::RecordNotDestroyed => e
        flash[:alert] = '削除できませんでした'
        redirect_to :action => 'index'
    end

    # show page
    def show
        @board = Board.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
        response_bad_request
    end
end
