shopApp.filter('StoreFilter', function () {
    return function (items, store) {

        var storeInfo = [1,2];
        var filtered = [];

        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            if( (storeInfo.indexOf(item.info.category.id) !== -1) === store) {
                filtered.push(item);
            }
        }
        return filtered;
    };
});