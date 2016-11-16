module MatriculasHelper
  def busca_sim_nao(valor)
    case valor
      when 0 then 'Não'
      when 1 then 'Sim'
    end
  end
end
