<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin:15px 0px">
    <tr>
        <td valign="top" width="50%">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
                    {foreach from=$fields item=field name=floop key=k}
                        {if $smarty.foreach.floop.iteration > ($smarty.foreach.floop.total/2)}{break}{/if}

                        <tr height="46"  {if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
                            {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
                            <td class="{if $smarty.foreach.floop.iteration>0}bord{/if}"> <label for="field_{$k}" >
                                    {if $k=='type'}
                                        {$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $k=='password' && $action=='edit'}
                                            {$lang.newpassword}
                                        {else}
                                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                        {/if}
                                    {else}
                                        {$field.name}
                                    {/if}
                                    {if ($field.options & 2) && !($k=='password' && $action=='edit')}*{/if}
                                    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                                </label>
                                {if $k=='type'}
                                    <select  id="field_{$k}" name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                                        <option value="Private" {if $submit.type=='Private' || (!$submit.type && in_array('Private', $field.default_value)) || (!$submit.type && !$field.default_value)}selected="selected"{/if}>{$lang.Private}</option>
                                        <option value="Company" {if $submit.type=='Company' || (!$submit.type && in_array('Company', $field.default_value))}selected="selected"{/if}>{$lang.Company}</option>
                                    </select>
                                {elseif $k=='country'}
                                    <select name="country" style="width: 90%;" id="field_{$k}" class="chzn-select">
                                        {foreach from=$countries key=k item=v}
                                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>
                                        {/foreach}
                                    </select>
                                {else}
                                    {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}
                                        {if  $k=='captcha'}
                                            <div style="white-space: nowrap;">
                                                <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" />
                                                <span style="display: inline-block; width: 65%; white-space: normal;">
                                                    {$lang.typethecharacters}<br />
                                                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                                </span>
                                            </div>
                                        {/if}
                                        <input type="text" placeholder="{$field.placeholder}" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Password'}
                                        <input type="password" autocomplete="off" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Select'}
                                        <select name="{$k}" style="width: 90%;" id="field_{$k}" >
                                            {foreach from=$field.default_value item=fa}
                                                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $field.field_type=='Check'}
                                        {foreach from=$field.default_value item=fa}
                                            <input type="checkbox" name="{$k}[{$fa|escape}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
                                        {/foreach}
                                    {elseif $field.field_type=='File'}
                                        <input type="file" name="{$k}" />
                                        <small class="">{$field.expression|string_format:$lang.$allowedext}</small>
                                    {/if}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="50%">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
                    {foreach from=$fields item=field name=floop key=k}
                        {if $smarty.foreach.floop.iteration <= ($smarty.foreach.floop.total/2)}{continue}{/if}

                        <tr height="46" {if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
                            {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
                            <td class="">
                                <label for="field_{$k}" >
                                    {if $k=='type'}
                                        {$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                    {else}
                                        {$field.name}
                                    {/if}
                                    {if $field.options & 2}*{/if}
                                    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                                </label>
                                {if $k=='type'}
                                    <select  id="field_{$k}"  name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                                        <option value="Private" {if $submit.type=='Private' || (!$submit.type && in_array('Private', $field.default_value)) || (!$submit.type && !$field.default_value)}selected="selected"{/if}>{$lang.Private}</option>
                                        <option value="Company" {if $submit.type=='Company' || (!$submit.type && in_array('Company', $field.default_value))}selected="selected"{/if}>{$lang.Company}</option>
                                    </select>
                                {elseif $k=='country'}
                                    <select name="country" style="width: 90%;" id="field_{$k}"  class="chzn-select">
                                        {foreach from=$countries key=k item=v}
                                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

                                        {/foreach}
                                    </select>
                                {else}
                                    {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}
                                        {if  $k=='captcha'}
                                            <div style="white-space: nowrap;">
                                                <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" />
                                                <span style="display: inline-block; width: 65%; white-space: normal;">
                                                    {$lang.typethecharacters}<br />
                                                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                                </span>
                                            </div>
                                        {/if}
                                        <input type="text" placeholder="{$field.placeholder}" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Password'}
                                        <input type="password" autocomplete="off" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Select'}
                                        <select name="{$k}" style="width: 90%;" id="field_{$k}" >
                                            {foreach from=$field.default_value item=fa}
                                                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $field.field_type=='Check'}
                                        {foreach from=$field.default_value item=fa}
                                            <input type="checkbox" name="{$k}[{$fa|escape}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
                                        {/foreach}
                                    {elseif $field.field_type=='File'}
                                        <input type="file" name="{$k}" />
                                        <small class="">{$field.expression|string_format:$lang.$allowedext}</small>
                                    {/if}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
    </tr>
</table>
<script type="text/javascript" src="{$template_dir}js/chosen.min.js"></script>
<script type="text/javascript" src="{$template_dir}../common/js/singup.js"></script>
{literal}
    <script>
        $(function () {$('select[name="type"]').trigger('change');})
    </script>
{/literal}



