;(function ($, window) {
    'use strict';

    $.plugin('nxsProductAccordion', {
        defaults: {
            'itemSelector': '.product--accordion-item',
            'triggerSelector': '.product--accordion-trigger',
            'contentSelector': '.product--accordion-content',
            'openClass': 'is--open'
        },

        init: function () {
            var me = this;

            me.applyDataAttributes();
            me._$wrap = $(me.$el[0]);
            me._$items = me._$wrap.find(me.opts.itemSelector);
            me._$trigger = me._$wrap.find(me.opts.triggerSelector);
            me._$contents = me._$wrap.find(me.opts.contentSelector);

            me.registerEvents();
            me.initItems();
        },

        registerEvents: function () {
            var me = this,
                $el;

            $.each(me._$trigger, function (i, el) {
                $el = $(el);
                me._on($el, 'click', $.proxy(me.onClick, me, i, $el));
            });
        },

        initItems: function() {
            var me = this;

            me._$contents.not(':first').hide();
            me._$items.first().addClass(me.opts.openClass);
        },

        onClick: function (index, $el, event) {
            var me = this,
                item = $el.parent(),
                content = item.find(me.opts.contentSelector);

            if (!item.hasClass(me.opts.openClass)) {
                me.closeAccordions();
                item.addClass(me.opts.openClass);
                content.slideDown();
            }

        },

        closeAccordions: function() {
            var me = this,
                content = me._$wrap.find(me.opts.contentSelector);

            me._$items.removeClass(me.opts.openClass);
            content.slideUp();
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
        '*[data-product-accordion="true"]',
        'nxsProductAccordion'
    );
});
