class CreateAlunos < ActiveRecord::Migration
  def change
    create_table :alunos do |t|
      t.string :cpf, limit: 11
      t.string :rg, limit: 9
      t.date :data_nascimento
      t.string :nome, limit: 255
      t.string :telefone, limit: 11

      t.timestamps null: false
    end
  end
end
