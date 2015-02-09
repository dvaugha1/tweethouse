class ShoutsController < ApplicationController
  before_action :set_shout, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @shouts = Shout.all
  end

  def show
    @shout = Shout.find(params[:id])
    respond_to do |format|
      format.html { render :show}
      format.json { @shout.to_json }
    end
  end

  def month
    @shouts = @shouts.user.where("strftime('%Y-%m', created_at) = ?", params[:month])
  end

  def edit
    @shout = Shout.find(params[:id])
    render :edit
  end

  def create
    @shout = Shout.new(shout_params)
    @shout.user_id = params[:user_id]

    respond_to do |format|
      if @shout.save
        format.html { redirect_to [@user, @shout], notice: 'You shouted out!' }
        format.json { render :show, status: :created, location: [@user, @shout] }
      else
        format.html { render :new }
        format.json { render json: @shout.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shout.update(shout_params)
        format.html { redirect_to @shout, notice: 'You changed that shout yo!'}
        format.json { :show, status: :ok, location: @shout }
      else
        format.html { render :edit}
        format.json { render json: @shout.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shout.destroy
    respond_to do |format|
      format.html {redirect_to shouts_url, notice: 'You unshouted!'}
      format.json { head :no_content}
    end
  end

  private

  def set_shout
    @shout = Shout.find(params[:user_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def shout_params
    params.require(:shout).permit(:title, :body)
  end
end