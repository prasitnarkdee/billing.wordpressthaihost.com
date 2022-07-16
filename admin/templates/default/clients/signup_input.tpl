<div {if $field.type=='Company'}class="iscomp form-group" style="{if $client.company!='1'}display:none{/if}"
     {elseif $field.type=='Private'}class="ispr form-group"
        style="{if $client.company=='1'}display:none{/if}"
     {else} class="form-group" {/if} >
    <label for="{$k}">
        {if $k=='type'}
            {$lang.clacctype}
        {elseif $field.options & 1}
            {if $lang[$k]}{$lang[$k]}
            {else}{$field.name}
            {/if}
        {else}{$field.name}
        {/if}
        {if $field.description}
            <i class="vtip_description" style="font-size:inherit" title="{$field.description}"></i>
        {/if}
    </label>

    {if $k == 'type'}
    <select name="type" class="form-control">
        <option value="Private"
                {if $client.type=='Private' || (!$client.type && in_array('Private', $field.default_value)) || (!$client.type && !$field.default_value)}selected{/if}>
            {$lang.Private}
        </option>
        <option value="Company"
                {if $client.type=='Company' || (!$client.type && in_array('Company', $field.default_value))}selected{/if}>
            {$lang.Company}
        </option>
    </select>
    {literal}
        <script>
            $(function () {
                $('select[name="type"]')on('change', function(){
                    $('.iscomp').toggle(this.value !== 'Private');
                    ('.ispr').toggle(this.value === 'Private');
                }).trigger('change');
            })
        </script>
    {/literal}
    {elseif $k=='country'}
    <select name="country" class="form-control" {if $parent}data-parentval="{$parent[$k]}"{/if}>
        {foreach from=$countries key=k item=v}
            <option value="{$k}" {if $k==$client.country  || (!$client.country && $k==$defaultCountry)}selected{/if}>
                {$v}
            </option>
        {/foreach}
    </select>
    {else}
    {if $field.field_type=='Input' ||  $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}
        {if $k=='phonenumber' || $field.field_type=='Phonenumber'}
        <input type="text" value="{$client[$k]}" class="form-control"
               name="{$k}" id="field_live_{$k}" {if $field.readonly}readonly{/if}
               data-initial-country="{$client.country|default:$default_country}"/>
            <script>initPhoneNumberField($('#field_live_{$k}'));</script>
        {else}
        <input type="text" value="{$client[$k]}" class="form-control"
               name="{$k}" id="field_live_{$k}" {if $field.readonly}readonly{/if}
                {if $parent}data-parentval="{$parent[$k]}"{/if} />
        {/if}
    {elseif $field.field_type=='Password'}
        <input type="password" autocomplete="off" value="" class="form-control"
               name="{$k}" {if $field.readonly}readonly{/if} />
    {elseif $field.field_type=='Select' || $field.field_type == 'Contact'}
        <select name="{$k}" class="form-control" id="field_live_{$k}"
                {if $parent}data-parentval="{$parent[$k]}"{/if} >
            {if $field.items}
                {foreach from=$field.items item=itm}
                    <option value="{$itm.value}" {if $client[$k]==$itm.value}selected{/if}>{$itm.label}</option>
                {/foreach}
            {else}
                {foreach from=$field.default_value item=fa}
                    <option {if $client[$k]==$fa}selected{/if}>{$fa}</option>
                {/foreach}
            {/if}
        </select>
    {elseif $field.field_type=='Check'}
        <div class="checkbox">
            {foreach from=$field.default_value item=fa key=fk}
                <label>
                    <input type="checkbox" name="{$field.code}[{$fk}]" value="1"
                           {if in_array($fa,$client[$field.code])}checked{/if}
                            {if $parent}data-parentval="{if in_array($fa, $parent[$k])}1{else}0{/if}"{/if}/>
                    {$fa}
                </label>
            {/foreach}
        </div>
    {elseif $field.field_type=='File'}
        {foreach from=$field.default_value item=fa key=fk}
        <input type="file" name="{$field.code}">
        {/foreach}
    {/if}
    {/if}
</div>