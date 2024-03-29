class FreePeriodsController < ApplicationController
  before_action :authorize
  before_action :admin_required
  before_action :set_free_period, only: [:show, :edit, :update, :destroy]
  

  # GET /free_periods
  # GET /free_periods.json
  def index
    @free_periods = FreePeriod.all
  end

  # GET /free_periods/1
  # GET /free_periods/1.json
  def show
  end

  # GET /free_periods/new
  def new
    @free_period = FreePeriod.new
  end

  # GET /free_periods/1/edit
  def edit
  end

  # POST /free_periods
  # POST /free_periods.json
  def create
    @free_period = FreePeriod.new(free_period_params)

    respond_to do |format|
      if @free_period.save
        format.html { redirect_to @free_period, notice: 'Free Period was successfully created.' }
        format.json { render :show, status: :created, location: @free_period }
      else
        format.html { render :new }
        format.json { render json: @free_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /free_periods/1
  # PATCH/PUT /free_periods/1.json
  def update
    respond_to do |format|
      if @free_period.update(free_period_params)
        format.html { redirect_to @free_period, notice: 'Free Period was successfully updated.' }
        format.json { render :show, status: :ok, location: @free_period }
      else
        format.html { render :edit }
        format.json { render json: @free_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /free_periods/1
  # DELETE /free_periods/1.json
  def destroy
    @free_period.destroy
    respond_to do |format|
      format.html { redirect_to free_periods_url, notice: 'Free Period was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_free_period
      @free_period = FreePeriod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def free_period_params
      params.require(:free_period).permit(:name, :amount, :period_id, :description)
    end
end
