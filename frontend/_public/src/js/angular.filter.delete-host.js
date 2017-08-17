shopApp.filter('deleteHost', function() {
    return function(url) {
        if(url){
            var search = url.indexOf('://');
            if (search === -1){ search = url.indexOf('//'); }
            if( search !== -1 ) {
                var cutUrl = url.substring(search+3);
                search = cutUrl.indexOf('/');
                if( search !== -1 ) {
                    cutUrl = cutUrl.substring(cutUrl.indexOf('/')+1)
                }
                url = cutUrl;
            }
            /* Hier werden mehrfach Bilder abgefragt auf der Detailseite, weil ein Query-Parameter angehangen wird */
            if( url.indexOf('?') === -1 && false) {
                url = url + '?';
            }
            if( url.indexOf('/') === 0 ){
                url = url.substring(1);
            }
        }
        return url;
    };
});