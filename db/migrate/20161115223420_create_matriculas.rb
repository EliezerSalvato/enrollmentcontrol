class CreateMatriculas < ActiveRecord::Migration
  def change
    create_table :matriculas do |t|
      t.references :aluno, index: true, foreign_key: true
      t.references :curso, index: true, foreign_key: true
      t.date :data_matricula
      t.integer :ano
      t.integer :ativo
      t.integer :pago

      t.timestamps null: false
    end
  end
end
