angular.module('stream')
	.controller('StreamCtrl', [
	'$scope',
	function($scope) {
		$scope.test = "test";

		$scope.init = function() {
	    var source = new EventSource('/event_stream');
	    source.onmessage = function(event) {
	      $scope.$apply(function () {
	        $scope.entries = JSON.parse(event.data)
	      });
	    };
	  };
	}])