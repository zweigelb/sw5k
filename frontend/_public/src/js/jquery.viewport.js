;(function ($, window) {
    'use strict';

    $.plugin('viewport', {
        defaults: {},

        init: function () {
            var me = this;

            $('meta[name="viewport"]').attr('content', 'width=479, user-scalable=no');
        },

        /**
         * Remove all listeners, classes and values from this plugin.
         */
        destroy: function () {
            var me = this;

            $('meta[name="viewport"]').attr('content', 'width=device-width, initial-scale=1.0, user-scalable=no');
            me._destroy();
        }
    });
})(jQuery, window);

/**
 * Call the plugin when the shop is ready
 */
$(function () {
    window.StateManager.addPlugin(
        '*[data-viewport="true"]',
        'viewport',
        ['xs']
    );
});
