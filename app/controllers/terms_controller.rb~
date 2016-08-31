class TermsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  skip_before_action :set_term, only: [:search, :search_word]

  # GET /terms
  # GET /terms.json
  def index
    #@terms = Term.all.paginate(:page => params[:page])
    @terms = [] 
  end
  
  def search_word 
  #  if term = Term.find(params[:q])
  #    redirect_to :show, id: term
  #  end
    redirect_to action: :show, id: params[:q]
  end   
    
  
=begin  
    if @term = Term.find(params[:q])
      @found_terms = Term.where(name: @term.name).includes(:dictionary).order('dictionaries.position')
    end
    @term.users << current_user 
    render :show
=end
    
 # end

  # GET /terms/1
  # GET /terms/1.json
  def show
   if @term   
      @found_terms = Term.where(name: @term.name).includes(:dictionary).order('dictionaries.position')
    end
    @term.users << current_user
  end

  # GET /terms/new
  def new
    @term = Term.new
  end

  # GET /terms/1/edit
  def edit
  end

  # POST /terms
  # POST /terms.json
  def create
    @term = Term.new(term_params)

    respond_to do |format|
      if @term.save
        format.html { redirect_to @term, notice: 'Term was successfully created.' }
        format.json { render :show, status: :created, location: @term }
      else
        format.html { render :new }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terms/1
  # PATCH/PUT /terms/1.json
  def update
    respond_to do |format|
      if @term.update(term_params)
        format.html { redirect_to @term, notice: 'Term was successfully updated.' }
        format.json { render :show, status: :ok, location: @term }
      else
        format.html { render :edit }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.json
  def destroy
    @term.destroy
    respond_to do |format|
      format.html { redirect_to terms_url, notice: 'Term was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  #.first.terms.limit(1).order("RANDOM()")
  def search
    if q = params[:q]
      search_dictionary_ids = params[:search_dictionary_ids].present? \
        ? params[:search_dictionary_ids] : [3]
      
      r = Term.search do 
        fulltext q  do
          boost_fields name: 2.0
          phrase_fields definition: 2.0
        end
        #order_by :position, :asc
        with :dictionary_id, search_dictionary_ids  if search_dictionary_ids.present?
      end
      @results = r.results
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term
      @term = Term.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_params
      params.require(:term).permit(:name, :definition, :parent_id, :dictionary_id, :position)
    end
end
