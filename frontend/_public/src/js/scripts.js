(function($, window) {

    window.StateManager
        .addPlugin('.product--image-zoom', 'swImageZoom', ['xl']);

    // Init select2 for all select fields except detail-page
    select2init();

    function select2init() {
        window.StateManager.removePlugin('select:not([data-no-fancy-select="true"])', 'swSelectboxReplacement');
        $('select:not([data-no-fancy-select="true"]):not(".is--detail-page")').select2({
            minimumResultsForSearch: Infinity
        });
    }

    function paymentchange() {
        window.StateManager.updatePlugin('*[data-modalbox="true"]', 'swModalbox');
    }

    $.subscribe('plugin/swShippingPayment/onInputChanged', paymentchange);
    $.subscribe('plugin/swAjaxVariant/onRequestData', select2init);
})(jQuery, window);

