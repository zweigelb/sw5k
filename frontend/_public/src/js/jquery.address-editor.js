;(function ($, StateManager, window) {
    'use strict';

    $.overridePlugin('swAddressEditor', {
        /**
         * Re-register plugins to enable them in the modal
         * @private
         */
        _registerPlugins: function() {
            window.StateManager
                .addPlugin('div[data-register="true"]', 'swRegister')
                .addPlugin('*[data-preloader-button="true"]', 'swPreloaderButton');

            $('select:not([data-no-fancy-select="true"]):not(".is--detail-page")').select2({
                minimumResultsForSearch: Infinity
            });

            $.publish('plugin/swAddressEditor/onRegisterPlugins', [ this ]);
        },
    });
})(jQuery, StateManager, window);