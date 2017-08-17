{extends file='frontend/index/index.tpl'}

{block name='frontend_index_header_title' prepend}{s name="ServiceIndexTitle"}{/s} | {/block}

{block name='frontend_index_content_main'}
    <div>
        <img src="{link file='frontend/_public/src/images/under_construction.jpg'}" alt="">
    </div>
{/block}

{* Disable left navigation *}
{block name='frontend_index_content_left'}{/block}

{* Disable top bar *}
{block name='frontend_index_top_bar_container'}{/block}

{* Disable search bar / my account button / basket button *}
{block name='frontend_index_shop_navigation'}{/block}