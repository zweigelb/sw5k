<div class="logo-main block-group" role="banner">

    {* Main shop logo *}
    {block name='frontend_index_logo'}
        <div class="logo--shop block">
            <a class="logo--link" href="{url controller='index'}" title="{"{config name=shopName}"|escapeHtml} - {"{s name='IndexLinkDefault' namespace="frontend/index/index"}{/s}"|escape}">
                <picture>
                    <img srcset="{link file='frontend/_public/src/images/logo_ks.png'}" alt="{"{config name=shopName}"|escapeHtml} - {"{s name='IndexLinkDefault' namespace="frontend/index/index"}{/s}"|escape}" />
                </picture>
            </a>
        </div>
    {/block}

    {* Support Info *}
    {block name='frontend_index_logo_supportinfo'}
        {if $theme.checkoutHeader && {controllerName|lower} === 'checkout' && {controllerAction|lower} !== 'cart'}
            <div class="logo--supportinfo block">
                {s name='RegisterSupportInfo' namespace='frontend/register/index'}{/s}
            </div>
        {/if}
    {/block}

    {* Trusted Shops *}
    {block name='frontend_index_logo_trusted_shops'}{/block}
</div>
