json.extract! matricula, :id, :aluno_id, :curso_id, :data_matricula, :ano, :ativo, :pago, :created_at, :updated_at
json.url matricula_url(matricula, format: :json)