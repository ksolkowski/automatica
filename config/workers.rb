require File.expand_path('../boot.rb', __FILE__)
Dir[File.expand_path('../../workers/*.rb', __FILE__)].each{|file|puts file.inspect;require file}