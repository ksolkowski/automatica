#= require jquery-1.11.0.min
#= require jquery-ujs
#= require bootstrap.min
#= require angular.min
#= require angular-resource.min
#= require angular-route.min
#= underscore
#= require_directory ./resources
#= require_directory ./controllers
#= require_self

Automatica = angular.module('Automatica', ['ngRoute', 'ngResource'])

Automatica.factory "Car", ($resource) ->
  $resource "/cars", { id: "@id" }
  , 'update':  { method: 'PUT' }
  , 'fetch': { method: 'GET', isArray: true, url: "/cars/fetch"}
Automatica.factory "Trip", ($resource) ->
  $resource "/trips", { id: "@id" }

Automatica.run ($rootScope) ->
  $rootScope.current_user = window.current_user if window.current_user?
  delete window.current_user
Automatica.controller 'BodyController',  ($scope, $route, Car, Trip) ->
  $scope.loadTrips = (car) ->
    Trip.query({car_id: car.automatic_id}).$promise.then (trips) ->
      car.trips = trips
    console.log car
  $scope.save = (car) ->
    car.$save()
  $scope.isSelected = (car) ->
    return false if !$scope.car
    $scope.car.automatic_id is car.id
  $scope.setCar = (selectedCar) ->
    $scope.car = new Car()
    $scope.car.display_name = selectedCar.display_name
    $scope.car.year = selectedCar.year
    $scope.car.automatic_id = selectedCar.id
    $scope.car.submodel = selectedCar.submodel
    $scope.car.display_model = selectedCar.model
    $scope.car.make = selectedCar.make
    $scope.car.color = selectedCar.color
    $scope.car.user_id = $scope.current_user.id
  $scope.fetch = () ->
    Car.fetch().$promise.then (cars) ->
      $scope.cars = cars.map((x) -> x.attributes)
  
$(document).on('ready page:load', ->
  angular.bootstrap("body", ['Automatica'])
)