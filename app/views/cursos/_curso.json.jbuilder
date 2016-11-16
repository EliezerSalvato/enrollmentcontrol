json.extract! curso, :id, :nome, :valor_inscricao, :periodo, :created_at, :updated_at
json.url curso_url(curso, format: :json)