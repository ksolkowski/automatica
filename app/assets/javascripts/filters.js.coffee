Automatica = angular.module('Automatica')
Automatica.filter "humanize", ($filter) ->
  (key) ->
    key = key.replace("_", " ").replace(/\w\S*/g, (txt) -> 
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    )
