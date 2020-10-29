class TechbitsController < ApplicationController
  include SessionsHelper
  include UsersHelper
  include TechbitsHelper
  before_action :require_login
  before_action :set_techbit, only: %i[show edit update destroy]

  # GET /techbits
  # GET /techbits.json
  def index
    @techbits = Techbit.where('author_id in (?)', (
      logged_user.followed_ids + [logged_user.id]
    ).uniq)
      .includes(:author)
      .order(created_at: :desc)
    @techbit = Techbit.new
    @users = User.where.not('user_id in (?)', (
      logged_user.followed_ids + [logged_user.id]
    ))
      .includes(:author)
      .order(created_at: :desc).limit(5)
  end

  # GET /techbits/1
  # GET /techbits/1.json
  def show; end

  # GET /techbits/new
  def new
    @techbit = logged_user.techbits.new
  end

  # GET /techbits/1/edit
  def edit; end

  # POST /techbits
  # POST /techbits.json
  def create
    @techbit = logged_user.techbits.build(techbit_params)

    respond_to do |format|
      if @techbit.save
        format.html { redirect_to root_path, notice: 'Techbit was successfully created.' }
        format.json { render :show, status: :created, location: @techbit }
      else
        # format.html { render :new }
        format.html { redirect_to root_path, notice: 'Check that you have a valid input!' }
        format.json { render json: @techbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /techbits/1
  # PATCH/PUT /techbits/1.json
  def update
    respond_to do |format|
      if @techbit.update(techbit_params)
        format.html { redirect_to @techbit, notice: 'Techbit was successfully updated.' }
        format.json { render :show, status: :ok, location: @techbit }
      else
        format.html { render :edit }
        format.json { render json: @techbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /techbits/1
  # DELETE /techbits/1.json
  def destroy
    @techbit.destroy
    respond_to do |format|
      format.html { redirect_to techbits_url, notice: 'Techbit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_techbit
    @techbit = Techbit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def techbit_params
    params.require(:techbit).permit(:bit)
  end
end
