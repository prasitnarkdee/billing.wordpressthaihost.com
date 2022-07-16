<div {if $field.type=='Company'}class="iscomp form-group"
     style="{if  $client.company!='1'}display:none{/if}"
     {elseif $field.type=='Private'}class="ispr form-group"
     style="{if $client.company=='1'}display:none{/if}" {else} class="form-group" {/if} >
    <label for="{$k}">
        {if $k=='type'}
            {$lang.clacctype}
        {elseif $field.options & 1}
            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
        {else}
            {$field.name}
        {/if}
        {if $field.description}
            <i class="vtip_description" style="font-size:inherit" title="{$field.description}"></i>
        {/if}
    </label>
    <div class="form-plaintext {if !$field.readonly}{$class}{/if}">
        {if $k=='type'}
        {elseif $k=='country'}
            {$client.country} - {$countries[$client.country]}
        {else}
            {if $field.field_type=='Input'}
                {$client[$k]}
            {elseif $field.field_type=='Password'}
                ***
            {elseif $field.field_type=='Select'}
                {if $field.items}
                    {foreach from=$field.items item=itm}
                        {if $client[$k]==$itm.value}{$itm.label}{/if}
                    {/foreach}
                {else}
                    {$client[$k]}
                {/if}
            {elseif $field.field_type=='Check'}
                {foreach from=$field.default_value item=fa}
                    {if in_array($fa,$client[$k])}{$fa},{/if}
                {/foreach}
            {elseif $field.field_type=='File'}
                {if $client[$k]}
                    <a class="left"
                       href="?cmd=root&amp;action=download&amp;type=downloads&amp;id={$client[$k]}">Download</a>
                {else}
                    {$lang.none}
                {/if}
            {elseif $field.field_type == 'Contact'}
                {foreach from=$field.default_value item=fa key=id}
                    {if $client[$field.code]==$id}{$fa}{/if}
                {/foreach}
            {else}
                {$client[$k]}
            {/if}
        {/if}
    </div>
</div>