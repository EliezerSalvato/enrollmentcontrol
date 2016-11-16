class Matricula < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :curso

  validates_presence_of :ano
  validates_numericality_of :ano, { only_integer: true, message: I18n.t('messages.numbers_only') }
end
