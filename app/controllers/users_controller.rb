class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      current_info = get_info
      if @user.update(user_params) and update_history(current_info)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname,:lastname,:dob)
    end

    def get_info
      @user.serializable_hash(only: [:firstname,:lastname,:dob])
    end

    def update_history(current_info)
      history = @user.edited_histories.create(editer_id: current_user.id)  
      if history
        update_changelog(history,current_info)
      end
    end

    def update_changelog(history,current_info)
      ret = false

      diffs = current_info.map{ |k,v| v=v.to_s; [k,v]} - user_params.to_a
      diffs.each do |diff| 
        key = diff[0]
        ret = history.changelogs.create(data_name: key,data_from: current_info[key], data_to: user_params[key])
      end

      ret
    end
end
