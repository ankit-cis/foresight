class CompanyTypesController < ApplicationController
  before_action :authorize
  before_action :company_admin_required

  before_action :set_company_type, only: [:show, :edit, :update, :destroy]

  # GET /company_types
  # GET /company_types.json
  def index
    @company_types = CompanyType.all
  end

  # GET /company_types/1
  # GET /company_types/1.json
  def show
  end

  # GET /company_types/new
  def new
    @company_type = CompanyType.new
  end

  # GET /company_types/1/edit
  def edit
  end

  # POST /company_types
  # POST /company_types.json
  def create
    @company_type = CompanyType.new(company_type_params)

    respond_to do |format|
      if @company_type.save
        format.html { redirect_to @company_type, notice: 'Company type was successfully created.' }
        format.json { render :show, status: :created, location: @company_type }
      else
        format.html { render :new }
        format.json { render json: @company_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_types/1
  # PATCH/PUT /company_types/1.json
  def update
    respond_to do |format|
      if @company_type.update(company_type_params)
        format.html { redirect_to @company_type, notice: 'Company type was successfully updated.' }
        format.json { render :show, status: :ok, location: @company_type }
      else
        format.html { render :edit }
        format.json { render json: @company_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_types/1
  # DELETE /company_types/1.json
  def destroy
    @company_type.destroy
    respond_to do |format|
      format.html { redirect_to company_types_url, notice: 'Company type was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_type
      @company_type = CompanyType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_type_params
      params.require(:company_type).permit(:name, :description)
    end
end
