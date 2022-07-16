{$lang.new_ProRataDay}
<input class="inp" size="2" name="settings[ProRataDay]"
       value="{$configuration.ProRataDay|escape}"/>
{$lang.new_ProRataMonth}
<select class="inp" name="settings[ProRataMonth]">
    <option value="disabled"
            {if $configuration.ProRataMonth == 'disabled'}selected{/if}>
        {$lang.new_ProRataMonth_disabled}
    </option>
    {foreach from=$months item=month}
        <option value="January"
                {if $configuration.ProRataMonth == $month}selected{/if}>
            {$lang[$month]}
        </option>
    {/foreach}
</select>
<div>
    {$lang.new_ProRataNextMonth}
    <a class="vtip_description" title="{$lang.promonthdesc}"></a>
    <input type="checkbox" name="settings_enabled[ProRataNextMonth]" value="1"
           {if $configuration.ProRataNextMonth>0}checked{/if} value="1"/>
    <input type="text" name="settings[ProRataNextMonth]"
           value="{$configuration.ProRataNextMonth|escape}" inp" size="3" />
</div>

