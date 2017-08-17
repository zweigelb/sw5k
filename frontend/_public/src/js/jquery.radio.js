;(function ($, window) {
    'use strict';

    $.plugin('nxsRadio', {
        defaults: {
            'radioSelector': 'input.is--fakeRadio',
            'activeClass': 'is--active'
        },

        init: function () {
            var me = this;

            me.applyDataAttributes();

            me._$radioboxes = $(me.opts.radioSelector);

            me.registerEvents();
        },

        registerEvents: function () {
            var me = this,
                $el;

            $.each(me._$radioboxes, function (i, el) {
                $el = $(el);
                me._on($el, 'change', $.proxy(me.onChange, me, i, $el));
            });
        },

        onChange: function (index, $el, event) {
            var me = this,
                $parent = $el.parent(),
                _$radioboxes = $(me.opts.radioSelector + '[name="' + $el.attr('name') + '"]');

            if ($el.is(':checked')) {
                _$radioboxes.parent().removeClass(me.opts.activeClass);
                $parent.addClass(me.opts.activeClass);
            }
        },

        /**
         * Remove all listeners, classes and values from this plugin.
         */
        destroy: function () {
            var me = this;

            me._destroy();
        }
    });
})(jQuery, window);

/**
 * Call the plugin when the shop is ready
 */
$(function () {
    window.StateManager.addPlugin(
        '*[data-radio="true"]',
        'nxsRadio',
        ['xs', 's', 'm', 'l', 'xl']
    );
});
