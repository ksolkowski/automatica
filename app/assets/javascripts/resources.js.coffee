Automatica = angular.module('Automatica')

Automatica.factory "Car", ($resource) ->
  $resource "/cars/:id", { id: "@id" }
  , 'update':  { method: 'PUT' }
  , 'fetch': { method: 'GET', isArray: true, url: "/cars/fetch"}
Automatica.factory "Trip", ($resource) ->
  $resource "/trips/:id", { id: "@id" }