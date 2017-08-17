<div class="product--accordion" data-product-accordion="true">

    {* Description *}
    <div class="product--accordion-item">
        <div class="product--accordion-trigger">{s name="productAccordionDescription"}Details{/s}</div>
        <div class="product--accordion-content">
            {$sArticle.description_long}
        </div>
    </div>

    {* Product Description *}
    <div class="product--accordion-item">
        <div class="product--accordion-trigger">{s name="productAccordionDetailsLabel"}Size&fit{/s}</div>
        <div class="product--accordion-content">
            <div class="product--properties">
                {if $sArticle.nxs_real_order_number}
                    <div class="product--properties-item ">
                        {* Order Number label *}
                        {block name='frontend_detail_description_properties_label'}
                            <span class="product--properties-label is--strong">{s name='detail/accordion/article_number'}{/s}:</span>
                        {/block}
                        {* Order Numberr content *}
                        {block name='frontend_detail_description_properties_content'}
                            {$sArticle.nxs_real_order_number|escape}
                        {/block}
                    </div>
                {/if}
                {if $sArticle.sProperties}
                    {foreach $sArticle.sProperties as $sProperty}
                        <div class="product--properties-item nxs--product--details">
                            {* Property label *}
                            {block name='frontend_detail_description_properties_label'}
                                <span class="product--properties-label is--strong">{$sProperty.name|escape}: </span>
                            {/block}

                            {* Property content *}
                            {block name='frontend_detail_description_properties_content'}
                                {$sProperty.value|escape}
                            {/block}
                        </div>
                    {/foreach}

                {/if}
            </div>
        </div>
    </div>



</div>