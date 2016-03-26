class TksController < ApplicationController
  before_action :set_tk, only: [:show, :edit, :update, :destroy]

  # GET /tks
  # GET /tks.json
  def index
    @tks = Tk.all
  end

  # GET /tks/1
  # GET /tks/1.json
  def show
  end

  # GET /tks/new
  def new
    @tk = Tk.new
  end

  # GET /tks/1/edit
  def edit
  end

  # POST /tks
  # POST /tks.json
  def create
    @tk = Tk.new(tk_params)

    respond_to do |format|
      if @tk.save
        format.html { redirect_to @tk, notice: 'Tk was successfully created.' }
        format.json { render :show, status: :created, location: @tk }
      else
        format.html { render :new }
        format.json { render json: @tk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tks/1
  # PATCH/PUT /tks/1.json
  def update
    respond_to do |format|
      if @tk.update(tk_params)
        format.html { redirect_to @tk, notice: 'Tk was successfully updated.' }
        format.json { render :show, status: :ok, location: @tk }
      else
        format.html { render :edit }
        format.json { render json: @tk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tks/1
  # DELETE /tks/1.json
  def destroy
    @tk.destroy
    respond_to do |format|
      format.html { redirect_to tks_url, notice: 'Tk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tk
      @tk = Tk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tk_params
      params.require(:tk).permit(:title, :content)
    end
end
