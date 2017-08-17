{namespace name="frontend/checkout/cart_item"}

<div class="table--tr block-group row--product{if $isLast} is--last-row{/if}">

    {if $sBasketItem.additional_details.sConfigurator}
        {$detailLink={url controller=detail sArticle=$sBasketItem.articleID number=$sBasketItem.additional_details.ordernumber forceSecure}}
    {else}
        {$detailLink=$sBasketItem.linkDetails}
    {/if}

    {* Product information column *}
    {block name='frontend_checkout_cart_item_name'}
        <div class="column--product">
            {* Product image *}
            {block name='frontend_checkout_cart_item_image'}
                <div class="panel--td column--image">
                    <div class="table--media">
                        {block name="frontend_checkout_cart_item_image_container"}
                            <div class="table--media-outer">
                                {block name="frontend_checkout_cart_item_image_container_outer"}
                                    <div class="table--media-inner">
                                        {block name="frontend_checkout_cart_item_image_container_inner"}

                                            {$image = $sBasketItem.additional_details.image}
                                            {$desc = $sBasketItem.additional_details.articleName|escape}

                                            {if $image.thumbnails[0]}
                                                <a href="{$detailLink}" title="{$sBasketItem.additional_details.articleName|strip_tags}"
                                                   class="table--media-link"
                                                        {if {config name=detailmodal} && {controllerAction|lower} === 'confirm'}
                                                    data-modalbox="true"
                                                    data-content="{url controller="detail" action="productQuickView" ordernumber="{$sBasketItem.ordernumber}" fullPath forceSecure}"
                                                    data-mode="ajax"
                                                    data-width="750"
                                                    data-sizing="content"
                                                    data-title="{$sBasketItem.additional_details.articleName|strip_tags|escape}"
                                                    data-updateImages="true"
                                                        {/if}>

                                                    {if $image.description}
                                                        {$desc = $image.description|escape}
                                                    {/if}

                                                    <img srcset="{$image.thumbnails[0].sourceSet}" alt="{$desc}"
                                                         title="{$desc|truncate:160}"/>
                                                </a>
                                            {else}
                                                <img src="{link file='frontend/_public/src/img/no-picture.jpg'}"
                                                     alt="{$desc}" title="{$desc|truncate:160}"/>
                                            {/if}
                                        {/block}
                                    </div>
                                {/block}
                            </div>
                        {/block}
                    </div>
                </div>
            {/block}

            {* Product information *}
            {block name='frontend_checkout_cart_item_details'}
                <div class="panel--td table--content">
                    {* Product name *}
                    {block name='frontend_checkout_cart_item_details_title'}
                        <a class="content--title" href="{$detailLink}"
                           title="{$sBasketItem.additional_details.articleName|strip_tags|escape}"
                                {if {config name=detailmodal} && {controllerAction|lower} === 'confirm'}
                            data-modalbox="true"
                            data-content="{url controller="detail" action="productQuickView" ordernumber="{$sBasketItem.additional_details.ordernumber}" fullPath forceSecure}"
                            data-mode="ajax"
                            data-width="750"
                            data-sizing="content"
                            data-title="{$sBasketItem.additional_details.articleName|strip_tags|escape}"
                            data-updateImages="true"
                                {/if}>
                            {$sBasketItem.additional_details.articleName|strip_tags|truncate:60}
                        </a>
                    {/block}

                    {* Product SKU number *}
                    {block name='frontend_checkout_cart_item_details_sku'}
                        <p class="content--sku content">
                            {s name="CartItemInfoId"}{/s} {$sBasketItem.ordernumber}
                        </p>
                        {foreach $sBasketItem.article.sConfigurator as $group}
                            {if $group.groupname && $group.values[$group.selected_value].optionname}
                                <p class="content--configurator content">
                                {$group.groupname}:
                                {if ($group.groupname == 'Größe' || $group.groupname == 'Size')
                                && (strpos($sBasketItem.article.articleName, 'Tasche') !== false
                                || strpos($sBasketItem.article.articleName, 'Bag') !== false)
                                }
                                    One Size
                                {else}
                                    {$group.values[$group.selected_value].optionname}</p>
                                {/if}
                            {/if}
                        {/foreach}
                    {/block}

                    {* Product delivery information *}
                    {block name='frontend_checkout_cart_item_delivery_informations'}
                        {if {config name=BasketShippingInfo} && $sBasketItem.shippinginfo}
                            {include file="frontend/plugins/index/delivery_informations.tpl" sArticle=$sBasketItem}
                        {/if}
                    {/block}
                </div>
            {/block}
        </div>
    {/block}

    {* Product quantity *}
    {block name='frontend_checkout_cart_item_quantity'}
        <div class="panel--td column--quantity">

            {* Label *}
            {block name='frontend_checkout_cart_item_quantity_label'}
                <div class="column--label quantity--label">
                    {s name="CartColumnQuantity" namespace="frontend/checkout/cart_header"}{/s}
                </div>
            {/block}

            {block name='frontend_checkout_cart_item_quantity_selection'}
                {$sBasketItem.quantity}
            {/block}
        </div>
    {/block}

    {* Product unit price *}
    {block name='frontend_checkout_cart_item_price'}
        <div class="panel--td column--unit-price is--align-right">

            {if !$sBasketItem.modus}
                {block name='frontend_checkout_cart_item_unit_price_label'}
                    <div class="column--label unit-price--label">
                        {s name="CartColumnPrice" namespace="frontend/checkout/cart_header"}{/s}
                    </div>
                {/block}

                {* Discount price *}
                {block name='frontend_listing_box_article_price_discount'}
                    {if $sBasketItem.article.pseudoprice && $sBasketItem.article.pseudoprice > $sBasketItem.price}
                        <span class="nxsprice--pseudo">
                    {$sBasketItem.article.pseudoprice|currency}
                    </span>
                    {/if}
                {/block}

                <span class="{if $sBasketItem.article.pseudoprice && $sBasketItem.article.pseudoprice > $sBasketItem.price}nxsprice--pseudo--active{/if}">{$sBasketItem.price|currency}{block name='frontend_checkout_cart_tax_symbol'}{s name="Star" namespace="frontend/listing/box_article"}{/s}{/block}</span>
            {/if}
        </div>
    {/block}

    {* Product tax rate *}
    {block name='frontend_checkout_cart_item_tax_price'}{/block}

    {* Accumulated product price *}
    {block name='frontend_checkout_cart_item_total_sum'}
        <div class="panel--td column--total-price is--align-right">
            {block name='frontend_checkout_cart_item_total_price_label'}
                <div class="column--label total-price--label">
                    {s name="CartColumnTotal" namespace="frontend/checkout/cart_header"}{/s}
                </div>
            {/block}

            {* Discount price *}
            {block name='frontend_listing_box_article_price_discount'}
                {if $sBasketItem.article.pseudoprice && $sBasketItem.article.pseudoprice > $sBasketItem.price}
                    <span class="nxsprice--pseudo">
                    {$sBasketItem.article.pseudoprice|currency}
                    </span>
                {/if}
            {/block}

            <span class="{if $sBasketItem.article.pseudoprice && $sBasketItem.article.pseudoprice > $sBasketItem.price}nxsprice--pseudo--active{/if}">{$sBasketItem.amount|currency}{block name='frontend_checkout_cart_tax_symbol'}{s name="Star" namespace="frontend/listing/box_article"}{/s}{/block}</span>
        </div>
    {/block}

    {* Remove product from basket *}
    {block name='frontend_checkout_cart_item_delete_article'}
        <div class="panel--td column--actions">
            <form action="{url action='deleteArticle' sDelete=$sBasketItem.id sTargetAction=$sTargetAction}"
                  method="post">
                <button type="submit" class="btn is--small column--actions-link"
                        title="{"{s name='CartItemLinkDelete'}{/s}"|escape}">
                    <i class="icon--cross"></i>
                </button>
            </form>
        </div>
    {/block}
</div>
