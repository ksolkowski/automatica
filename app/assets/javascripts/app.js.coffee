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

  this.whatLineColor(trip) ->
    
$(document).on('ready page:load', ->
  angular.bootstrap("body", ['Automatica'])
)