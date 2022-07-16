{if $setting.type === 'select'}
    <select name="{$setting.name}" class="form-control" {if $setting.has_toggle}data-toggle{/if}>
        {foreach from=$setting.items item=item}
            {if $item.value !== null}
                <option value="{$item.value}" {if $item.selected}selected{/if}
                        {if $item.enable}data-toggle="{$item.enable|@json_encode|escape}"{/if}>
                    {$item.title}{if $item.description}, {$item.description}{/if}
                </option>
            {/if}
        {/foreach}
    </select>
{elseif $setting.type == 'radio' || $setting.type == 'checkbox'}
    {foreach from=$setting.items item=item}
        {if $item.value !== null}
            <div class="radio-item">
                <input name="{$item.name}" type="{$setting.type}" value="{$item.value}"
                       {if $item.selected}checked{/if} class="inp"/>
                <strong>{$item.title}</strong>{if $item.description}, {$item.description}{/if}
            </div>
        {/if}
    {/foreach}
{elseif $setting.type == 'tpl'}
    {if $setting.tpl}
        {include file=$setting.tpl}
    {/if}
{elseif $setting.type != 'none'}
    <input type="{$setting.type}" name="{$setting.name}"  value="{$setting.selected.value}" />
{/if}
<div class="help-block" style="margin-bottom: 0">
    {$setting.description}
</div>