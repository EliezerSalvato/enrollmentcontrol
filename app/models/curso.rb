class Curso < ActiveRecord::Base
  validates_uniqueness_of :nome
  validates_presence_of :nome, :valor_inscricao
  validates_numericality_of :valor_inscricao, { message: I18n.t('messages.numbers_only') }
  validates :nome, length: { maximum: 255, message: I18n.t('messages.max_255') }
end
