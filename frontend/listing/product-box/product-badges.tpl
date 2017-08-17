{namespace name="frontend/listing/box_article"}

{* Small product labels on the left *}
{block name="frontend_listing_box_article_labels"}
    <div class="product--labels">

        {* Highlight label *}
        {block name='frontend_listing_box_article_hint'}
            {if $sArticle.highlight}
                <div class="product--label label--recommend">
                    {s name="ListingBoxTip"}{/s}
                </div>
            {/if}
        {/block}

        {* Newcomer label *}
        {block name='frontend_listing_box_article_new'}
            {if $sArticle.newArticle}
                <div class="product--label label--newcomer">
                    {s name="ListingBoxNew"}{/s}
                </div>
            {/if}
        {/block}

        {* Sold out label *}
        {block name='frontend_listing_box_article_new'}
            <div class="product--label label--soldout">
                {s name="ListingBoxSoldOut"}Sold out{/s}
            </div>
        {/block}
    </div>
{/block}






