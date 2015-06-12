Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
  when :development then Sequel::Model.db = Sequel.sqlite 'db/development.sqlite3', loggers: [logger]
  when :production  then Sequel.connect("postgres://localhost/automatica_production",  loggers: [logger])
  when :test        then Sequel::Model.db = Sequel.sqlite 'db/test.sqlite3', loggers: [logger]
end
