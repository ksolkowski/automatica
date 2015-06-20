#= require jquery-1.11.0.min
#= require jquery-ujs
#= require bootstrap.min
#= require angular.min
#= require angular-resource.min
#= require angular-route.min
#= require ui-bootstrap-tpls-0.13.0.min
#= require underscore
#= require angular-mapbox
#= require polyline

#= require_self
#= require resources
#= require filters
#= require directives

#= require_tree .

Automatica = angular.module('Automatica', ['ngRoute', 'ngResource', 'ui.bootstrap', 'angular-mapbox'])

Automatica.run ($rootScope) ->
  $rootScope.current_user = window.current_user if window.current_user?
  $rootScope.mapBoxAccessToken = window.mapBoxAccessToken
  $rootScope.mapBoxApiKey = window.mapBoxApiKey

Automatica.service '$helpers', ($routeParams, $modal, $location, $interval, $sce, $redisPoll) ->

  # red == bad, green == good
  this.whatLineColor = (trip) ->
    return "#000000" if !trip.score_events
    score = parseFloat(trip.score_events)
    if score < 10
      return 
    else if score < 20
      return
    else if score < 30
      return 
    else if score < 40
      return 
    else if score < 50
      return 
    else if score < 60
      return 
    else if score < 70
      return 
    else if score < 80
      return 
    else if score < 90
      return 
    else
      return "#"

$(document).on('ready page:load', ->
  angular.bootstrap("body", ['Automatica'])
)