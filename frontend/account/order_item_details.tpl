{extends file="parent:frontend/account/order_item_details.tpl"}

{* Name *}
{block name="frontend_account_order_item_name"}
    <p class="order--name is--strong">
        {* Mode 10 = Bundle Product *}
        {if $article.modus == 10}
            {s name="OrderItemInfoBundle"}{/s}
        {else}
            {$article.article.articleName}
            {foreach $article.article.sConfigurator as $group}
                {if $group.groupname && $group.values[$group.selected_value].optionname}
                    <p class="content--configurator content">{$group.groupname}: {$group.values[$group.selected_value].optionname}</p>
                {/if}
            {/foreach}
        {/if}
    </p>
{/block}

{* Order item price *}
{block name='frontend_account_order_item_price'}
    <div class="panel--td order--price column--price">

        {block name='frontend_account_order_item_price_label'}
            <div class="column--label">{s name="OrderItemColumnPrice"}{/s}</div>
        {/block}

        {block name='frontend_account_order_item_price_value'}
            <div class="column--value">

                {* Discount price *}
                {block name='frontend_listing_box_article_price_discount'}
                    {if $article.article.pseudoprice && $article.article.pseudoprice > $article.price}
                        <span class="nxsprice--pseudo">
                            {$article.article.pseudoprice|currency|regex_replace:"/,\d+/":""}
                        </span>
                    {/if}
                {/block}

                {if $article.price}
                    {if $offerPosition.currency_position == "32"}
                        <span class="{if $article.article.pseudoprice && $article.article.pseudoprice > $article.price}nxsprice--pseudo--active{/if}">{$offerPosition.currency_html} {$article.price} *</span>
                    {else}
                        <span class="{if $article.article.pseudoprice && $article.article.pseudoprice > $article.price}nxsprice--pseudo--active{/if}">{$article.price} {$offerPosition.currency_html} *</span>
                    {/if}
                {else}
                    {s name="OrderItemInfoFree"}{/s}
                {/if}
            </div>
        {/block}
    </div>
{/block}