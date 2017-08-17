{extends file="parent:frontend/checkout/cart_footer.tpl"}

{block name='frontend_checkout_cart_footer_add_product'}{/block}

{block name='frontend_checkout_cart_footer_add_voucher'}
    <form method="post" action="{url action='addVoucher' sTargetAction=$sTargetAction}" class="table--add-voucher add-voucher--form">
        <div class="add-voucher--panel block-group">
            {block name='frontend_checkout_cart_footer_add_voucher_field'}
                <input type="text" class="add-voucher--field is--medium block" name="sVoucher" placeholder="{"{s name='CheckoutFooterAddVoucherLabelInline'}{/s}"|escape}" />
            {/block}

            {block name='frontend_checkout_cart_footer_add_voucher_button'}
                <button type="submit" class="add-voucher--button is--medium btn is--primary is--center block">
                    <i class="icon--arrow-right"></i>
                </button>
            {/block}
        </div>
    </form>
{/block}