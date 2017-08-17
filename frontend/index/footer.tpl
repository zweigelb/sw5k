{block name="frontend_index_footer_content"}
    <div class="footer--content">
        <nav class="footer--nav footer--content-nav">
            <ul class="footer--nav-list">
                {foreach $sMenu.gBottom as $item}
                    <li class="footer--nav-entry" role="menuitem">
                        <a class="footer--nav-link" href="{if $item.link}{$item.link}{else}{url controller='custom' sCustom=$item.id title=$item.description}{/if}" title="{$item.description|escape}"{if $item.target} target="{$item.target}"{/if}>
                            {$item.description}
                        </a>
                    </li>
                {/foreach}
            </ul>
        </nav>

        <form class="newsletter--form" action="{url controller='newsletter'}" method="post">
            <input type="hidden" value="1" name="subscribeToNewsletter" />

            <label for="newsletter" class="newsletter--label">{s name="frontendFooterNewsletter"}Newsletter{/s}</label>

            <div class="newsletter--form-inner">
                <input type="email" name="newsletter" class="newsletter--field" placeholder="{s name="frontendFooterNewsletterPlaceholder"}Ihre E-Mail{/s}" />

                <button type="submit" class="newsletter--button">
                    <i class="fa fa-envelope-o" aria-hidden="true"></i>
                </button>
            </div>
        </form>

        <div class="footer--social">
            <div class="footer--social-label">{s name="frontendFooterSocial"}follow us on{/s}</div>

            <div class="footer--social-list">
                <a href="{s name='frontendFooterSocialFacebookLink'}https://www.facebook.com/KennelSchmengerSchuhmanufaktur{/s}" target="_blank" class="footer--social-link" title="{s name='frontendFooterSocialFacebook'}Facebook{/s}"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="{s name='frontendFooterSocialInstagramLink'}http://instagram.com/kennelundschmenger{/s}" target="_blank" class="footer--social-link" title="{s name='frontendFooterSocialInstagram'}Instagram{/s}"><i class="fa fa-instagram" aria-hidden="true"></i></a>
            </div>
        </div>
            </div>

{/block}


<div class="footer--copyright">
    <nav class="footer--nav footer--copyright-nav">
        <ul class="footer--nav-list">
            {foreach $sMenu.gBottom2 as $item}
                <li class="footer--nav-entry" role="menuitem">
                    <a class="footer--nav-link" href="{if $item.link}{$item.link}{else}{url controller='custom' sCustom=$item.id title=$item.description}{/if}" title="{$item.description|escape}"{if $item.target} target="{$item.target}"{/if}>
                        {$item.description}
                    </a>
                </li>
            {/foreach}
        </ul>
    </nav>

    <div class="footer--copyright-notice">
        &copy;{$smarty.now|date_format:"%Y"} {s name="footerCopyright"}Kennel & Schmenger Handelsgesellschaft mbH{/s}
    </div>
</div>

