class IrsCodesController < ApplicationController
  before_action :set_irs_code, only: [:show, :edit, :update, :destroy]

  # GET /irs_codes
  # GET /irs_codes.json
  def index
    @irs_codes = IrsCode.all
  end

  # GET /irs_codes/1
  # GET /irs_codes/1.json
  def show
  end

  # GET /irs_codes/new
  def new
    @irs_code = IrsCode.new
  end

  # GET /irs_codes/1/edit
  def edit
  end

  # POST /irs_codes
  # POST /irs_codes.json
  def create
    @irs_code = IrsCode.new(irs_code_params)

    respond_to do |format|
      if @irs_code.save
        format.html { redirect_to @irs_code, notice: 'Irs code was successfully created.' }
        format.json { render :show, status: :created, location: @irs_code }
      else
        format.html { render :new }
        format.json { render json: @irs_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /irs_codes/1
  # PATCH/PUT /irs_codes/1.json
  def update
    respond_to do |format|
      if @irs_code.update(irs_code_params)
        format.html { redirect_to @irs_code, notice: 'Irs code was successfully updated.' }
        format.json { render :show, status: :ok, location: @irs_code }
      else
        format.html { render :edit }
        format.json { render json: @irs_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /irs_codes/1
  # DELETE /irs_codes/1.json
  def destroy
    @irs_code.destroy
    respond_to do |format|
      format.html { redirect_to irs_codes_url, notice: 'Irs code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_irs_code
      @irs_code = IrsCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def irs_code_params
      params.require(:irs_code).permit(:trans_code, :dr_cr_file, :title, :valid_doc_code, :remarks)
    end
end
