module MatriculasHelper
  def busca_sim_nao(valor)
    case valor
      when 0 then I18n.t('options.no')
      when 1 then I18n.t('options.yes')
    end
  end
end
