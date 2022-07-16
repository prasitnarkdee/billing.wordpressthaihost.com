{if $action=='edittemplate'}
    {include file='configuration/edit_template.tpl'}
{elseif $action=='invoicetemplates'}
    <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="make" value="saveconfig"/>
        <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable">
            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>Document Logo</strong></td>

                <td colspan="3">
                    <input type="radio" value="0" {if $configuration.InvCompanyLogo==''}checked="checked"{/if}
                           name="InvCompanyLogoY" onclick="$('#logouploaders').slideUp();"/>
                    <strong>{$lang.InvCompanyLogo_descr1}</strong><br/>
                    <input type="radio" value="1" {if $configuration.InvCompanyLogo!=''}checked="checked"{/if}
                           name="InvCompanyLogoY" onclick="$('#logouploaders').slideDown();"/>
                    <strong>{$lang.InvCompanyLogo_descr}</strong>
                    <div class="clear"></div>
                    <div class="p6 left" id="logouploaders"
                         style="{if $configuration.InvCompanyLogo==''}display:none;{/if}padding:10px 5px;margin-top:10px;">
                        <table border="0" cellspacing="0" cellpadding="6">
                            <tr>
                                <td width="200" style="border:none" valign="top" align="center" class="fs11">
                                    {if $configuration.InvCompanyLogo!=''}
                                        {$lang.CurrentLogo}:
                                        <img src="../templates/{$configuration.InvCompanyLogo}"
                                             alt="{$configuration.BusinessName}" style="max-width: 200px;"/>
                                    {else}
                                        No logo uploaded yet
                                    {/if}
                                </td>
                                <td style="border:none">
                                    {$lang.NewLogo}: <input name="file" id="InvCompanyLogo" type="file"/><br/>

                                </td>
                            </tr>

                        </table>
                    </div>
                    <div class="clear"></div>


                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>{$lang.InvoiceTemplate}</strong>
                    <br/>
                    <a href="?cmd=configuration&action=invoicetemplates&make=createnew&target=invoice&security_token={$security_token}"
                       class="btn btn-success btn-xs">Create new</a>

                </td>
                <td colspan="3">
                    {include file='ajax.invoice.template.table.tpl' config='InvoiceTemplate' items=$invtemplates}


                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>{$lang.EstimateTemplate}</strong><br/>
                    <a href="?cmd=configuration&action=invoicetemplates&make=createnew&target=estimate&security_token={$security_token}"
                       class="btn btn-success btn-xs">Create new</a>

                </td>
                <td colspan="3">
                    {include file='ajax.invoice.template.table.tpl' config='EstimateTemplate' items=$estimatetemplates}

                </td>
            </tr>

            {if $configuration.CnoteEnable=='on'}
                <tr class="bordme">
                    <td width="205" align="right" valign="top"><strong>{$lang.CreditNoteTemplate}</strong>
                        <br/>
                        <a href="?cmd=configuration&action=invoicetemplates&make=createnew&target=creditnote&security_token={$security_token}"
                           class="btn btn-success btn-xs">Create new</a>

                    </td>
                    <td colspan="3">
                        {include file='ajax.invoice.template.table.tpl' config='CNoteTemplate' items=$cnotetemplate}

                    </td>
                </tr>
            {/if}


            {if $configuration.ReceiptEnable=='on'}
                <tr class="bordme">
                    <td width="205" align="right" valign="top"><strong>{$lang.CreditReceiptTemplate}</strong>
                        <br/>
                        <a href="?cmd=configuration&action=invoicetemplates&make=createnew&target=creditreceipt&security_token={$security_token}"
                           class="btn btn-success btn-xs">Create new</a>

                    </td>
                    <td colspan="3">

                        {include file='ajax.invoice.template.table.tpl' config='ReceiptTemplate' items=$receipttemplate}

                    </td>
                </tr>
            {/if}
            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>Attachment templates</strong>
                    <br/>
                    <a href="?cmd=configuration&action=invoicetemplates&make=createnew&target=attachment&security_token={$security_token}"
                       class="btn btn-success btn-xs">Create new</a>

                </td>
                <td colspan="3">

                    {include file='ajax.invoice.template.table.tpl'  items=$attachmenttemplate}

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>{$lang.account_statement}</strong>
                    <br/>
                    <a href="?cmd=configuration&action=invoicetemplates&make=createnew&target=accountstatement&security_token={$security_token}"
                       class="btn btn-success btn-xs">Create new</a>

                </td>
                <td colspan="3">

                    {include file='ajax.invoice.template.table.tpl' config='AccountStatementTemplate' items=$accountstatementtemplate}

                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <h3>Invoice details</h3>
                </td>
                <td colspan="3">

                </td>
            </tr>
            <tr class="bordme euinvoices"
            "="">
            <td align="right" width="205"><strong>Discount on invoice</strong></td>
            <td colspan="3">
                <input name="DiscountOnInvoice" type="radio" value="on"
                       {if $configuration.DiscountOnInvoice=='on'}checked="checked"{/if} class="inp">
                <strong>Yes, </strong>Show discount on invoice as negative invoice lines<br>
                <input name="DiscountOnInvoice" type="radio" value="coupon"
                       {if $configuration.DiscountOnInvoice=='coupon'}checked="checked"{/if} class="inp">
                <strong>Yes, </strong>Show discount on invoice as lines with coupon code<br>
                <input name="DiscountOnInvoice" type="radio" value="off"
                       {if $configuration.DiscountOnInvoice=='off'}checked="checked"{/if} class="inp">
                <strong>No, </strong>Just discount invoice amounts, without showing discount details
            </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Use 2nd currency: <a class="vtip_description"
                                            title="All invoice values will be displayed in 2 currencies, original (the one invoice was generated in), and second selected from list below. <br/>Works only on invoices generated after this option is enabled."></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="Invoice2ndcurrency" value="1"
                           {if $configuration.Invoice2ndcurrency}checked="checked"{/if}
                           onclick="$('#daybefore,#comment').toggle()"/>

                    <select class="inp" name="Invoice2ndcurrency_val">
                        {foreach from=$a_currencies item=v key=k}
                            <option value="{$k}"
                                    {if $configuration.Invoice2ndcurrency_val == $k}selected="selected"{/if}>{$v.iso}</option>
                        {/foreach}
                    </select>
            </tr>

            <tr class="bordme" id="daybefore" {if !$configuration.Invoice2ndcurrency}style="display:none"{/if}>
                <td width="205" align="right" valign="middle">
                    <b>'Day before' conversion: <a class="vtip_description"
                                                   title="If 2nd currency is enabled, HostBill will use conversion rate from day invoice was created (for EU invoices payment date is used). <br/> To use conversion rate from day before mentioned dates use this option (required in some EU countries)"></a></b><br/>
                </td>
                <td colspan="3"><input type="checkbox" name="InvoiceDayBefore" value="1"
                                       {if $configuration.InvoiceDayBefore}checked="checked"{/if} />

            </tr>

            <tr class="bordme" id="comment" {if !$configuration.Invoice2ndcurrency}style="display:none"{/if}>
                <td width="205" align="right" valign="middle">
                    <b>Conversion rate in note: <a class="vtip_description"
                                                   title="Place conversion rate used for 2nd currency in invoice notes"></a></b><br/>
                </td>
                <td colspan="3"><input type="checkbox" name="InvoiceConversionRate" value="1"
                                       {if $configuration.InvoiceConversionRate}checked="checked"{/if} />

            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Use 2nd language: <a class="vtip_description"
                                            title="When enabled all {literal}{$lang}{/literal} will be additionally translated with second language"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="Invoice2ndlanguage" value="1"
                           {if $configuration.Invoice2ndlanguage}checked="checked"{/if} />
                    <select class="inp" name="Invoice2ndlanguage_val">
                        {foreach from=$a_languages item=v key=k}
                            <option value="{$v.name}"
                                    {if $configuration.Invoice2ndlanguage_val == $v.name}selected="selected"{/if}>{$v.name}</option>
                        {/foreach}
                    </select>
                </td>

            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>{$lang.TranslateInvoiceLines}:</b><br/>
                </td>
                <td colspan="3">
                    <input name="TranslateInvoiceLines" type="radio" value="off"
                           {if $configuration.TranslateInvoiceLines == 'off' || !$configuration.TranslateInvoiceLines}checked="checked"{/if} class="inp">
                    {$lang.TranslateInvoiceLinesOpt1}<br>
                    <input name="TranslateInvoiceLines" type="radio" value="on"
                           {if $configuration.TranslateInvoiceLines=='on'}checked="checked"{/if} class="inp">
                    {$lang.TranslateInvoiceLinesOpt2}
                    <select name="TranslateInvoiceLinesLang">
                        {foreach from=$a_languages item=v key=k}
                            <option value="{$v.name}"
                                    {if $configuration.TranslateInvoiceLinesLang == $v.name}selected="selected"{/if}>{$v.name}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Show account #ID: <a class="vtip_description"
                                            title="When enabled invoice lines will show account ID for related entries"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="InvoiceShowAccountId" value="1"
                           {if $configuration.InvoiceShowAccountId}checked="checked"{/if} />

                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Show account label: <a class="vtip_description"
                                              title="When enabled invoice lines will show account label entered by customer in client portal"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="InvoiceShowAccountLabel" value="1"
                           {if $configuration.InvoiceShowAccountLabel}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Period on recurring invoices: <a class="vtip_description"
                                                        title="Invoices issued for accounts gets period added to them by default. Invoices issued from Invoices->Recurring can also have period added when this feature is enabled"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="RecurringAddPeriod" value="on"
                           {if $configuration.RecurringAddPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Period on upgrade invoices: <a class="vtip_description"
                                                      title="Invoices issued for account upgrades does not have  period added to them by default. "></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="UpgradesAddPeriod" value="on"
                           {if $configuration.UpgradesAddPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Category/Product on upgrade invoices: <a class="vtip_description"
                                                                title="Invoices issued for account upgrades does not have category/product added to them by default. "></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="UpgradesAddCatProd" value="on"
                           {if $configuration.UpgradesAddCatProd=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>SSL period as years: </b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="SSLPeriodYears" value="on"
                           {if $configuration.SSLPeriodYears=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Domain period as dates: </b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="DomainPeriodDates" value="on"
                           {if $configuration.DomainPeriodDates=='on'}checked="checked"{/if} />

                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Adjust domain period on invoice: <a class="vtip_description"
                                                           title="When enabled domain period will be adjusted on invoice to match actual period after registration/transfer "></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="AdjustDomainPeriod" value="on"
                           {if $configuration.AdjustDomainPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Adjust period on initial service invoice: <a class="vtip_description"
                                                           title="When enabled hosting period will be adjusted on initial invoice to match actual period after creation "></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="AdjustAccountInitialPeriod" value="on"
                           {if $configuration.AdjustAccountInitialPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>Period on domain transfer invoices: </b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="TransferOrderPeriod" value="on"
                           {if $configuration.TransferOrderPeriod=='on'}checked="checked"{/if} />

                </td>
            </tr>

            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>{$lang.period_on_estimates}: <a class="vtip_description"
                                                       title="{$lang.period_on_estimates_desc}"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="PeriodOnEstimates" value="on"
                           {if $configuration.PeriodOnEstimates=='on'}checked="checked"{/if} />
                </td>
            </tr>
            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>{$lang.SetupFeeSeparateLine}: <a class="vtip_description"
                                                        title="{$lang.SetupFeeSeparateLineDesc}"></a></b><br/>
                </td>
                <td colspan="3">
                    <input type="checkbox" name="SetupFeeSeparateLine" value="on"
                           {if $configuration.SetupFeeSeparateLine=='on'}checked="checked"{/if} />
                </td>
            </tr>



            <tr class="bordme">
                <td width="205" align="right" valign="middle">
                    <b>{$lang.DocumentFilename}
                        <a class="vtip_description" title="Variables available:
                                <ul>
                                    <li><strong>{ldelim}$business_name{rdelim}</strong> - Business name</li>
                                    <li><strong>{ldelim}$id{rdelim}</strong> - Document Id</li>
                                    <li><strong>{ldelim}$number{rdelim}</strong> - Document Number</li>
                                    <li><strong>{ldelim}$type{rdelim}</strong> - Document type</li>
                                </ul>"></a></b><br/>
                </td>
                <td colspan="3">
                    <input style="width:50%" type="text" name="DocumentFilename"
                           value="{$configuration.DocumentFilename}" class="config_val inp"/>
                </td>
            </tr>
        </table>

        <div style="text-align:center" class="nicerblu">
            <input type="submit" class="btn btn-primary" style="font-weight:bold" value="{$lang.savechanges}">
        </div>
        {securitytoken}
        {if $preview}
            <div class="text-center row" style="margin: 20px 0 0 0;">
                <div class="col-sm-12"
                     style="border-color: #dfdfdf; border-style: solid; border-width: 1px 0; padding: 10px">
                    <h3><strong>Invoice preview</strong></h3>
                </div>
            </div>
            <div class="preview-box" style="padding: 0 30px">
                <div style="margin: 30px auto; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <iframe id="preview" style="width: 100%"
                            frameborder="0" scrolling="no" onload="resizeIframe(this)"></iframe>
                </div>
            </div>
        {/if}
    </form>
{literal}
    <script>
        function resizeIframe(obj) {
            console.log('resize')
            if (obj.contentWindow.document.firstElementChild) {
                console.log('resize to', obj.contentWindow.document.firstElementChild.scrollHeight)
                obj.style.height = Math.max(obj.contentWindow.document.firstElementChild.scrollHeight, 200) + 'px';
                obj.contentWindow.document.close();
            }
        }

        var bordme = $('.bordme td input, .bordme td select'),
            preview = $('#preview'),
            send = {},
            keys = {};

        preview[0].contentWindow.document.write({/literal}{$preview|@json_encode}{literal});

        bordme.each(function (index, val) {
            keys[index] = $(val).attr('name');
        });
        bordme.on('change', function () {
            invoice_preview(this);
        });

        $(function () {
            invoice_preview($('.bordme'));
        });

        function invoice_preview(self) {
            var form = $(self).parents('form:first');
            send = form.serializeArray().reduce(function (obj, item) {
                obj[item.name] = item.value;
                return obj;
            }, {});

            preview.addLoader();
            $.post("?cmd=configuration&action=invoice_preview", {
                config: send,
                keys: keys
            }, function (result) {
                preview.hideLoader();
                    preview.contents().find('html').html(result);
                    resizeIframe(preview[0]);
            })
        }
    </script>
{/literal}
{elseif $action=='estimatetemplates'}
    <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="make" value="saveconfig"/>
        <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable">

            <tr class="bordme">
                <td width="205" align="right" valign="top"><strong>{$lang.EstimateTemplate}</strong></td>
                <td colspan="3">
                    <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0" cellpadding="3">

                        {foreach from=$invtemplates item=tpl}
                            <tr>
                                <td style="border:1px solid #CCCCCC; background: #fff;">
                                    <input class="left" type="radio" name="InvoiceTemplate" value="{$tpl.id}"
                                           {if $configuration.EstimateTemplate==$tpl.id}checked="checked"{/if}
                                           id="seo_{$tpl.id}"/>
                                    <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                                    <div class="left">
                                        <a href="?cmd=configuration&action=estimatetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
                                           class="fs11">Preview</a>
                                        {if $tpl.parent_id=='0'}
                                            <a href="?cmd=configuration&action=estimatetemplates&make=customize&id={$tpl.id}&security_token={$security_token}"
                                               class="fs11 orspace">Customize</a>
                                        {else}
                                            <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}&type=estimate"
                                               class="fs11 orspace">Edit</a>
                                            <a href="?cmd=configuration&action=estimatetemplates&make=delete&id={$tpl.id}&security_token={$security_token}"
                                               class="fs11 editbtn orspace"
                                               onclick="return confirm('Are you sure you wish to remove this template?')">Delete</a>
                                        {/if}
                                    </div>
                                    <div class="clear"></div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            </tr>


        </table>
        <div style="text-align:center" class="nicerblu">
            <input type="submit" class="submitme" style="font-weight:bold" value="{$lang.savechanges}">
        </div>
        {securitytoken}
    </form>
{elseif $action == 'invoice_preview'}
    {if $preview}
        {$preview}
    {/if}
{/if}

