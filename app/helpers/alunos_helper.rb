module AlunosHelper
  def formata_telefone(fone)
    (fone != "") ? "(#{fone[0,2]}) #{fone[2,5]}-#{fone[7,4]}" : ""
  end
end
