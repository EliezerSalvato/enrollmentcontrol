# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161115223420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alunos", force: :cascade do |t|
    t.string   "cpf",             limit: 11
    t.string   "rg",              limit: 9
    t.date     "data_nascimento"
    t.string   "nome",            limit: 255
    t.string   "telefone",        limit: 11
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "cursos", force: :cascade do |t|
    t.string   "nome",            limit: 255
    t.decimal  "valor_inscricao",             precision: 11, scale: 2
    t.integer  "periodo"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "matriculas", force: :cascade do |t|
    t.integer  "aluno_id"
    t.integer  "curso_id"
    t.date     "data_matricula"
    t.integer  "ano"
    t.integer  "ativo"
    t.integer  "pago"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "matriculas", ["aluno_id"], name: "index_matriculas_on_aluno_id", using: :btree
  add_index "matriculas", ["curso_id"], name: "index_matriculas_on_curso_id", using: :btree

  add_foreign_key "matriculas", "alunos"
  add_foreign_key "matriculas", "cursos"
end
