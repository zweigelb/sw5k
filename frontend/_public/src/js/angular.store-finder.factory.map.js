shopApp.factory('storeFinderMap', function (storeFinderMarker) {
    'use strict';

    var _geocoder, _map, _latlng;

    _geocoder = new google.maps.Geocoder();

    /**
     * Setzt das Zoom
     */
    var _setZoom = function (area) {
        var zoom = 11;
        if (area == 100) {
            zoom = 7;
        } else if (area == 75) {
            zoom = 8;
        } else if (area == 50) {
            zoom = 9;
        }
        _map.setZoom(zoom);
    };

    var _setCenter = function() {
        _map.setCenter(_latlng);
    };

    var _setInfoToController = function(controllerScope) {
        controllerScope.$apply(function () {
            controllerScope.setWait(false);
            controllerScope.markersInfo = getAllMarkerInfo();
            setGoogleMapsMarker(
                controllerScope.getStoreInfo()
            );
        });
    };

    var _pushHtmlUrl = function( city ) {
        if (typeof history.pushState !== 'undefined') {
            history.pushState('Kennel & Schmenger - Store Finder', 'Store Finder - ' + city, '/storefinder/?city=' + city.split(" ")[0]);
        }
    };

    var getAllMarkerInfo = function() {
        return storeFinderMarker.getAllMarkerInfo();
    };

    var getConceptStores = function(country) {
        return storeFinderMarker.getConceptStores(country);
    };

    var getStores = function (country) {
        return storeFinderMarker.getStores(country);
    };

    var setGoogleMapsMarker = function(markersInfo) {
        storeFinderMarker.setGoogleMapsMarker(markersInfo, getMap());
    };

    var getMap = function () {
        return _map;
    };


    return {

        setGoogleMapsInfo: function (area, sortFunction) {
            storeFinderMarker.removeMarker();
            storeFinderMarker.setMarkerInfo(area, this.getLatLng());

            storeFinderMarker[sortFunction]();
            storeFinderMarker.addInfoToMarker();
            return this;
        },

        sendAddress: function (controllerScope, place, area, country) {
            var self = this,
                found_result = null,
                apiResult = nxs.ng.apiResult || window.nxs.ng.apiResult;

            _geocoder.geocode({'address': place, componentRestrictions: {country: country}}, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    results.forEach(function(result){
                        apiResult.forEach(function(store){
                            if(result.formatted_address.indexOf(store.ort) != -1){
                                found_result = result;
                            }
                        });
                    });
                    found_result = (found_result)? found_result : results[0];
                    controllerScope.place = found_result.formatted_address;
                    _pushHtmlUrl(found_result.address_components[0].short_name);
                    self
                        .setLatLng(found_result.geometry.location)
                        .setNewGoogleMapLocation( controllerScope,  area );
                } else {
                    //console.log("Geocode was not successful for the following reason: " + status);
                }
            });
        },

        sendGeocode: function (controllerScope, area) {
            _geocoder.geocode( { 'latLng': this.getLatLng()}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    var city = results[1].address_components[0].short_name;
                    controllerScope.$apply(function () {
                        controllerScope.place = city;
                    });
                    _pushHtmlUrl(city);

                }
            });
            this.setNewGoogleMapLocation(controllerScope, area);

        },

        setNewGoogleMapLocation : function(controllerScope, area ) {
            this.setGoogleMapsInfo(area, 'changeSortMarkerInfo');
            _setZoom(area);
            _setCenter();
            _setInfoToController(controllerScope);
        },


        /* -------------------------------------
         |       SIMPLE GETTER AND SETTER       |
         --------------------------------------*/
        initMap: function (map) {
            _map = map;
            return this;
        },

        getMap: getMap,

        setLatLng: function (latlng) {
            _latlng = ( latlng instanceof google.maps.LatLng ) ? latlng : new google.maps.LatLng(parseFloat(latlng[0]), parseFloat(latlng[1]));
            return this;
        },

        getLatLng: function () {
            return _latlng;
        },

        removeMarker: function () {
            storeFinderMarker.removeMarker();
            return this;
        },

        getAllMarkerInfo : getAllMarkerInfo,

        getConceptStores : getConceptStores,

        setGoogleMapsMarker : setGoogleMapsMarker,

        getStores : getStores

    };
});