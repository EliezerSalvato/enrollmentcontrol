class Aluno < ActiveRecord::Base
  validates_uniqueness_of :cpf
  validates_presence_of :nome, :cpf, :rg
  validates_numericality_of :rg, :cpf, { only_integer: true, message: I18n.t('messages.numbers_only') }
  validates :cpf, :telefone, length: { minimum: 11, maximum: 11, message: I18n.t('messages.only_11') }
  validates :rg, length: { maximum: 9, message: I18n.t('messages.max_9') }
  validates :nome, length: { maximum: 255, message: I18n.t('messages.max_255') }

  validate do
    errors.add(:cpf, :invalid) unless cpf.valid_cpf?
  end
end
