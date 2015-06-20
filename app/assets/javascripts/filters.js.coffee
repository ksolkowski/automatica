Automatica = angular.module('Automatica')
Automatica.filter "humanize", ($filter) ->
  (key) ->
    key = key.replace("_", " ").replace(/\w\S*/g, (txt) -> 
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    )

Automatica.filter 'dynamicFilter', ($filter) ->
  (value, filterName, modifier) ->
    if filterName and filterName isnt ''
      $filter(filterName)(value, modifier)
    else
      value

Automatica.filter "metersToMiles", ($filter) ->
  (meters, round) ->
    m = parseFloat(meters) * 0.000621371
    console.log parseFloat(m, round)
    parseFloat(m, round)
