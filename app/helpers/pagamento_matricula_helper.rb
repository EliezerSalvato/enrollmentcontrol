module PagamentoMatriculaHelper
  def busca_descricao_periodo(periodo)
    case periodo
      when 1 then I18n.t('options.morning')
      when 2 then I18n.t('options.afternoon')
      when 3 then I18n.t('options.integral')
    end
  end
end
