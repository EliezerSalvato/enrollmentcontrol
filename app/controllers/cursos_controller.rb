class CursosController < ApplicationController
  before_action :set_curso, only: [:edit, :update, :destroy]
  before_action :set_options_for_select, only: [:new, :edit, :update, :create]

  # GET /cursos
  # GET /cursos.json
  def index
    @cursos = Curso.all.page(params[:page]).per(15)
  end

  # GET /cursos/new
  def new
    @curso = Curso.new
  end

  # GET /cursos/1/edit
  def edit
  end

  # POST /cursos
  # POST /cursos.json
  def create
    @curso = Curso.new(curso_params)

    respond_to do |format|
      if @curso.save
        format.html { redirect_to cursos_path, notice: I18n.t('messages.created') }
        format.json { render :show, status: :created, location: @curso }
      else
        format.html { render :new }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cursos/1
  # PATCH/PUT /cursos/1.json
  def update
    respond_to do |format|
      if @curso.update(curso_params)
        format.html { redirect_to cursos_path, notice: I18n.t('messages.updated') }
        format.json { render :show, status: :ok, location: @curso }
      else
        format.html { render :edit }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    if @curso.destroy
      respond_to do |format|
        format.html { redirect_to cursos_path, notice: I18n.t('messages.destroyed') }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to cursos_path, alert: I18n.t('messages.error_destroyed') }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_options_for_select
      @periodo_options_for_select = [[I18n.t('options.morning'), 1], [I18n.t('options.afternoon'), 2], [I18n.t('options.integral'), 3]]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_curso
      @curso = Curso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curso_params
      params.require(:curso).permit(:nome, :valor_inscricao, :periodo)
    end
end
