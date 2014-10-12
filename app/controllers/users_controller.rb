class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @percentage = @user.similar_to(current_user)
    @tags = Tag.all
    @activity_tags = Tag.where(category: "activity")
    @goal_tags = Tag.where(category: "goal")
    @interest_tags = Tag.where(category: "interest")
    
    #initializing location so so that user can enter zip
    @location = Location.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit

    respond_to do |format|
      format.html { redirect_to @user }
      format.js {}
    end

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
    if user_params["photo"]
      new_orig_filename = user_params["photo"].original_filename.downcase
      user_params["photo"].original_filename = new_orig_filename
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.js {}
      end
    end

    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: 'User was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def tag
    @user = User.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    @user.tags << @tag

    respond_to do |format|
      format.html { redirect_to @user }
      format.js {}
    end
  end

  def delete_tagging
    @user = User.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    @user.tags.delete(@tag)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js {}
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
      # params[:user]
      params.require(:user).permit(:photo, :firstname, :lastname, :age, :gender, :description, :search_radius)
    end
end
