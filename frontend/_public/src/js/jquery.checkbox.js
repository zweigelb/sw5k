;(function ($, window) {
    'use strict';

    $.plugin('nxsCheckbox', {
        defaults: {
            'checkboxSelector': 'input.is--fakeCheckbox',
            'activeClass': 'is--active'
        },

        init: function () {
            var me = this;

            me.applyDataAttributes();

            me._$checkboxes = $(me.opts.checkboxSelector);

            me.registerEvents();
        },

        registerEvents: function () {
            var me = this,
                $el;

            $.each(me._$checkboxes, function (i, el) {
                $el = $(el);
                me._on($el, 'change', $.proxy(me.onChange, me, i, $el));
            });
        },

        onChange: function (index, $el, event) {
            var me = this,
                $parent = $el.parent(),
                _$checkboxes = $(me.opts.checkboxSelector + '[name="' + $el.attr('name') + '"]');

            if ($el.is(':checked')) {
                _$checkboxes.parent().removeClass(me.opts.activeClass);
                $parent.addClass(me.opts.activeClass);
            } else {
                $parent.removeClass(me.opts.activeClass);
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
        '*[data-checkbox="true"]',
        'nxsCheckbox',
        ['xs', 's', 'm', 'l', 'xl']
    );
});
