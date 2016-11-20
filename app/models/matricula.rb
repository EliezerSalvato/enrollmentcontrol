class Matricula < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :curso

  validates_presence_of :ano, :aluno_id, :curso_id
  validates_numericality_of :ano, { only_integer: true, message: I18n.t('messages.numbers_only'), allow_blank: true }

  validate :periodo_ano_unico

  private
  def periodo_ano_unico
    periodo = Curso.find(curso_id).periodo
    matricula = Matricula.where("aluno_id = ? AND ano = ?", aluno_id, ano)

    if id != nil
      matricula = matricula.where("matriculas.id <> ?", id)
    end

    matricula = matricula.joins(:curso).where(cursos: { periodo: [periodo, 3] })

    if (matricula.count > 0) || (matricula.count == 0 && periodo == 3)
      errors.add(:aluno_id, " #{I18n.t('messages.enrolled')}")
    end
  end
end
