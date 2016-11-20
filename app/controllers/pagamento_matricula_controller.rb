class PagamentoMatriculaController < ApplicationController
  before_action :set_matricula, only: [:edit]

  def edit
    if params[:pay].present? || params[:better_change].present?
      if params[:valor_pago].present?
        if params[:valor_pago].to_f >= params[:valor_inscricao].to_f
          if params[:pay]
            pay
          elsif params[:better_change]
            better_change
          end
        else
          @matricula.errors.add(:base, I18n.t('messages.value_paid_less_than'))
        end
      else
        @matricula.errors.add(:valor_pago, " " << I18n.t('messages.must_be_informed'))
      end
    end
  end

  def pay
    troco = format("%.2f", params[:valor_pago].to_f - params[:valor_inscricao].to_f)
    troco = (troco.to_f > 0.00) ? " #{I18n.t('messages.change_of')} " << troco.to_s : ""

    @matricula.update(pago: 1)
    redirect_to matriculas_path, notice: I18n.t('messages.paid') << troco
  end

  def better_change
    flash[:notice] = get_melhor_troco(params[:valor_inscricao].to_f, params[:valor_pago].to_f)
  end

  def get_melhor_troco(valor_total, valor_pago, dinheiro_disponivel = [100, 50, 10, 5, 1, 0.50, 0.10, 0.05, 0.01])
    dinheiro_troco = ""
    troco = (valor_pago - valor_total).round(2)

    dinheiro_disponivel.each do |dinheiro|
      if troco.round(2) >= dinheiro
        qtd = (troco.round(2) / dinheiro).to_i
        troco -= (qtd * dinheiro).round(2)
        dinheiro_troco << "<li>" << qtd.to_s << get_tipo_troco(dinheiro) << format("%.2f", dinheiro) << "</li>"
      end
    end

    dinheiro_troco
  end

  def get_tipo_troco(dinheiro)
    if dinheiro >= 1
      " #{I18n.t('options.banknotes_of')} "
    else
      " #{I18n.t('options.coins_of')} "
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matricula
      @matricula = Matricula.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matricula_params
      params.require(:matricula).permit(:aluno_id, :curso_id, :data_matricula, :ano, :ativo, :pago)
    end
end
