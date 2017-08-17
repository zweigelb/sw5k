shopApp.controller('StoreFinderSearch', function ($scope, $filter, storeFinderMap) {

    /**
     * Area
     * @type {number}
     */
    $scope.area = 50;

    /**
     * PLZ oder Stadt
     * @type {string}
     */
    $scope.place = "";

    /**
     * land
     * @type {string}
     */
    $scope.country = nxs.ng.currentCountry;
    $scope.countryEN = nxs.ng.currentCountryEN;

    /**
     * Koordinaten des Zentrums der Karte
     */
    $scope.coords = nxs.ng.currentCoords;

    /**
     * Zoom
     * @type {number}
     */
    $scope.zoom = nxs.ng.currentZoom;

    /**
     * Wait Button
     * @type {boolean}
     */
    $scope.wait = false;

    $scope.userSearch = false;

    $scope.mobileDetailInfo = false;

    $scope.markersInfo = false;


    /**
     * Init Map bei Load die Seite
     * @private
     */
    var _initialize = function () {
        var _mapOptions;

        var styledMap = new google.maps.StyledMapType(nxs.ng.mapsstyle, {name: "Styled Map"});

        _mapOptions = {
            zoom: $scope.zoom,
            disableDefaultUI: true,
            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.SMALL,
                position: google.maps.ControlPosition.BOTTOM_RIGHT
            },
            mapTypeControlOptions: {
                mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
            },
            scrollwheel: false
        };
        _mapOptions['center'] = storeFinderMap
            .setLatLng($scope.coords)
            .getLatLng();

        var _map = new google.maps.Map(document.getElementById('map-canvas'), _mapOptions);
        _map.mapTypes.set('map_style', styledMap);
        _map.setMapTypeId('map_style');
        google.maps.event.addListenerOnce(_map, 'idle', function () {
            storeFinderMap
                .initMap(_map);
            if (typeof nxs.ng.city === "string" && nxs.ng.city.length > 2) {
                _setCity(nxs.ng.city);
            }
            _showStores();
        });

        google.maps.event.addDomListener(_map, 'tilesloaded', function () {
            $('div.gmnoprint')
                .last()
                .addClass('nxs-MapZoomControl')
                .parent()
                .addClass('nxs-MapZoomControl');
        })
    };

    var _setCity = function (city) {
        $scope.place = city;
        $scope.sendLocation();
    };

    var _showAll = function () {
        storeFinderMap.setGoogleMapsInfo(999999999999, 'sortAllMarkerByDistance');
        storeFinderMap.setGoogleMapsMarker(
            storeFinderMap.getAllMarkerInfo(),
            storeFinderMap.getMap()
        );

        $scope.$apply(function () {
            $scope.markersInfo = storeFinderMap.getAllMarkerInfo();
        });
    };

    var _showStores = function () {
        storeFinderMap.setGoogleMapsInfo(999999999999, 'sortAllMarkerByDistance');

        var stores = storeFinderMap.getConceptStores($scope.countryEN);

        if (stores.length == 0) {
            stores = storeFinderMap.getStores($scope.countryEN);
        }

        storeFinderMap.setGoogleMapsMarker(
            stores,
            storeFinderMap.getMap()
        );

        $scope.$apply(function () {
            $scope.markersInfo = storeFinderMap.getConceptStores($scope.countryEN);
        });
    };

    google.maps.event.addDomListener(window, 'load', _initialize);


    /**
     * Form Send
     */
    $scope.sendLocation = function () {
        if ($scope.place.length > 0) {
            $scope.setWait(true);
            _resetInfo();
            storeFinderMap.sendAddress($scope, $scope.place, $scope.area, $scope.country);
        }

    };

    var _resetInfo = function () {
        $scope.userSearch = true;
        $scope.markersInfo = false;
        $scope.geoActive = false;
        storeFinderMap.removeMarker();
    };

    /**
     * init geolocation
     */
    $scope.initGeolocation = function () {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError);
        } else {
            alert("Geolocation is not supported by this browser.");
        }
    };

    /**
     * Geolocation success
     */
    var geolocationSuccess = function (position) {
        _resetInfo();
        $scope.geoActive = true;
        $scope.setWait(true);
        storeFinderMap
            .setLatLng([position.coords.latitude, position.coords.longitude])
            .sendGeocode($scope, $scope.area);
    };


    /**
     * Geolocation error
     */
    var geolocationError = function () {
        $scope.placeError = true;
    };

    /* -------------------------------------
     |       SIMPLE GETTER AND SETTER       |
     --------------------------------------*/

    /**
     * Setter für Wait
     * @param value
     * @returns {$scope}
     */
    $scope.setWait = function (value) {
        $scope.wait = value;
        return this;
    };

    /**
     * Getter für Wait
     * @returns {boolean}
     */
    $scope.getWait = function () {
        return $scope.wait;
    };

    $scope.showMobileDetailInfo = function (nummer) {
        $scope.mobileDetailInfo = nummer;
    };

    $scope.isMobileDetailInfo = function (nummer) {
        return nummer === $scope.mobileDetailInfo;
    };

    $scope.hideMobileDetailInfo = function () {
        $scope.mobileDetailInfo = false;
    };

    $scope.toggleMobile = function (storeNumber) {
        if ($scope.isMobileDetailInfo(storeNumber)) {
            $scope.hideMobileDetailInfo();
        } else {
            $scope.showMobileDetailInfo(storeNumber);
        }
    };

    /**
     * Liefert Store
     *
     * @returns {*}
     */
    $scope.getStoreInfo = function () {
        return $scope.markersInfo;
    };

    /**
     * Has Store
     * @returns {boolean}
     */
    $scope.hasStoreInfo = function () {
        return $scope.markersInfo.length > 0;
    };

});
