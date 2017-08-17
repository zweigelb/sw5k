;(function ($, StateManager, window) {
    'use strict';

    $.overridePlugin('swImageSlider', {
        getThumbnailOrientation: function () {
            var $container = this._$thumbnailContainer;

            return 'horizontal';
        },

        trackThumbnailControls: function () {
            var me = this,
                opts = me.opts,
                isHorizontal = me._thumbnailOrientation === 'horizontal',
                $container = me._$thumbnailContainer,
                $slide = me._$thumbnailSlide,
                $prevArr = me._$thumbnailArrowPrev,
                $nextArr = me._$thumbnailArrowNext,
                activeCls = me.opts.activeStateClass,
                centerCls = 'is--center',
                pos = $slide.position(),
                orientation = me.getThumbnailOrientation();

            if (me._thumbnailOrientation !== orientation) {

                $prevArr
                    .toggleClass(opts.thumbnailArrowLeftCls, !isHorizontal)
                    .toggleClass(opts.thumbnailArrowTopCls, isHorizontal);

                $nextArr
                    .toggleClass(opts.thumbnailArrowRightCls, !isHorizontal)
                    .toggleClass(opts.thumbnailArrowBottomCls, isHorizontal);

                me._thumbnailOrientation = orientation;

                me.setActiveThumbnail(me._slideIndex);
            }

            $prevArr.toggleClass(activeCls, pos.left < 0);
            $nextArr.toggleClass(activeCls, ($slide.innerWidth() + pos.left) > $container.innerWidth());
            $slide.toggleClass(centerCls, ($slide.innerWidth() + pos.left) < $container.innerWidth());

            $.publish('plugin/swImageSlider/onTrackThumbnailControls', [ me ]);
        },
    });
})(jQuery, StateManager, window);