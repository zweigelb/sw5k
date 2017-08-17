{namespace name="frontend/listing/box_article"}

<div class="product--price">

    {* Discount price *}
    {block name='frontend_listing_box_article_price_discount'}
        {if $sArticle.has_pseudoprice}
            <span class="price--pseudo">
                <span class="price--discount is--nowrap">
                    {$config=['precision'=>0]}
                    {$sArticle.pseudoprice|currency|regex_replace:"/[,.]\d+/":""}
                </span>
            </span>
        {/if}
    {/block}

    {* Default price *}
    {block name='frontend_listing_box_article_price_default'}
        <span class="price--default is--nowrap{if $sArticle.has_pseudoprice} is--discount{/if}">
            {$sArticle.price|currency|regex_replace:"/[,.]\d+/":""}
        </span>
    {/block}
</div>
