class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :nome, limit: 255
      t.decimal :valor_inscricao, precision: 11, scale: 2
      t.integer :periodo

      t.timestamps null: false
    end
  end
end
