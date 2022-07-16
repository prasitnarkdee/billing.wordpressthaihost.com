{if $settings}
    <div class="sub-section">
        {if $section}
        <h1 class="sub-section-header">{$section}</h1>
        {/if}
        {foreach from=$settings item=setting}
            <div class="form-group opt_{$setting.key}">
                <label>{$setting.title}</label>
                {if !$setting.is_default}
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[{$setting.key}]" class="toc" value="1"
                               {if $setting.override}checked{/if} />
                        {if $setting.key === 'EnableProRata'}
                            Force pro-rata billing for new services
                        {else}
                            Override settings
                        {/if}

                        <div class="contener">
                            {include file="configuration/clientgroup/form.tpl"}
                        </div>
                    </div>
                {else}
                    <div class="contener">
                        {include file="configuration/clientgroup/form.tpl"}
                    </div>
                {/if}
            </div>
        {/foreach}
    </div>
{/if}