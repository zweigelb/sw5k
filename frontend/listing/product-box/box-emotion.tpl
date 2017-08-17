{extends file="frontend/listing/product-box/box-basic.tpl"}

{namespace name="frontend/listing/box_article"}

{block name="frontend_listing_box_article"}
    <div class="product--box box--{$productBoxLayout}" data-ordernumber="{$sArticle.ordernumber}">

        {block name="frontend_listing_box_article_content"}
            <div class="box--content {action module=widgets controller=SoldOutInformation action=isSoldOut sArticleID=$sArticle['articleID']}">
                {block name='frontend_listing_box_article_info_container'}
                    <div class="product--info">

                        {* Product image *}
                        {block name='frontend_listing_box_article_picture'}
                            <a href="{$sArticle.linkDetails|rewrite:$sArticle.articleName}"
                               title="{$sArticle.articleName|escape}"
                               class="product--image{if $imageOnly} is--large{/if}">

                                {block name='frontend_listing_box_article_image_element'}
                                    <span class="image--element">

                                        {block name='frontend_listing_box_article_image_media'}
                                            <span class="image--media">

                                                {block name='frontend_listing_box_article_image_picture'}
                                                    {if $sArticle.image.thumbnails}

                                                        {$baseSource = $sArticle.image.thumbnails[0].source}

                                                        {* Fix Viewportberechnung für Artikel Boxen *}
                                                        {if $itemCols == 1}
                                                                {$itemCols = ($element.viewports[2].endCol - $element.viewports[4].startCol) + 1}
                                                        {/if}
                                                        {if $itemCols == 1}
                                                                {$itemCols = ($element.viewports[3].endCol - $element.viewports[4].startCol) + 1}
                                                        {/if}
                                                        {if $itemCols == 1}
                                                                {$itemCols = ($element.viewports[4].endCol - $element.viewports[4].startCol) + 1}
                                                        {/if}

                                                        {if $itemCols && $emotion.grid.cols && !$fixedImageSize}
                                                            {$colSize = 100 / $emotion.grid.cols}
                                                            {$itemSize = "{$itemCols * $colSize}vw"}
                                                        {else}
                                                            {$itemSize = "332px"}
                                                        {/if}

                                                        {foreach $sArticle.image.thumbnails as $image}
                                                            {$srcSet = "{if $image@index !== 0}{$srcSet}, {/if}{$image.source} {$image.maxWidth}w"}

                                                            {if $image.retinaSource}
                                                                {$srcSetRetina = "{if $image@index !== 0}{$srcSetRetina}, {/if}{$image.retinaSource} {$image.maxWidth}w"}
                                                            {/if}
                                                        {/foreach}
                                                    {elseif $sArticle.image.source}
                                                        {$baseSource = $sArticle.image.source}
                                                    {else}
                                                        {$baseSource = "{link file='frontend/_public/src/img/no-picture.jpg'}"}
                                                    {/if}

                                                    {$desc = $sArticle.articleName|escape}

                                                    {if $sArticle.image.description}
                                                        {$desc = $sArticle.image.description|escape}
                                                    {/if}

                                                    <picture>
                                                        {if $srcSetRetina}<source sizes="(min-width: 48em) {$itemSize}, 100vw" srcset="{$srcSetRetina}" media="(min-resolution: 192dpi)" />{/if}
                                                        {if $srcSet}<source sizes="(min-width: 48em) {$itemSize}, 100vw" srcset="{$srcSet}" />{/if}
                                                        <img src="{$baseSource}" alt="{$desc}" title="{$desc|truncate:160}" />
                                                    </picture>
                                                {/block}
                                            </span>
                                        {/block}
                                    </span>
                                {/block}
                            </a>
                        {/block}

                        {if !$imageOnly}
                            <div class="product--details">

                                {* Product name *}
                                {block name='frontend_listing_box_article_name'}
                                    <a href="{$sArticle.linkDetails|rewrite:$sArticle.articleName}"
                                       class="product--title"
                                       title="{$sArticle.articleName|escapeHtml}">
                                        {$sArticle.articleName|truncate:50|escapeHtml}
                                    </a>
                                {/block}

                                {block name='frontend_listing_box_article_price_info'}
                                    <div class="product--price-info">

                                        {* Product price - Unit price *}
                                        {block name='frontend_listing_box_article_unit'}
                                            {*include file="frontend/listing/product-box/product-price-unit.tpl"*}
                                        {/block}

                                        {* Product price - Default and discount price *}
                                        {block name='frontend_listing_box_article_price'}
                                            {include file="frontend/listing/product-box/product-price.tpl"}
                                        {/block}
                                    </div>
                                {/block}

                                {* Product badges *}
                                {block name='frontend_listing_box_article_badges'}
                                    {if !$imageOnly}
                                        {include file="frontend/listing/product-box/product-badges.tpl"}
                                    {/if}
                                {/block}
                            </div>
                        {/if}
                    </div>
                {/block}
            </div>
        {/block}
    </div>
{/block}
