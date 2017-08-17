{block name='frontend_forms_elements'}
	<form id="support" name="support" data-checkbox="true" class="forms--main{$sSupport.class}" method="post" action="{url controller='ticket' action='index' id=$id}" enctype="multipart/form-data">
	<input type="hidden" name="forceMail" value="{$forceMail|escape}">

		{* Form Content *}
		{block name='frontend_forms_elements_form_content'}
			<div class="forms--inner-form">
				{foreach $sSupport.sElements as $sKey => $sElement}
					{if $sSupport.sFields[$sKey]||$sElement.note}
						{block name='frontend_forms_elements_form_builder'}

							<div class="form--entry {$sElement.class}">

								{* Eigene Formulargestaltung *}
								{if $sElement.typ == 'select'}
									<label for="{$sElement.name}">{$sElement.label}{if $sElement.required}*{/if}</label>
									<select name="{$sElement.name}" id="{$sElement.name}" {if $sElement.required} required aria-required="true"{/if}>
										<option value="" disabled selected>{$sElement.label}{if $sElement.required}*{/if}</option>
										{$values = explode(";",$sElement.value)}
										{foreach $values as $value}
											<option value="{$value}">{$value}</option>
										{/foreach}
									</select>

								{elseif $sElement.typ == 'text'}
									<label for="{$sElement.name}">{$sElement.label}{if $sElement.required}*{/if}</label>
									<input type="text" name="{$sElement.name}" id="{$sElement.name}" class="{if $sElement.required} is--required required{/if}" {if $sElement.required} required aria-required="true"{/if}>

								{elseif $sElement.typ == 'text2'}
									<label for="{$sElement.name}">{$sElement.label}{if $sElement.required}*{/if}</label>
									<input type="text" name="{$sElement.name}" id="{$sElement.name}" class="{if $sElement.required} is--required required{/if}" {if $sElement.required} required aria-required="true"{/if}>

								{elseif $sElement.typ == 'email'}
									<label for="{$sElement.name}">{$sElement.label}{if $sElement.required}*{/if}</label>
									<input type="email" name="{$sElement.name}" id="{$sElement.name}" class="{if $sElement.required} is--required required{/if}" {if $sElement.required} required aria-required="true"{/if}>

								{elseif $sElement.typ == 'textarea'}
									<label for="{$sElement.name}">{$sElement.label}{if $sElement.required}*{/if}</label>
									<textarea name="{$sElement.name}" id="{$sElement.name}" class="{if $sElement.required} is--required required{/if}" {if $sElement.required} required aria-required="true"{/if}></textarea>

								{elseif $sElement.typ == 'checkbox'}
									<input type="checkbox" class="is--fakeCheckbox{if $sElement.required} is--required required{/if}" name="{$sElement.name}" id="{$sElement.name}"{if $sElement.required} required aria-required="true"{/if}>
									<label for="{$sElement.name}" class="form--checkbox-label">
										{$sElement.label}
									</label>
								{/if}
							</div>
						{/block}

						{block name='frontend_forms_elements_form_description'}
							{if $sElement.note}
								<p class="forms--description">
									{eval var=$sElement.note}
								</p>
							{/if}
						{/block}
					{/if}
				{/foreach}

				{* Captcha *}
				{block name='frontend_forms_elements_form_captcha'}
					<div class="forms--captcha">
						<div class="captcha--placeholder" data-src="{url module=widgets controller=Captcha action=refreshCaptcha}"></div>
						<span class="captcha--notice">{s name='SupportLabelCaptcha'}{/s}</span>
						<div class="captcha--code">
							<input type="text" required="required" aria-required="true" name="sCaptcha"{if $sSupport.sErrors.e.sCaptcha} class="has--error"{/if} />
						</div>
					</div>
				{/block}

				{* Required fields hint *}
				{block name='frontend_forms_elements_form_required'}
					<div class="forms--required">
						{s name='RegisterPersonalRequiredText' namespace='frontend/register/personal_fieldset'}{/s}
					</div>
				{/block}

				{* Forms actions *}
				{block name='frontend_forms_elements_form_submit'}
					<div class="buttons form--entry is--half">
						<button class="btn is--primary" type="submit" name="Submit" value="submit">{s name='NxsSupportActionSubmit'}Absenden{/s}</button>
					</div>
				{/block}
			</div>
		{/block}
	</form>
{/block}

