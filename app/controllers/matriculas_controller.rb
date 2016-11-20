class MatriculasController < ApplicationController
  before_action :set_matricula, only: [:edit, :update, :destroy, :cancellation]
  before_action :set_alunos_options_for_select, :set_cursos_options_for_select, :set_sim_nao_options_for_select, only: [:new, :edit, :update, :create]

  # GET /matriculas
  # GET /matriculas.json
  def index
    if params[:commit].present?
      @matriculas = Matricula.all
      @matriculas = @matriculas.joins(:aluno).where("alunos.nome LIKE '%#{params[:aluno]}%'") if params[:aluno].present?
      @matriculas = @matriculas.joins(:curso).where("cursos.nome LIKE '%#{params[:curso]}%'") if params[:curso].present?
      @matriculas = @matriculas.where("ano = #{params[:ano]}") if params[:ano].present?
      @matriculas = @matriculas.where("pago = 0") if params[:pagamento_pendente].present?
    else
      @matriculas = Matricula.where(ativo: 1)
    end

    @matriculas = @matriculas.page(params[:page]).per(15)
  end

  # GET /matriculas/new
  def new
    @matricula = Matricula.new
  end

  # GET /matriculas/1/edit
  def edit
  end

  def filter

  end

  # POST /matriculas
  # POST /matriculas.json
  def create
    @matricula = Matricula.new(matricula_params)

    respond_to do |format|
      if @matricula.save
        format.html { redirect_to matriculas_path, notice: I18n.t('messages.created') }
        format.json { render :show, status: :created, location: @matricula }
      else
        format.html { render :new }
        format.json { render json: @matricula.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matriculas/1
  # PATCH/PUT /matriculas/1.json
  def update
    respond_to do |format|
      if @matricula.update(matricula_params)
        format.html { redirect_to matriculas_path, notice: I18n.t('messages.updated') }
        format.json { render :show, status: :ok, location: @matricula }
      else
        format.html { render :edit }
        format.json { render json: @matricula.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matriculas/1
  # DELETE /matriculas/1.json
  def destroy
    @matricula.destroy
    respond_to do |format|
      format.html { redirect_to matriculas_path, notice: I18n.t('messages.destroyed') }
      format.json { head :no_content }
    end
  end

  def cancellation
    @matricula.update(ativo: 0)

    respond_to do |format|
      format.html { redirect_to matriculas_path, notice: I18n.t('messages.canceled') }
      format.json { head :no_content }
    end
  end

  private
    def set_alunos_options_for_select
      @alunos_options_for_select = Aluno.all
    end

    def set_cursos_options_for_select
      @cursos_options_for_select = Curso.all
    end

    def set_sim_nao_options_for_select
      @sim_nao_options_for_select = [[I18n.t('options.no'), 0], [I18n.t('options.yes'), 1]]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_matricula
      @matricula = Matricula.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matricula_params
      params.require(:matricula).permit(:aluno_id, :curso_id, :data_matricula, :ano, :ativo, :pago)
    end
end
