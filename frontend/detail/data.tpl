{block name="frontend_detail_data"}

    {if !$sArticle.liveshoppingData.valid_to_ts}
        <div class="product--price price--default{if $sArticle.has_pseudoprice} price--discount{/if}">

            {* Discount price *}
            {block name='frontend_detail_data_pseudo_price'}
                {if $sArticle.has_pseudoprice}
                    {* Discount price content *}
                    {block name='frontend_detail_data_pseudo_price_discount_content'}
                        <span class="content--discount">
                            <span class="price--line-through">{$sArticle.pseudoprice|currency|regex_replace:"/[,.]\d+/":""}</span>
                        </span>
                    {/block}
                {/if}
            {/block}

            {* Default price *}
            {block name='frontend_detail_data_price_configurator'}
                {* Regular price *}
                    {block name='frontend_detail_data_price_default'}
                        <span class="price--content content--default">
                            <meta itemprop="price" content="{$sArticle.price|replace:',':'.'}">
                            {if $sArticle.priceStartingFrom && !$sArticle.liveshoppingData}{s name='ListingBoxArticleStartsAt' namespace="frontend/listing/box_article"}{/s} {/if}{$sArticle.price|currency|regex_replace:"/[,.]\d+/":""}
                        </span>
                    {/block}
            {/block}
        </div>

        {* Tax information *}
        {block name='frontend_detail_data_tax'}
            {if $shopId == 1}
                <p class="product--tax">
                    {s name="DetailDataPriceInfo"}{/s}
                </p>
            {else}
                <p class="product--tax" data-content="" data-modalbox="true" data-targetSelector="a" data-mode="ajax">
                    {s name="DetailDataPriceInfo"}{/s}
                </p>
            {/if}
        {/block}
    {/if}

    {if $sArticle.sBlockPrices && (!$sArticle.sConfigurator || $sArticle.pricegroupActive)}
        {foreach $sArticle.sBlockPrices as $blockPrice}
            {if $blockPrice.from == 1}
                <input id="price_{$sArticle.ordernumber}" type="hidden" value="{$blockPrice.price|replace:",":"."}">
            {/if}
        {/foreach}
    {/if}

{/block}
