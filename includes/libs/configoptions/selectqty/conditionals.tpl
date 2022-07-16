Here you can control other fields appearance dependent on this field value.
{if $field.id=='new'}
    <div style="margin:10px;text-align:center;font-weight: bold">Please save your field before adding logic/conditions
    </div>
{else}
    <div style="border:solid 1px #ddd;background:#F5F9FF; margin:10px 0px; ">
        <table width="100%" cellspacing="0" cellpadding="5" border="0">
            <tbody>
            <tr>
                <td align="left">
                    <div style="padding:5px 5px;">IF {$field.name} is set to</div>
                    <select style="margin:0px;" name="config[conditional][new][val]" id="condition_field_new_val">
                        <option value="0"> ---</option>
                        {if $field.items}
                            {foreach from=$field.items item=item key=k}
                                <option value="{$item.copy_of}">{$item.name}</option>
                            {/foreach}
                        {/if}
                    </select>
                </td>
                <td>
                    <div style="padding:5px 5px;">Than</div>
                    <select style="margin:0px;" id="condition_field_action" onchange="changeFieldAction($(this).val())" name="config[conditional][new][action]">
                        <option value="hide">Hide</option>
                        <option value="show">Show</option>
                        <option value="setval">Set value</option>
                    </select></td>
                <td id="select_target_id">
                    Loading...
                </td>
                <td align="right">
                    <div style="padding:26px 0 0;">
                        <a href="#" class="new_control greenbtn" onclick="saveChangesField();return false">
                            <span>{$lang.Add}</span>
                        </a>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <hr>

    <div>Optionally show/hide this component depending on the price of the cart</div>
    <div style="border:solid 1px #ddd;background:#F5F9FF; margin:10px 0px; ">
        <input type="hidden" name="config[conditional_cart_total][new][conditionsource]" value="cart_total"/>
        <input type="hidden" name="config[conditional_cart_total][new][target]" value="{$field.id}"/>
        <table width="100%" cellspacing="0" cellpadding="5" border="0">
            <tbody>
            <tr>
                <td>
                    <div style="display:flex;flex-direction:row;justify-content:start;align-items:center">
                        <select style="margin: 0 5px;" name="config[conditional_cart_total][new][action]">
                            <option value="hide">Hide</option>
                            <option value="show">Show</option>
                        </select>
                        <span style="margin: 0 10px;">this component if cart total</span>
                        <select style="margin: 0 5px;" name="config[conditional_cart_total][new][condition]">
                            <option value="more"> &gt;= (more than)</option>
                            <option value="less"> &lt; (less than)</option>
                        </select>
                        <span>
                        <input id="conditional_cart_total_field_new_val" type="number" step="0.01" class="styled" name="config[conditional_cart_total][new][conditionval]" size="10">
                        {$currency.iso}
                    </span>
                    </div>
                </td>
                <td align="right">
                    <div>
                        <a href="#" class="new_control greenbtn" onclick="saveChangesField(); return false"><span>{$lang.Add}</span></a>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <script type="text/javascript">
        {literal}
        setTimeout(function () {
            ajax_update("?cmd=configfields&action=helper&do=getotherfields&field_id={/literal}{$field.id}{literal}", false, '#select_target_id');
        }, 200);
        function changeFieldAction(val) {
            ajax_update("?cmd=configfields&action=helper&do=getotherfields&field_id={/literal}{$field.id}{literal}", {act: val}, '#select_target_id');
        }
        {/literal}
    </script>
    {if $field.config.conditionals}
        <br/>
        <h3 style="margin-top:10px">Current Field Logic</h3>
        <ul style="border:solid 1px #ddd;border-bottom:none;" class="grab-sorter" id="customitemseditor">
            {foreach from=$field.config.conditionals item=f key=k}
                <li style="background:#ffffff" id="conditional_{$k}">
                    <div style="border-bottom:solid 1px #ddd;">
                        <input type="hidden" name="config[conditional][{$k}][conditionsource]" value="{$f.conditionsource}"/>
                        <input type="hidden" name="config[conditional][{$k}][condition]" value="{$f.condition}"/>
                        <input type="hidden" name="config[conditional][{$k}][conditionval]" value="{$f.conditionval}"/>
                        <input type="hidden" name="config[conditional][{$k}][val]" value="{$f.val}"/>
                        <input type="hidden" name="config[conditional][{$k}][action]" value="{$f.action}"/>
                        <input type="hidden" name="config[conditional][{$k}][target]" value="{$f.target}"/>
                        <input type="hidden" name="config[conditional][{$k}][targetname]" value="{$f.targetname}"/>
                        <input type="hidden" name="config[conditional][{$k}][targetval]" value="{$f.targetval}"/>

                        <table width="100%" cellspacing="0" cellpadding="5" border="0">
                            <tbody>
                            <tr>
                                <td>
                                    {if $f.conditionsource === 'cart_total'}
                                        {$f.action|@ucfirst} <b>{$field.name}</b> if cart total
                                        {if $f.condition=='more'}&gt;={elseif $f.condition=='less'}&lt;{/if}
                                        <b>{$f.conditionval} {$currency.iso}</b>
                                    {else}
                                        If <b>{$field.name}</b> is set to {foreach from=$field.items item=item}
                                            {if $item.copy_of==$f.val}<b>{$item.name}</b>{break}{/if}
                                        {/foreach}
                                        Than
                                        <b>{if $f.action=='show'}Show{elseif $f.action=='hide'}Hide{else}Set value of{/if}
                                            {foreach from=$fields item=item}
                                                {if $item.copy_of==$f.target}<b>{$item.name}</b>{break}{/if}
                                            {/foreach}
                                            {if $f.targetval} to {$f.targetval} {/if}
                                        </b>
                                    {/if}
                                </td>
                                <td valign="top" align="right">
                                    <div style="padding:5px 0px;">
                                        <a href="#" class="menuitm" title="delete" style="width:12px;height:14px;display:block; box-sizing: content-box;" onclick="$('#condition_field_new_val').val(0);$('#conditional_{$k}').remove();saveChangesField();return false">
                                            <span class="delsth"></span>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </li>
            {/foreach}
        </ul>
    {/if}
{/if}