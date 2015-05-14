class HistoriesController < ApplicationController
  def index
    @user = User.find_by(id: params['user_id'])
    # @histories = @user.edited_histories.ordered
    @histories = History.includes(:changelogs,:editer,:edited).where('edited_id = ?',@user.id).ordered
  end

  def show
  end

  def rollback
    @user = User.find_by(id: params['user_id'])
    history_rollbacks = History.includes(:changelogs).where('id >= ? and edited_id = ?',params['id'],params['user_id']).ordered

    if history_rollbacks
      history_rollbacks.each do |h|
        h.changelogs.each do |change|
          @user[change.data_name] = change.data_from if @user[change.data_name]
          @user.save if @user.valid?
        end
        h.try(:destroy)
      end
    end
    redirect_to user_histories_path(@user), notice: 'Success to rollback information to history id ' + params['id']
  end
end
