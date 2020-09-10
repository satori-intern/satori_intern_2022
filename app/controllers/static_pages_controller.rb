class StaticPagesController < ApplicationController
  def home
  end

  def healthcheck
    render plain: '', status: :ok
  end
end
