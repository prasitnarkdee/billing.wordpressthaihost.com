<select name="custom[{$kk}]" {if $fieldlogic}id="custom_field_{$c.copy_of}"{/if} {if $cmd == 'orders' && $c.options & 1}required{/if}>
    <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
    {foreach from=$c.items item=itm name=foo}
        <option data-val="{$itm.copy_of}" value="{$itm.id}"
                {if $c.values[$itm.id] || ($cmd == 'orders' && $make == 'getproduct' && $smarty.foreach.foo.first)}selected="selected"{/if}>{$itm.name}
            {if $admindata.access.viewOrdersPrices}
                {if $itm.price}({$itm.price|price:$currency:true:$forcerecalc}){/if}
            {/if}
            {if $itm.options & 1}[hidden]{/if}
        </option>
    {/foreach}
</select>
