{extends file='frontend/index/index.tpl'}

{* Custom header *}
{block name='frontend_index_header'}
    {include file="frontend/detail/header.tpl"}
{/block}

{* Main content *}
{block name='frontend_index_content'}
    <div class="content product--details{if $sArticle.instock < $sArticle.minpurchase && $sArticle.laststock > 0} is--soldout{/if}" itemscope itemtype="http://schema.org/Product" data-ajax-wishlist="true"{if $theme.ajaxVariantSwitch} data-ajax-variants-container="true"{/if}>
        {* The configurator selection is checked at this early point
           to use it in different included files in the detail template. *}
        {block name='frontend_detail_index_configurator_settings'}

            {* Variable for tracking active user variant selection *}
            {$activeConfiguratorSelection = true}

            {if $sArticle.sConfigurator && ($sArticle.sConfiguratorSettings.type == 1 || $sArticle.sConfiguratorSettings.type == 2)}
                {* If user has no selection in this group set it to false *}
                {foreach $sArticle.sConfigurator as $configuratorGroup}
                    {if !$configuratorGroup.selected_value}
                        {$activeConfiguratorSelection = false}
                    {/if}
                {/foreach}
            {/if}

            {*Konfigurator für Taschen deaktivieren, dabei dafür sorgen dass der warenkorb-button erscheint*}
            {if $sArticle.articleName == 'Taschen'|| $sArticle.articleName == 'Bags'}
                {$sArticle.sConfigurator=false}
                {$activeConfiguratorSelection = true}
                {$disableChoose = true}
            {/if}
        {/block}

        <div class="product--detail-upper block-group">
            {* Product image *}
            {block name='frontend_detail_index_image_container'}
                <div class="product--image-container image-slider{if $sArticle.image && {config name=sUSEZOOMPLUS}} product--image-zoom{/if}"
                    {if $sArticle.image}
                     data-image-slider="true"
                     data-image-gallery="true"
                     data-maxZoom="{$theme.lightboxZoomFactor}"
                     data-thumbnails=".image--thumbnails"
                    {/if}>
                    {include file="frontend/detail/image.tpl"}
                </div>
            {/block}

            {* "Buy now" box container *}
            {block name='frontend_detail_index_buy_container'}
                <div class="product--buybox block{if $sArticle.sConfigurator && $sArticle.sConfiguratorSettings.type==2} is--wide{/if}">

                    {block name="frontend_detail_rich_snippets_brand"}
                        <meta itemprop="brand" content="{$sArticle.supplierName|escape}"/>
                    {/block}

                    {block name="frontend_detail_rich_snippets_weight"}
                        {if $sArticle.weight}
                            <meta itemprop="weight" content="{$sArticle.weight} kg"/>
                        {/if}
                    {/block}

                    {block name="frontend_detail_rich_snippets_height"}
                        {if $sArticle.height}
                            <meta itemprop="height" content="{$sArticle.height} cm"/>
                        {/if}
                    {/block}

                    {block name="frontend_detail_rich_snippets_width"}
                        {if $sArticle.width}
                            <meta itemprop="width" content="{$sArticle.width} cm"/>
                        {/if}
                    {/block}

                    {block name="frontend_detail_rich_snippets_depth"}
                        {if $sArticle.length}
                            <meta itemprop="depth" content="{$sArticle.length} cm"/>
                        {/if}
                    {/block}

                    {block name="frontend_detail_rich_snippets_release_date"}
                        {if $sArticle.sReleasedate}
                            <meta itemprop="releaseDate" content="{$sArticle.sReleasedate}"/>
                        {/if}
                    {/block}

                    {block name='frontend_detail_buy_laststock'}
                        {if !$sArticle.isAvailable && ($sArticle.isSelectionSpecified || !$sArticle.sConfigurator)}
                            {include file="frontend/_includes/messages.tpl" type="error" content="{s name='DetailBuyInfoNotAvailable' namespace='frontend/detail/buy'}{/s}"}
                        {/if}
                    {/block}

                    {* Product name *}
                    {block name='frontend_detail_index_name'}
                        <h1 class="product--title" itemprop="name">
                            {$sArticle.articleName}
                        </h1>
                    {/block}


                    {if $sArticle.attr1}
                        <h2>{$sArticle.attr1|escape}</h2>
                    {/if}

                    {* Product email notification *}
                    {block name="frontend_detail_index_notification"}
                        {if $sArticle.notification && $sArticle.instock <= 0 && $ShowNotification}
                            {include file="frontend/plugins/notification/index.tpl"}
                        {/if}
                    {/block}

                    {* Product data *}
                    {block name='frontend_detail_index_buy_container_inner'}
                        <div itemprop="offers" itemscope itemtype="{if $sArticle.sBlockPrices}http://schema.org/AggregateOffer{else}http://schema.org/Offer{/if}" class="buybox--inner">

                            {block name='frontend_detail_index_data'}
                                {if $sArticle.sBlockPrices}
                                    {$lowestPrice=false}
                                    {$highestPrice=false}
                                    {foreach $sArticle.sBlockPrices as $blockPrice}
                                        {if $lowestPrice === false || $blockPrice.price < $lowestPrice}
                                            {$lowestPrice=$blockPrice.price}
                                        {/if}
                                        {if $highestPrice === false || $blockPrice.price > $highestPrice}
                                            {$highestPrice=$blockPrice.price}
                                        {/if}
                                    {/foreach}

                                    <meta itemprop="lowPrice" content="{$lowestPrice}" />
                                    <meta itemprop="highPrice" content="{$highestPrice}" />
                                    <meta itemprop="offerCount" content="{$sArticle.sBlockPrices|count}" />
                                {else}
                                    <meta itemprop="priceCurrency" content="{$Shop->getCurrency()->getCurrency()}"/>
                                {/if}
                                {include file="frontend/detail/data.tpl" sArticle=$sArticle sView=1}
                            {/block}

                            {block name='frontend_detail_index_after_data'}{/block}

                            {* Configurator drop down menu's *}
                            {block name="frontend_detail_index_configurator"}
                                <div class="product--configurator">
                                    {if $sArticle.sConfigurator}
                                        {if $sArticle.sConfiguratorSettings.type == 1}
                                            {include file="frontend/detail/config_step.tpl"}
                                        {elseif $sArticle.sConfiguratorSettings.type == 2}
                                            {include file="frontend/detail/config_variant.tpl"}
                                        {else}
                                            {include file="frontend/detail/config_upprice.tpl"}
                                        {/if}
                                    {/if}
                                </div>
                            {/block}

                            {* Include buy button and quantity box *}
                            {block name="frontend_detail_index_buybox"}
                                {include file="frontend/detail/buy.tpl"}
                            {/block}

                            {* Product actions *}
                            {block name="frontend_detail_index_actions"}
                                <nav class="product--actions">
                                    {include file="frontend/detail/actions.tpl"}
                                </nav>
                            {/block}
                        </div>
                    {/block}

                    {include file="frontend/detail/accordion.tpl"}

                    {block name="frontend_detail_index_share"}
                        {*<div class="product--share">
                            <a href="#" class="product--share-item" title="Facebook"><i class="fa fa-facebook fa-lg" aria-hidden="true"></i></a>
                        </div>*}
                    {/block}
                </div>
            {/block}
        </div>

        {* Crossselling tab panel *}
        {include file='frontend/detail/tabs/similar.tpl'}

    </div>
{/block}
