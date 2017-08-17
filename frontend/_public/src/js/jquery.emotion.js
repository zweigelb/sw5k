;(function($, window) {
    'use strict';
    $.overridePlugin('swEmotion', {
        /**
         * Initializes special elements and their needed plugins.
         */
        initElements: function() {
            var me = this;

            if (me.opts.gridMode !== 'rows') {

                $.each(me.$bannerElements, function(index, item) {
                    $(item).swEmotionBanner();
                });
            }

            $.each(me.$videoElements, function(index, item) {
                $(item).swEmotionVideo();
            });

            StateManager.updatePlugin('*[data-product-slider="true"]', 'swProductSlider');
            StateManager.updatePlugin('*[data-image-slider="true"]', 'swImageSlider');
            StateManager.updatePlugin('*[data-radio="true"]', 'nxsRadio');
            StateManager.updatePlugin('*[data-checkbox="true"]', 'nxsCheckbox');

            $('select:not([data-no-fancy-select="true"]):not(".is--detail-page")').select2({
                minimumResultsForSearch: Infinity
            });

            $.subscribe('plugin/swProductSlider/onLoadItemsSuccess', function() {
                StateManager.updatePlugin('*[data-ajax-wishlist="true"]', 'swAjaxWishlist');
                window.picturefill();
            });

            window.picturefill();

            $.publish('plugin/swEmotion/onInitElements', [ me ]);
        },
    });
})(jQuery, window);