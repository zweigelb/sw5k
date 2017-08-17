shopApp.factory('storeFinderMarker', function () {
    'use strict';

    var _markersInfo, _listenerHandle, _googleMarker;

    _listenerHandle = {};
    _markersInfo = [];
    _googleMarker = {};


    return {

        /**
         * Löscht alle GoogleMaps Marker
         */
        removeMarker: function () {
            for (var index in _googleMarker) {
                _googleMarker[index].setMap(null);
                delete _googleMarker[index];
                google.maps.event.removeListener(_listenerHandle[index]);
                delete _listenerHandle[index];
            }
            _markersInfo = [];
        },


        /**
         * Setzt die Marker Info.
         * Setzt nur die welche passen zum distance und Location
         * @param location Location von Form
         */
        setMarkerInfo: function (area, location) {
            var area = parseFloat(area);
            for (var index in nxs.ng.apiResult) {
                var lat = nxs.ng.apiResult[index].b_grad;
                var lng = nxs.ng.apiResult[index].l_grad;

                var distance = google.maps.geometry.spherical.computeDistanceBetween(
                    location,
                    new google.maps.LatLng(lat, lng)
                );
                var kmDistance = Math.ceil(distance / 1000);

                if (area >= kmDistance) {
                    _markersInfo.push({
                        distance: kmDistance,
                        latlng: [lat, lng],
                        info: nxs.ng.apiResult[index],
                        latlngObj: new google.maps.LatLng(
                            lat,
                            lng
                        )
                    });
                }

            }
        },

        sortAllMarkerByDistance: function () {
            _markersInfo.sort(function (a, b) {
                return -(b.distance - a.distance);
            });
        },

        /**
         * Setzt die Sortirung für Marker
         */
        changeSortMarkerInfo : function() {
            var conceptStore = [];
            var normalStore = [];
            _markersInfo.sort(function(a, b){
                var aDistance =  a.distance;
                var bDistance =  b.distance;
                return -(bDistance - aDistance);
            });
            for (var index in _markersInfo) {
                if(_markersInfo[index]['info']['name'].search(/KENNEL & SCHMENGER/i) >= 0)
                    conceptStore.push(_markersInfo[index]);
                else
                    normalStore.push(_markersInfo[index]);
            }
            _markersInfo = conceptStore.concat(normalStore);
        },

        /**
         * Add Info to Marker
         */
        addInfoToMarker: function () {
            for (var index in _markersInfo) {
                _markersInfo[index].nummer = parseInt(index) + 1;
                _markersInfo[index].icon = '/themes/Frontend/KennelSchmenger/frontend/_public/src/images/marker/marker.png';
            }
        },


        /**
         * Setzt die Marker in GoogleMaps
         */
        setGoogleMapsMarker: function (markersInfo, map) {

            for (var index in markersInfo) {

                var nummer = markersInfo[index].nummer;
                /* @toWeg wenn bilder da*/
                    _googleMarker[index] = new MarkerWithLabel({
                        map: map,
                        animation: google.maps.Animation.DROP,
                        position: markersInfo[index].latlngObj,
                        icon: markersInfo[index].icon,
                        labelContent: nummer.toString(),
                        labelClass: "storeFinderMapMarker"
                    });
                    var store = markersInfo[index];
                    var contentString =
                        '<div class="storefinder--marker-main"> \
                                <div class="storefinder--marker-info"> \
                                    <div class="storefinder--marker-location">'+store.info.name+'</div> \
                                    <div class="storefinder--marker-address">'+store.info.street+' <br>'+store.info.plz+ ' ' + store.info.ort+'</div>';

                                    if(store.info.phone_number) {
                                        contentString = contentString + '<div class="storefinder--marker-contact">'+store.info.phone_number+' <br>';
                                    }
                                    if(store.info.fax) {
                                        contentString = contentString + '<div class="storefinder--marker-fax">'+store.info.fax+' <br>';
                                    }

                                    if(store.info.email) {
                                        contentString = contentString + '<a href="mailto:'+store.info.email+'" title="Kontakt aufnehmen">'+store.info.email+'</a><br>';
                                    }

                                    if(store.info.url) {
                                        contentString = contentString + '<a href="'+store.info.url+'" title="Webseite besuchen">'+store.info.url+'</a><br>';
                                    }
                contentString = contentString + '</div> \
                                </div> \
                            </div> \
                        ';

                    var infowindow = new google.maps.InfoWindow(

                    );

                    _listenerHandle[index] = google.maps.event.addListener(_googleMarker[index], 'click', function (content) {
                        return function(){
                            infowindow.setContent(content);//set the content
                            infowindow.open(map,this);
                            //$(".gm-style-iw").next("div").addClass('nxs-close-marker');
                        }
                    }(contentString));
            }

        },




        /* -------------------------------------
         |       SIMPLE GETTER AND SETTER       |
         --------------------------------------*/
        getAllMarkerInfo: function () {
            return _markersInfo;
        },

        getConceptStores: function (country) {
            var conceptStore = [];
            var i = 1;

            for (var index in _markersInfo) {
                if(_markersInfo[index]['info']['name'].search(/KENNEL & SCHMENGER/i) >= 0
                    && _markersInfo[index]['info']['country'] == country
                ) {
                    _markersInfo[index].nummer = i++;
                    conceptStore.push(_markersInfo[index]);
                }
            }
            return conceptStore;
        },

        getStores: function (country) {
            var stores = [],
                i = 1
            ;

            for (var index in _markersInfo) {
                if (_markersInfo[index]['info']['country'] == country) {
                    _markersInfo[index].nummer = i++;
                    stores.push(_markersInfo[index]);
                }
            }
            return stores;
        }


    }
});
