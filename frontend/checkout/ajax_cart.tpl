{extends file="parent:frontend/checkout/ajax_cart.tpl"}

{* Basket link *}
{block name='frontend_checkout_ajax_cart_button_container'}
    <div class="button--container">
        {block name='frontend_checkout_ajax_cart_button_container_inner'}
            {if !$nxsMaximumOrderQuantityExceeded}
                {if !($sDispatchNoOrder && !$sDispatches)}
                    {block name='frontend_checkout_ajax_cart_open_checkout'}
                        <a href="{if {config name=always_select_payment}}{url controller='checkout' action='shippingPayment'}{else}{url controller='checkout' action='confirm'}{/if}"
                           class="btn is--primary button--checkout is--icon-right"
                           title="{"{s name='AjaxCartLinkConfirm'}{/s}"|escape}">
                            <i class="icon--arrow-right"></i>
                            {s name='AjaxCartLinkConfirm'}{/s}
                        </a>
                    {/block}
                {else}
                    {block name='frontend_checkout_ajax_cart_open_checkout'}
                        <span class="btn is--disabled is--primary button--checkout is--icon-right"
                              title="{"{s name='AjaxCartLinkConfirm'}{/s}"|escape}">
                                <i class="icon--arrow-right"></i>
                            {s name='AjaxCartLinkConfirm'}{/s}
                            </span>
                    {/block}
                {/if}
            {/if}
            {block name='frontend_checkout_ajax_cart_open_basket'}
                <a href="{url controller='checkout' action='cart'}" class="btn button--open-basket is--icon-right"
                   title="{"{s name='AjaxCartLinkBasket'}{/s}"|escape}">
                    <i class="icon--arrow-right"></i>
                    {s name='AjaxCartLinkBasket'}{/s}
                </a>
            {/block}
        {/block}
    </div>
{/block}