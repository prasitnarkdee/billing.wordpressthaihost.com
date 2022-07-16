<form action="" method="post" id="itemsform">
    {if $itemqueue && $invoice.status != 'Draft'}
        <div  id="invoice-queue"  class="p6 secondtd" style="text-align:center;margin-bottom:7px;padding:15px 0px;">
            This customer have some items in invoice queue, would you like to add them here?<br/>
            <a class="new_control greenbtn" href="#itemqueue" ><span>Add items from queue</span></a>
        </div>
    {/if}
    <table class="invoice-table text-center" width="100%" border="0" cellpadding="0" cellspacing="0">
        <thead >
            <tr>
                <th width="16" ></th>
                <th class="text-left">{$lang.Description}</th>
                <th width="8%" class="acenter">{$lang.qty}</th>
                <th width="7%" class="acenter">{$lang.taxpercent}</th>
                <th width="9%" class="acenter">Unit Price ({if $TaxType=='inclusive'}Gross{else}Net{/if})</th>
                <th width="13%" class="text-right" style="text-align:right">{$lang.Linetotal}</th>
                <th width="1%" class="acenter">&nbsp;</th>
            </tr>
        </thead>
        <tbody id="main-invoice">
            {include file="invoices/items.tpl"}
        </tbody>
        {if !$invoice.readonly}
            <tbody id="new-item-invoice">
                <tr id="addliners">
                    <td class="summary blu acenter" style="padding-right:0px;padding-left:5px">

                        <a id="lineaction" class="setStatus menuitm {if $block_invoice}disabled{/if}">
                            <span class="gear_small" style="padding-left:16px;">
                                <span class="morbtn" style="padding-right:10px;">&nbsp;</span>
                            </span>
                        </a>
                        <ul id="lineaction_m" class="ddmenu">
                            <li>
                                <a href="NewLine" data-line="getproduct">New line from product</a>
                            </li>
                            {*<li><a href="NewLine" data-line="services">New line from client service</a></li>*}
                            {if $invoice.status!='Draft' && $invoice.status!='Recurring'}
                                <li>
                                    <a href="SplitItems">Split selected into new invoice</a>
                                </li>
                            {/if}
                            {adminwidget module="invoice" section="lineaction"}
                        </ul>

                    </td>
                    <td class="summary blu">
                        <div class="newline-basic clearfix">
                            <input name="item[n][description]" id="nline"
                                   class="foc invdescription" style="width:80%"
                                   placeholder="{$lang.newline}" {if $block_invoice}disabled{/if}/>
                            {if $line_translations}
                                <input name="item[n][description2]" id="nline_translation"
                                       class="foc invdescription" style="width:80%; margin-top: 5px;"
                                       placeholder="{$lang.translation}" {if $block_invoice}disabled{/if}/>
                                <div class="l_editor" id="l_editor_nline_translation}" style="width: 80%">
                                    <span class="translations">
                                        <span class="taag" style="display:none">Tags: </span>
                                    </span>
                                    <a class="fs11 l_adder" href="#" style="color: red;"
                                       onclick="return HBInputTranslate.addTranslation('nline_translation');">Add translation</a>
                                    <div class="clear"></div>
                                </div>
                            {/if}
                        </div>
                        <div class="newline-adv newline-adv-body clearfix">

                        </div>
                    </td>
                    <td class="summary blu acenter">
                        <input type="text" type="text" name="item[n][qty]" id="nline_qty"
                               size="8" class="foc invqty" value="1.00"
                               style="text-align:center" {if $block_invoice}disabled{/if}/>
                    </td>
                    <td class="summary blu acenter">
                        <div class="input-group input-combo">
                            <input type="hidden" name="item[n][taxed]" value="{if $invoice.taxexemp}0{else}1{/if}"
                                   id="nline_taxed" />
                            <input name="item[n][tax_rate]" {if $invoice.taxexempt || $block_invoice}disabled{/if}
                                   value="{if $invoice.taxexemp}{$lang.nontax}{else}{$invoice.taxrate}{/if}"
                                   type="text" size="3" id="nline_tax" class="text-right" data-toggle="dropdown" />
                            <span class="caret"></span>
                            <ul class="tax-rates dropdown-menu dropdown-menu-right" role="menu">
                                <li><a data-value="{$lang.nontax}" data-notax>{$lang.nontax}</a></li>
                                {foreach from=$tax_rates item=taxr}
                                    <li><a data-value="{$taxr}">{$taxr}%</a></li>
                                {/foreach}
                            </ul>
                        </div>
                    </td>
                    <td class="summary blu acenter">
                        <input type="text" name="item[n][amount]" id="nline_price"
                               class="foc invamount _search" size="16" value="0"
                               class="text-right" {if $block_invoice}disabled{/if}/>
                    </td>
                    <td class="summary blu" colspan="2">
                        <div class="pull-right">
                            <button class="btn btn-primary btn-sm newline-add" {if $block_invoice}disabled style="cursor: default;"{/if}>{$lang.Add}</button>
                            <a class="btn btn-default btn-sm newline-adv newline-cancel">{$lang.Cancel}</a>
                        </div>
                    </td>
                </tr>

            </tbody>
        {/if}
        <tr>
            <td valign="top" colspan="2">
                <div class="invoice-notes">
                    <strong>Public Notes</strong>
                    <div>
                        <textarea class="notes_field invitem" style="width:90%;height:60px;"
                                  name="{if $estimate}estimate{else}invoice{/if}[notes]" id="inv_notes"
                                  {if $invoice.readonly}readonly{/if}>{$invoice.notes}</textarea>
                    </div>
                </div>
            </td>
            <td colspan="5" valign="top" >
                <div id="updatetotals">
                    <table width="100%" class="invoice-summary">
                        <tr>
                            <td class="summary aright"  colspan="2"><strong data-invoice-total>{$lang.Subtotal}</strong></td>
                            <td class="summary aright" colspan="2"><strong data-invoice-subtotal>{$invoice.subtotal|price:$currency}</strong></td>
                            <td class="summary" width="2%"></td>
                        </tr>
                        {if $cmd=='invoices' && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft' && $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}
                            <tr>
                                <td class="summary aright"  colspan="2"><strong>{$lang.Credit}</strong></td>
                                <td class="summary aright" colspan="2"><strong>{$invoice.credit|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>
                        {/if}
                        {foreach from=$invoice.taxes item=tax}
                            {if $tax.tax != 0}
                            <tr>
                                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$tax.name})</strong></td>
                                <td class="summary aright" colspan="2"><strong>{$tax.tax|price:$currency}</strong></td>
                                <td class="summary"></td>
                            </tr>
                            {/if}
                        {/foreach}
                        <tr>
                            <td class="summary aright" colspan="2" ><strong class="bigger">{$lang.Total}</strong> {if ($invoice.taxrate!=0 || $invoice.taxrate2!=0) && $invoice.taxexempt}<a href="#" class="vtip_description" title="Tax exemption is enabled for this invoice"></a>{/if}</td>
                            <td class="summary aright" colspan="2" ><strong class="bigger">{$invoice.grandtotal|price:$currency}</strong></td>
                            <td class="summary"></td>
                        </tr>
                    </table>
                    <input type="hidden" class="invoice-update-field"
                           id="invoice-total" value="{$invoice.grandtotal}"
                           data-formated="{$invoice.grandtotal|price:$currency}">
                    <input type="hidden" class="invoice-update-field"
                           id="invoice-balance" value="{$balance}"
                           data-formated="{$balance|price:$currency}">
                    <input type="hidden" class="invoice-update-field"
                           id="invoice-appcredit" value="{$credit_available}"
                           data-formated="{$credit_available|price:$currency}">
                </div>
            </td>
        </tr>
    </table>
    {securitytoken}
</form>
