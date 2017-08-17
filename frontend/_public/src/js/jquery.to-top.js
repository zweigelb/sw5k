;(function ($, window) {
    'use strict';

    $.plugin('nxsTotop', {
        defaults: {
            'triggerSelector': '.to-top',
            'ShowDistance': '150'
        },

        init: function () {
            var me = this;

            me.applyDataAttributes();
            me._$trigger = $(me.opts.triggerSelector);
            me._$window = $(window);

            me.registerEvents();
        },

        registerEvents: function () {
            var me = this;

            me._on(me._$trigger, 'click', $.proxy(me.onClick, me));
            me._on(me._$window, 'scroll', $.proxy(me.onScroll, me));
        },

        onClick: function () {
            var me = this;

            $('body,html').stop(true, true)
                .animate({
                    scrollTop: '0'
                }, 800);
        },

        onScroll: function () {
            var me = this;

            if (me._$window.scrollTop() > me.opts.ShowDistance) {
                me._$trigger.fadeIn();
            } else {
                me._$trigger.fadeOut();
            }
        },

        /**
         * Remove all listeners, classes and values from this plugin.
         */
        destroy: function () {
            var me = this;

            me._$trigger.css('display', '');

            me._destroy();
        }
    });
})(jQuery, window);

/**
 * Call the plugin when the shop is ready
 */
$(function () {
    window.StateManager.addPlugin(
        '*[data-to-top="true"]',
        'nxsTotop',
        ['m', 'l', 'xl']
    );
});
