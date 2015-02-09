class ShoutsController < ApplicationController
  before_action :set_shout, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @shouts = @user.shouts
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
    
