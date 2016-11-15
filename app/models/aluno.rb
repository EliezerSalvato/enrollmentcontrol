class Aluno < ActiveRecord::Base
  validates :cpf, presence: true, length: { minimum: 11, message: "%{value} deve conter 11 caracteres" },
    numericality: { only_integer: true, message: "%{value} deve conter apenas números" }, uniqueness: true
end
