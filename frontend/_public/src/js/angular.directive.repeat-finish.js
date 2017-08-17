shopApp.directive('onNgRepeatFinished', ['$timeout', function ($timeout) {
    return function (scope) {
        if (scope.$last) {
            $timeout(function(){scope.$emit('NgRepeatFinished')});
        }
    };
}]);
