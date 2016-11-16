module CursosHelper
  def busca_descricao_periodo(periodo)
    case periodo
      when 1 then 'Matutino'
      when 2 then 'Vespertino'
      when 3 then 'Integral'
    end
  end
end
