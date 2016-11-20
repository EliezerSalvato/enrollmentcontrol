class Curso < ActiveRecord::Base
  before_destroy :curso_matriculado?
  has_many :matriculas

  validates_associated :matriculas
  validates_uniqueness_of :nome
  validates_presence_of :nome, :valor_inscricao
  validates_numericality_of :valor_inscricao, { message: I18n.t('messages.numbers_only'), allow_blank: true }
  validates :nome, length: { maximum: 255, message: I18n.t('messages.max_255') }

  private
  def curso_matriculado?
    if Matricula.where("aluno_id = ?", id).count > 0
      return false
    end

    return true
  end
end
