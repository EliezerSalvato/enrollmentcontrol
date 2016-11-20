class Aluno < ActiveRecord::Base
  before_destroy :aluno_matriculado?
  has_many :matriculas

  validates_associated :matriculas
  validates_uniqueness_of :cpf
  validates_presence_of :nome, :cpf, :rg
  validates_numericality_of :rg, :cpf, :telefone, { only_integer: true, message: I18n.t('messages.numbers_only'), allow_blank: true }
  validates :cpf, length: { minimum: 11, maximum: 11, message: I18n.t('messages.only_11') }, allow_blank: true
  validates :rg, length: { maximum: 9, message: I18n.t('messages.max_9') }, allow_blank: true
  validates :nome, length: { maximum: 255, message: I18n.t('messages.max_255') }, allow_blank: true
  validates :telefone, length: { minimum: 11, maximum: 11, message: I18n.t('messages.only_11') }, allow_blank: true

  validate do
    if cpf != ""
      errors.add(:cpf, :invalid) unless cpf.valid_cpf?
    end
  end

  private
  def aluno_matriculado?
    if Matricula.where("aluno_id = ?", id).count > 0
      return false
    end

    return true
  end
end
