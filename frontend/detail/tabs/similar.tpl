{if $sArticle.sSimilarArticles}
    <h2 class="product--crossselling-title">{s name="productCrosssellingTitle" namespace="frontend/detail/index"}Category Styles{/s}</h2>

    {* Similar products - Content *}
    {block name="frontend_detail_index_similar_slider_content"}
        <div class="similar--content">
            {include file="frontend/_includes/product_slider.tpl" articles=$sArticle.sSimilarArticles sliderItemMinWidth="275"}
        </div>
    {/block}
{/if}