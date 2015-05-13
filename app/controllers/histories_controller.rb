class HistoriesController < ApplicationController
  def index
    user = User.find_by(id: params['user_id'])
    @histories = user.edited_histories
  end

  def show
  end
end
