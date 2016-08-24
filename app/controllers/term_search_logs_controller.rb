class TermSearchLogsController < ApplicationController
  before_action :set_term_search_log, only: [:show, :edit, :update, :destroy]

  # GET /term_search_logs
  # GET /term_search_logs.json
  def index
    @term_search_logs = TermSearchLog.all
  end

  # GET /term_search_logs/1
  # GET /term_search_logs/1.json
  def show
  end

  # GET /term_search_logs/new
  def new
    @term_search_log = TermSearchLog.new
  end

  # GET /term_search_logs/1/edit
  def edit
  end

  # POST /term_search_logs
  # POST /term_search_logs.json
  def create
    @term_search_log = TermSearchLog.new(term_search_log_params)

    respond_to do |format|
      if @term_search_log.save
        format.html { redirect_to @term_search_log, notice: 'Term search log was successfully created.' }
        format.json { render :show, status: :created, location: @term_search_log }
      else
        format.html { render :new }
        format.json { render json: @term_search_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /term_search_logs/1
  # PATCH/PUT /term_search_logs/1.json
  def update
    respond_to do |format|
      if @term_search_log.update(term_search_log_params)
        format.html { redirect_to @term_search_log, notice: 'Term search log was successfully updated.' }
        format.json { render :show, status: :ok, location: @term_search_log }
      else
        format.html { render :edit }
        format.json { render json: @term_search_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /term_search_logs/1
  # DELETE /term_search_logs/1.json
  def destroy
    @term_search_log.destroy
    respond_to do |format|
      format.html { redirect_to term_search_logs_url, notice: 'Term search log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term_search_log
      @term_search_log = TermSearchLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_search_log_params
      params.require(:term_search_log).permit(:term_id, :user_id)
    end
end
