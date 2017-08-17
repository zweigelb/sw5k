{extends file='frontend/index/index.tpl'}

{* Sidebar left *}
{block name='frontend_index_content_left'}{/block}

{block name="frontend_index_header"}
	{include file="frontend/forms/header.tpl"}
{/block}

{* Main content *}
{block name='frontend_index_content'}
	<div class="forms--content content">

		{* Form error *}
		{block name='frontend_forms_elements_error'}
			{if $sSupport.sErrors.e || $sSupport.sErrors.v}
				{$errorContent=""}
				<div class="error">
					{if $sSupport.sErrors.v}
						{foreach from=$sSupport.sErrors.v key=sKey item=sError}
							{if $sKey !=0&&$sSupport.sElements.$sError.error_msg}{$errorContent="{$errorContent}<br />"}{/if}
							{$errorContent="{$errorContent}{$sSupport.sElements.$sError.error_msg}"}
						{/foreach}
						{if $sSupport.sErrors.e}
							{$errorContent="{$errorContent}<br />"}
						{/if}
					{/if}

					{if $sSupport.sErrors.e}
						{$errorContent="{$errorContent}{s name='SupportInfoFillRedFields' namespace="frontend/forms/elements"}{/s}"}
					{/if}

					{block name='frontend_forms_elements_error_messages'}
						{include file="frontend/_includes/messages.tpl" type='error' content=$errorContent}
					{/block}
				</div>
			{/if}
		{/block}

        {* Forms headline *}
        {block name='frontend_forms_index_headline'}
			{if $sSupport.sElements}
				<h1 class="forms--title">{$sSupport.name}</h1>
				<div class="forms--text">{eval var=$sSupport.text}</div>
			{elseif $sSupport.text2}
				{include file="frontend/_includes/messages.tpl" type="success" content=$sSupport.text2}
			{/if}
        {/block}

		{* Forms Content *}
		{block name='frontend_forms_index_content'}
			{if $sSupport.sElements}
				<div class="forms--container">
					{block name='frontend_forms_index_elements'}
						{include file="frontend/forms/elements.tpl"}
					{/block}
				</div>
			{/if}
		{/block}

	</div>
{/block}
