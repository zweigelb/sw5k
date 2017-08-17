{block name='frontend_detail_actions_notepad'}
    <form action="{url controller='note' action='add' ordernumber=$sArticle.ordernumber_raw}" method="post"
          class="action--form">
        <button type="submit"
                class="action--link link--notepad"
                title="{"{s name='DetailLinkNotepad'}{/s}"|escape}"
                data-ajaxUrl="{url controller='note' action='ajaxAdd' ordernumber=$sArticle.ordernumber_raw}"
                data-text="{s name="DetailNotepadMarked"}{/s}">
            <i class="fa fa-heart-o" aria-hidden="true"></i> <span class="action--text">{s name="DetailLinkNotepadShort"}{/s}</span>
        </button>
    </form>
{/block}

