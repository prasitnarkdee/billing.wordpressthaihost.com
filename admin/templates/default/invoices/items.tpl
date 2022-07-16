{foreach from=$invoice.items item=item key=pos}
    <tr {if $item.id}id="line_{$item.id}" data-item-id="{$item.id}"{/if} data-line="{$pos}">
        <td class="acenter">
            <input type="checkbox" name="invoice_item_id[]"
                   value="{$item.id}" {if !$item.id}disabled{/if}
                   class="invitem_checker"/>
            {if !$item.id}
                <input type="hidden" name="item[{$pos}][item_id]"
                       value="{$item.item_id}"
                       class="invitem_checker"/>
                <input type="hidden" name="item[{$pos}][type]"
                       value="{$item.type}"
                       class="invitem_checker"/>
            {/if}
        </td>
        <td class="editor-line">
            <div class="editor-line-description">
                {if $item.type=='Hosting' && $item.item_id!='0'}
                    <a href="?cmd=accounts&action=edit&id={$item.item_id}&list=all" class="line_descr">{$item.description|nl2br}</a>
                {elseif ($item.type=='Domain Register' || $item.type=='Domain Transfer' || $item.type=='Domain Renew') && $item.item_id!='0'}
                    <a href="?cmd=domains&action=edit&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
                {elseif $item.type=='Invoice' && $item.item_id!='0'}
                    <a href="?cmd=invoices&action=edit&id={$item.item_id}&list=all" class="line_descr">{$item.description|nl2br}</a>
                {elseif $item.type=='Support' && $item.item_id!='0'}
                    <a href="?cmd=tickettimetracking&action=item&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
                {elseif $item.type=='Ticket' && $item.item_id!='0'}
                    <a href="?cmd=tickets&action=view&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
                {elseif $item.type=='Order' && $item.item_id!='0'}
                    <a href="?cmd=orders&action=edit&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
                {else}
                    <span class="line_descr">{$item.description|nl2br}</span>
                {/if}
                {if !$block_invoice}
                    {if !$item.readonly}
                        <a class="editbtn" style="display:none;"  href="#">{$lang.Edit}</a>
                    {/if}
                {/if}
                {if $line_translations}
                    <br><span style="color: #888888">{$item.description2|nl2br}</span>
                {/if}
            </div>
            <div class="editor-line-form row">
                <div class="col-sm-10">
                    <textarea class="foc invitem invdescription"
                              name="item[{$pos}][description]"
                              rows="1" style="width: 100%"
                              >{$item.description}</textarea>
                    {if $line_translations}
                        <textarea class="foc invitem invdescription" placeholder="{$lang.translation}" id="translation{$pos}"
                                  name="item[{$pos}][description2]"
                                  rows="1" style="width: 100%; margin-top: 5px;"
                        >{$item.description2}</textarea>
                        <div class="l_editor" id="l_editor_translation{$pos}">
                        <span class="translations">
                            <span class="taag" style="display:none">Tags: </span>
                        </span>
                            <a class="fs11 l_adder" href="#" style="color: red;"
                               onclick="return HBInputTranslate.addTranslation('translation{$pos}');">Add translation</a>
                            <div class="clear"></div>
                        </div>
                    {/if}
                </div>
                <div class="col-sm-2">
                    <a class="editbtn" href="#">{$lang.Cancel}</a>
                </div>
            </div>
        </td>
        <td class="acenter">
            <input name="item[{$pos}][qty]" value="{$item.qty}"
                   size="8" class="foc invitem invqty"
                   {if $item.readonly}readonly{/if}
                   style="text-align:center" {if $block_invoice}disabled{/if}/>
        </td>
        <td class="acenter">
            <div class="input-group input-combo">
                <input type="hidden" name="item[{$pos}][taxed]" value="{$item.taxed}"
                       class="invitem invtaxed" />
                <input type="text" name="item[{$pos}][tax_rate]"
                       {if $invoice.taxexempt || $block_invoice}disabled{/if}
                        {if $item.readonly}readonly{/if} size="3"
                       value="{if $item.taxed}{$item.tax_rate}{else}{$lang.nontax}{/if}"
                       class="invitem invtaxrate _search text-right" data-toggle="dropdown"
                />
                <span class="caret"></span>
                <ul class="tax-rates dropdown-menu dropdown-menu-right" role="menu">
                    <li><a data-value="{$lang.nontax}" data-notax>{$lang.nontax}</a></li>
                    {foreach from=$tax_rates item=taxr}
                        <li><a data-value="{$taxr}">{$taxr}%</a></li>
                    {/foreach}
                </ul>
            </div>
        </td>
        <td class="acenter">
            <input name="item[{$pos}][amount]" value="{$item.amount}" size="16"
                   class="foc invitem invamount _search text-right"
                   {if $item.readonly}readonly{/if} {if $block_invoice}disabled{/if}
                   />
        </td>
        <td class="aright">
            {$currency.sign}
            <span id="ltotal_{$pos}">{$item.linetotal|string_format:"%.2f"}</span>
            {if $currency.code}
                {$currency.code}
            {else}{$currency.iso}
            {/if}
        </td>
        <td class="acenter">
            {if !$item.readonly}
                <a href="?cmd=invoices&action=removeline&id={$invoice.id}&line={$pos}"
                   class="btn btn-xs btn-default removeLine {if $block_invoice}disabled{/if}">
                    {if $item.id}
                        <i class="fa fa-trash"></i>
                    {else}
                        <i class="fa fa-close"></i>
                    {/if}
                </a>
            {/if}
        </td>
    </tr>
{/foreach}