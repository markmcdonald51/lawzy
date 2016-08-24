class PartsOfSpeechesController < ApplicationController
  before_action :set_parts_of_speech, only: [:show, :edit, :update, :destroy]

  # GET /parts_of_speeches
  # GET /parts_of_speeches.json
  def index
    @parts_of_speeches = PartsOfSpeech.all
  end

  # GET /parts_of_speeches/1
  # GET /parts_of_speeches/1.json
  def show
  end

  # GET /parts_of_speeches/new
  def new
    @parts_of_speech = PartsOfSpeech.new
  end

  # GET /parts_of_speeches/1/edit
  def edit
  end

  # POST /parts_of_speeches
  # POST /parts_of_speeches.json
  def create
    @parts_of_speech = PartsOfSpeech.new(parts_of_speech_params)

    respond_to do |format|
      if @parts_of_speech.save
        format.html { redirect_to @parts_of_speech, notice: 'Parts of speech was successfully created.' }
        format.json { render :show, status: :created, location: @parts_of_speech }
      else
        format.html { render :new }
        format.json { render json: @parts_of_speech.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parts_of_speeches/1
  # PATCH/PUT /parts_of_speeches/1.json
  def update
    respond_to do |format|
      if @parts_of_speech.update(parts_of_speech_params)
        format.html { redirect_to @parts_of_speech, notice: 'Parts of speech was successfully updated.' }
        format.json { render :show, status: :ok, location: @parts_of_speech }
      else
        format.html { render :edit }
        format.json { render json: @parts_of_speech.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts_of_speeches/1
  # DELETE /parts_of_speeches/1.json
  def destroy
    @parts_of_speech.destroy
    respond_to do |format|
      format.html { redirect_to parts_of_speeches_url, notice: 'Parts of speech was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parts_of_speech
      @parts_of_speech = PartsOfSpeech.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parts_of_speech_params
      params.require(:parts_of_speech).permit(:name, :abbreviation, :description)
    end
end
