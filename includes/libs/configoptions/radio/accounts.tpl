{foreach from=$c.items item=cit}
<input name="{if $cf_opt_name}{$cf_opt_name}{else}custom{/if}[{$kk}]" data-variable="{$c.variable}" value="{$cit.id}" type="radio" {if $c.values[$cit.id]}checked="checked"{/if}  {if $fieldlogic}class="custom_field_{$c.copy_of}"{/if}/> {$cit.name}
    {if $admindata.access.viewOrdersPrices}
        {if $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}
    {/if}
    <br/>
    {if $cit.description}
        <span style="display:block;color: #777;margin-bottom: 5px;" class="text-secondary cf_item_description_value">{$cit.description|escape}</span>
    {/if}
{/foreach}


{if $fieldlogic &&  $c.config.conditionals}
    {cartfieldlogic}
    <script type="text/javascript">
        $('.custom_field_{$c.copy_of}').fieldLogic({literal}{{/literal}type: '{$c.type}'{literal}}{/literal},[{foreach from=$c.config.conditionals item=cd name=cond}{literal}{{/literal}
            value: '{$cd.targetval}',
            condition_type: '{$cd.condition}',
            condition_source: '{if $cd.conditionsource}{$cd.conditionsource}{else}self{/if}',
            target: '.custom_field_{$cd.target}',
            condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
            action: '{$cd.action}'
            {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
    </script>
{/if}
