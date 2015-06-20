Automatica = angular.module('Automatica')

Wantable.directive("validationErrors", ($constants, $log) ->
  return {
    restrict: "E",
    templateUrl: $constants.asset_path('modus/shared/validation_errors.html'),
    link: ($scope) ->