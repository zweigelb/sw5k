;(function ($, window) {
    'use strict';

    $.plugin('nxsFixedNav', {
        defaults: {
            'navigationSelector': '.navigation-main',
            'headerSelector': '.header-main',
            'fixedClass': 'is--fixed',
            'spacingClass': 'has--spacing',
            'offset': 60
        },

        init: function () {
            var me = this;

            me.applyDataAttributes();
            me._$header = $(me.opts.headerSelector);
            me._$navigation = $(me.opts.navigationSelector);
            me._$window = $(window);

            me.registerEvents();
        },

        registerEvents: function () {
            var me = this;

            me._on(me._$window, 'scroll', $.proxy(me.onScroll, me));
        },

        onScroll: function () {
            var me = this;

            if (me._$window.scrollTop() > me.opts.offset) {
                me._$header.addClass(me.opts.spacingClass);
                me._$navigation.addClass(me.opts.fixedClass);
            } else {
                me._$header.removeClass(me.opts.spacingClass);
                me._$navigation.removeClass(me.opts.fixedClass);
            }
        },

        /**
         * Remove all listeners, classes and values from this plugin.
         */
        destroy: function () {
            var me = this;

            me._$header.removeClass(me.opts.spacingClass);
            me._$navigation.removeClass(me.opts.fixedClass);

            me._destroy();
        }
    });
})(jQuery, window);

/**
 * Call the plugin when the shop is ready
 */
$(function () {
    window.StateManager.addPlugin(
        '*[data-fixed-nav="true"]',
        'nxsFixedNav',
        ['l', 'xl']
    );
});
