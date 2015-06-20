Automatica = angular.module('Automatica')

Automatica.controller 'BodyController',  ($scope, $route, Car, Trip, $modal) ->
  $scope.mapTile = {
      styleId: $scope.maxBoxId,
      lineStyle: {
        color: '#08b1d5',
        opacity: 0.9
      }
    }

  $scope.distanceUnit = "m"

  $scope.tripLength = (length) ->
    if $scope.distanceUnit is "m"
      length
    else
      length * 0.000621371

  $scope.whatDistanceUnit = () ->
    if $scope.distanceUnit is "m"
      $scope.distanceUnit = "mi"
    else
      $scope.distanceUnit = "m"

  $scope.modal = (trip) ->
    modalInstance = $modal.open(
      templateUrl: "/views/trips/form.html"
      controller: "TripMapController"
    )
  $scope.setCars = (cars) ->
    $scope.cars = cars.map((x)-> new Car(x))
  $scope.loadTrips = (car) ->
    car.trips ||= []
    Trip.query(query: {car_id: car.id}).$promise.then (trips) ->
      angular.forEach trips, (trip) ->
        if trip.path
          line = L.polyline(polyline.decode(trip.path), $scope.mapTile.lineStyle)
          trip.geoLine = line.toGeoJSON()
        car.trips.push trip

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
      $scope.fetchedCars = cars.map((x) -> x.attributes)
Automatica.controller 'TripMapController',  ($scope) ->
