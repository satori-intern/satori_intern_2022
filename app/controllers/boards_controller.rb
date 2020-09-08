class BoardsController < ApplicationController
    def get_board_data
        id = params[:id]
        board_data = {}
        # TODO
        render json: board_data
    end
end
