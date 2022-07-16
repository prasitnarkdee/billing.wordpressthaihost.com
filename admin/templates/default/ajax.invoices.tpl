{if $action=='default'}
    {if $showall}
        <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                {include file='invoices/list_actions.tpl'}
                <div id="new_invoice" style="padding: 10px; display: none"></div>
            </div>

            <a href="?cmd=invoices&list={$currentlist}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"/></th>
                        {if $currentlist!='recurring'}
                            {if $eumethod && $currentlist != 'receiptpaid' && $currentlist != 'receiptunpaid' && $currentlist != 'receiptcanceled' && $currentlist != 'creditnote'}
                                <th><a href="?cmd=invoices&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.proformaid}</a></th>
                                <th><a href="?cmd=invoices&list={$currentlist}&orderby=paid_id|ASC" class="sortorder">{$lang.finalid}</a></th>
                            {elseif $eumethod && ($currentlist == 'receiptpaid' || $currentlist == 'receiptunpaid' || $currentlist == 'receiptcanceled' || $currentlist == 'creditnote')}
                                <th><a href="?cmd=invoices&list={$currentlist}&orderby=paid_id|ASC" class="sortorder">{$lang.documenthash}</a></th>
                            {else}
                                <th><a href="?cmd=invoices&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.invoicehash}</a></th>
                            {/if}
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=date|ASC"  class="sortorder">{$lang.invoicedate}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=duedate|ASC"  class="sortorder">{$lang.duedate}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                            <th width="20">&nbsp;</th>
                        {else}
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=recurring_id|ASC" class="sortorder">{$lang.recurringid}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=start_date|ASC"  class="sortorder">{$lang.start_date}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=next_invoice|ASC"  class="sortorder">{$lang.next_invoice_date}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                            <th><a href="?cmd=invoices&list={$currentlist}&orderby=frequency|ASC"  class="sortorder">{$lang.frequency}</a></th>
                            {/if}
                        <th width="20">&nbsp;</th>
                        <th width="20">&nbsp;</th>
                    </tr>
                </tbody>
                <tbody id="updater">
                    {include file='invoices/list.tpl'}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th></th>
                        <th colspan="11">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        </th>
                    </tr>
                </tbody>
            </table>
            <div class="blu">
                {include file='invoices/list_actions.tpl' type='bottom'}
            </div>
            {securitytoken}
        </form>
    {else}
        {include file='invoices/list.tpl'}
    {/if}
    {if $ajax}
        {if $showall}<script type="text/javascript">bindEvents();</script>{/if}
        <script type="text/javascript">bindInvoiceEvents();</script>
    {/if}

{elseif $action=='getclients'}
    {if $clients} 
        <strong class="clientmsg">{$lang.Client}:</strong><select name="invoice[client_id]" onchange="$('#client_id').val($(this).val());" >
            <option value="0">{$lang.selectcustomer}</option>
            {foreach from=$clients item=cl}
                <option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
            {/foreach}
        </select>
    {else}
        {$lang.thereisnoclients}. {$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregisternew}.
    {/if}

{elseif $action=='clientinvoices'}
{if $sorterpagination}
    {foreach from=$invoices item=invoice}
        <tr data-flags="{$invoice.flags}">
            <td><input type="checkbox" class="check" value="{$invoice.id}" name="selected[]"></td>
            {if $currentlist!='Recurring'}
                {if $eumethod}
                    <td>
                        <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}">
                            {$invoice|@invoice_proforma}
                        </a>
                    </td>
                    <td>
                        <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}">
                            {$invoice.paid_id}
                        </a>
                    </td>
                {else}
                    <td>
                        <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}">
                            {$invoice|@invoice}
                        </a>
                    </td>
                {/if}
                <td>{$invoice.date|dateformat:$date_format}</td>
                <td>{$invoice.duedate|dateformat:$date_format}</td>
                <td>{$invoice.paybefore|dateformat:$date_format}</td>
                <td>{$invoice.grandtotal|price:$invoice.currency_id}</td>
                <td>
                    {if $invoice.credit>0 && $invoice.credit>=$invoice.subtotal2}
                        {$lang.paidbybalance}
                    {else}
                        {$invoice.module|default:"`$lang.none`"}
                        {if $invoice.credit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}
                    {/if}
                </td>
                <td>
                    <span class="{$invoice.status}">
                        {if $lang[$invoice.status]}{$lang[$invoice.status]}
                        {else}{$invoice.status}{/if}
                    </span>
                </td>
            {else}
                <td><a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" class="tload2"
                       rel="{$invoice.id}">{$invoice.recurring_id}</a></td>
                <td>{$invoice.total|price:$invoice.currency_id}</td>
                <td>{$invoice.start_from|dateformat:$date_format}</td>
                <td>{if $invoice.recstatus!='Stopped' &&  $invoice.next_invoice!='' && $invoice.next_invoice!='0000-00-00' && ($invoice.invoices_left || !$invoice.occurrences)}{$invoice.next_invoice|dateformat:$date_format} ({if $invoice.invoices_left && $invoice.occurrences}{$invoice.invoices_left}{else}&#8734;{/if} {$lang.remaining}){else}-{/if}</td>
                <td>{$invoice.module}</td>
                <td>{$lang[$invoice.frequency]}</td>
            {/if}
            <td>
                <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" class="editbtn"
                   rel="{$invoice.id}">{$lang.Edit}</a>
            </td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="10"> {$lang.nothingtodisplay}</td>
        </tr>
    {/foreach}

{else}
    <div id="client-invoices">
        <div class="blu clearfix">
            {if !$ajax}
                <div class="blu">
                    <h1>
                        <a href="?cmd=clients&action=show&id={$client.id}">
                            #{$client.id} - {$client|@client}</a> - {$lang.Invoices}
                    </h1>
                </div>
            {/if}
            <div class="pull-right">
                {include file='ajax.filterquicktool.tpl' client_id=$client_id
                    loadid='invoicesfilter' href="?cmd=invoices&action=getadvanced"}

                {if $currentlist != 'Recurring' && "config:CnoteEnable:on"|checkcondition}
                    <a href="?cmd=invoices&security_token={$security_token}&action=createcreditnote&client_id={$client_id}"
                       class="btn btn-primary btn-xs" target="_blank"><i
                                class="fa fa-plus"></i> {$lang.createcreditnote}</a>
                {/if}

                <a href="?cmd=invoices&security_token={$security_token}&action=createinvoice&client_id={$client_id}"
                   class="btn btn-primary btn-xs" target="_blank"><i class="fa fa-plus"></i> {$lang.newinvoice}</a>
            </div>

            {if $currentlist != 'Recurring'}
                <div class="left">
                    {foreach from=$clientstats item=s}
                        <strong style="margin-left:10px">{$lang[$s.status]}: </strong>
                        {$s.total|price:$currency}
                    {/foreach}
                </div>
            {/if}
            <div class="clear"></div>
        </div>

        <form method="post" action="?cmd=invoices" id="form_invoices">
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                <tr>
                    <th width="20"><input type="checkbox" id="checkall"></th>
                    {if $currentlist!='Recurring'}
                        {if $eumethod}
                            <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                                   class="sortorder" data-orderby="id">{$lang.proformaid}</a>
                            </th>
                            <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                                   class="sortorder" data-orderby="paid_id">{$lang.finalid}</a>
                            </th>
                        {else}
                            <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                                   class="sortorder" data-orderby="id">{$lang.invoicehash}</a>
                            </th>
                        {/if}
                        <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="date">{$lang.invoicedate}</th>
                        <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="duedate">{$lang.duedate}</th>
                        <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="paybefore">Pay Before</th>
                        <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="total">{$lang.Total}</th>
                        <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="module">{$lang.paymethod}</th>
                        <th><a href="?cmd=invoices&list={$currentlist}&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="status">{$lang.Status}</th>
                    {else}
                        <th><a href="?cmd=invoices&currentlist=recurring&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="recurring_id">{$lang.recurringid}</th>
                        <th><a href="?cmd=invoices&currentlist=recurring&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="total">{$lang.Total}</th>
                        <th><a href="?cmd=invoices&currentlist=recurring&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="start_date">{$lang.start_date}</th>
                        <th><a href="?cmd=invoices&currentlist=recurring&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="next_invoice">{$lang.next_invoice_date}</th>
                        <th><a href="?cmd=invoices&currentlist=recurring&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="module">{$lang.paymethod}</th>
                        <th><a href="?cmd=invoices&currentlist=recurring&action=clientinvoices&id={$client_id}"
                               class="sortorder" data-orderby="frequency">{$lang.frequency}</th>
                    {/if}
                    <th width="20">&nbsp;</th>
                </tr>
                </tbody>
                <tbody id="client-invoices-updater">
                    {include file="ajax.invoices.tpl" sorterpagination=1}
                </tbody>
            </table>
        </form>

        <div class="row" style="margin-top: 10px;margin-bottom: 10px">
            <div class="col-sm-12">
                <div class="text-left">
                    <form action="" method="post" class="pull-left invoice_methods" style="">
                        {$lang.withselected}
                        {if $currentlist != 'Recurring'}
                        <a class="submiter menuitm menu-auto" name="markpaid" {if $enablequeue}queue='push'{/if}
                           href="#"><span>{$lang.markaspaid}</span></a>
                        <a class="submiter menuitm menu-auto" name="markunpaid"
                           href="#"><span>{$lang.markasunpaid}</span></a>
                        {/if}
                        {if !$forbidAccess.deleteInvoices}
                            <a class="submiter menuitm confirm menu-auto " name="delete" href="#">
                                <span style="color:#FF0000">{$lang.Delete}</span></a>
                        {/if}

                        <input type="hidden" name="id" value="{$client_id}"/>
                        <input type="hidden" name="action" value="clientinvoices"/>
                        <input type="hidden" name="cmd" value="invoices"/>
                        {securitytoken}
                    </form>
                </div>
                {include file="_common/quicklists_pagination.tpl" name='invoices'
                url="?cmd=invoices&action=clientinvoices&id=`$client_id`&currentlist=`$currentlist`"}
            </div>
        </div>
    </div>
    {literal}
            <script>
                $(function(){
                    $('.pagination[data-name=client-invoices]').pagination({
                        sorter_controls: '#client-invoices .sortorder',
                        after_submit: bind_checks
                    });

                    $('[data-filter-modal=#invoicesfilter]').filterModal({
                        name: 'client-invoices',
                        sorter_link: '#client-invoices-sorter',
                        updater: '#client-invoices-updater',
                        after_submit: bind_checks
                    });

                    function bind_checks(){
                        var check_order = $('#client-invoices .check');
                        $('#client-invoices #checkall').off('change').on('change', function () {
                            check_order.prop('checked', this.checked);
                            check_order.closest('tr').toggleClass('checkedRow', this.checked);
                        });
                        check_order.on('change', function () {
                            $(this).closest('tr').toggleClass('checkedRow', this.checked);
                        });
                    }

                    bind_checks();

                    $('#client-invoices .submiter').off('click').on('click', function () {
                        update_invoice(this);
                    });
                })

                function update_invoice(button, params) {
                    button = $(button);

                    var form = $('#form_invoices').serializeForm();

                    if (button.hasClass('confirm')) {
                        var conf = confirm({/literal}'{$lang.perform_action}'{literal});
                        if (conf === false) {
                            return false;
                        }
                    }

                    $('#client-invoices-updater').addLoader();
                    form = $.extend(form, {
                        layer: 'ajax',
                        stack: button.attr('queue') ? 'push' : '',
                    }, $.isPlainObject(params) ? params : {})

                    $.post('?cmd=invoices&' + button.attr('name'), form, function (data) {
                        parse_response(data);
                        $('.pagination[data-name=client-invoices]').pagination('reload');
                    });

                    return false;
                }

            </script>
{/literal}

{/if}
{elseif $action=='edit' || $action=='edit_preview' || $action=='viewlog' || $action=='convertdraft'}
    {if $invoice.status=='Draft'}
        {include file="invoices/draft.tpl"}
    {else}
        {include file="invoices/invoice.tpl"}
    {/if}

{elseif $action=='addline' || $action=='removeline'}
    {include file="invoices/items.tpl"}

{elseif $action=='updatetotals'}
    <tbody id="main-invoice">
        {include file="invoices/items.tpl"}
    </tbody>
    <tbody id="updatetotals">
        <tr>
            <td class="summary aright"  colspan="2"><strong>{$lang.Subtotal}</strong></td>
            <td class="summary aright" colspan="2"><strong>{$invoice.subtotal|price:$currency}</strong></td>			<td class="summary"  width="2%"></td>
        </tr>
        {if $invoice.status!='Creditnote' && $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}<tr>
                <td class="summary aright"  colspan="2"><strong>{$lang.Credit}</strong></td>
                <td class="summary aright" colspan="2"><strong>{$invoice.credit|price:$currency}</strong></td>	<td class="summary"></td>
            </tr>
        {/if}
        {if $invoice.taxrate!=0}
            <tr>
                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$invoice.taxrate}%)</strong></td>
                <td class="summary aright" colspan="2"><strong>{$invoice.tax|price:$currency}</strong></td>	<td class="summary"></td>
            </tr>
        {/if}
        {if $invoice.taxrate2!=0}
            <tr>
                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$invoice.taxrate2}%)</strong></td>
                <td class="summary aright" colspan="2"><strong>{$invoice.tax2|price:$currency}</strong></td><td class="summary"></td>
            </tr>
        {/if}
        <tr>
            <td class="summary aright"  colspan="2"><strong class="bigger">{$lang.Total}</strong> {if ($invoice.tax!=0 || $invoice.tax2!=0) && $invoice.taxexempt}<a href="#" class="vtip_description" title="Tax exemption is enabled for this invoice"></a>{/if}</td>
            <td class="summary aright" colspan="2"><strong class="bigger">{$invoice.total|price:$currency}</strong></td>	<td class="summary"></td>
        </tr>
    </tbody>

{elseif $action=='getproduct'}
    <input type="hidden" name="nline_type" value="Other">
    <div class="newline-products">
        <select id="product_id">
            <option selected="selected" >-</option>
            {foreach from=$products item=category}
                {if $category.products}
                    <optgroup label="{$category.name}">
                        {foreach from=$category.products item=prod}
                            <option value="{$prod.id}" data-price="{$prod.price|price:$currency:false}">{$prod.name}</option>
                        {/foreach}
                    </optgroup>
                {/if}
            {/foreach}
        </select>
    </div>
    {literal}
        <script type="text/javascript">
            $('#product_id').chosenedge({width: '100%'});
        </script>
    {/literal}
{elseif $action=='getblank'}

    description: <input name="newline_name" id="newline"/>
    <input type="button" value="OK" class="prodok"/>
    <input type="button" value="{$lang.Cancel}" id="prodcanc"/>
    {if $ajax}
        <script type="text/javascript">bindInvoiceDetForm();</script>
    {/if}

{elseif $action=='getaddon'}
    {if $addons}
        <select name="addon" id="addon_id">{foreach from=$addons item=addon}<option value="{$addon.id}">{$addon.name}</option>{/foreach}</select>
        <input type="button" value="OK" class="prodok"/>
    {/if}
    <input type="button" value="{$lang.Cancel}" id="prodcanc"/>
    {if $ajax}
        <script type="text/javascript">bindInvoiceDetForm();</script>
    {/if}

{elseif $action=='addline'}
    {if $newline}
        <tr id="line_{$newline.id}">
            <td><input type="checkbox" name="invoice_item_id[]" value="{$newline.id}" class="invitem_checker"/></td>
            <td class="editor-line">
                <span class="line_descr">{$newline.description|nl2br}</span>
                <a class="editbtn" style="display:none;" href="#">{$lang.Edit}</a>
                <div style="display:none" class="editor-line">
                    <textarea name="item[{$newline.id}][description]">{$newline.description}</textarea>
                    <a class="savebtn" href="#" >{$lang.savechanges}</a>
                </div>
            </td>
            <td class="acenter">
                <input name="item[{$newline.id}][qty]" value="{$newline.qty}" 
                       size="7" class="foc invitem  invqty" style="text-align:center"/>
            </td>
            <td class="acenter">
                <input type="checkbox" name="item[{$newline.id}][taxed]" 
                       {if $newline.taxed == 1}checked="checked" {/if}value="1" class="invitem2"/>
            </td>
            <td class="acenter">
                <input name="item[{$newline.id}][amount]" value="{$newline.amount}" 
                       size="13" class="foc invitem invamount" style="text-align:right"/>
            </td>
            <td class="aright">
                {$currency.sign} 
                <span id="ltotal_{$newline.id}">{$newline.linetotal|string_format:"%.2f"}</span> 
                {if $currency.code}{$currency.code}
                {else}{$currency.iso}
                {/if}
            </td>
            <td class="acenter">
                <a href="?cmd=invoices&action=removeline&id={$invoiceid}&line={$newline.id}" 
                   class="removeLine"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/>
                </a>
                {if $ajax}
                    <script type="text/javascript">
                        bindInvoiceDetForm();
                        invoiceItemsSubmit()
                    </script>
                {/if}
            </td>
        </tr>
    {/if}

{elseif $action=='getadvanced'}

    <a href="?cmd=invoices&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=invoices" method="post" onsubmit="return filter(this)">  
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">
        bindFreseter();
    </script>
{elseif $action == 'log'}
    {if $sorterpagination}
        {foreach from=$logs item=log}
            <tr>
                <td>{$log.created_at|dateformat:$date_format}</td>
                <td>{$log.who}</td>
                <td>{$log.invoice.duedate|dateformat:$date_format}</td>
                <td>{$log.invoice.total|price:$log.invoice.currency_id}</td>
                <td>
                    <span class="{$log.invoice.status}">{$lang[$log.invoice.status]}</span>
                </td>
                <td>
                    {if $log.invoice_changes}
                        <div id="invoice-log-{$log.id}" hidden>
                                <pre style="white-space: pre-line">
                                    {foreach from=$log.invoice_changes item=change}
                                        {$lang[$change.name]|default:$change.name}: {$change.from} => {$change.to}
                                    {/foreach}
                                </pre>
                        </div>
                        <a href="#invoice-log-{$log.id}" class="editbtn show-change-list">
                            Show Changes
                        </a>
                        <br/>
                    {/if}
                    {if $log.invoice.status != 'Draft'}
                        <a href="?cmd=invoices&action=viewlog&id={$log.id}" class="editbtn">
                            View this version
                        </a>
                    {/if}
                </td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="6">
                    Nothing to display yet.
                </td>
            </tr>
        {/foreach}
    {else}

        {if !$ajax}
            <div class="blu">
                <h1>
                    <a href="?cmd=invoices&action=edit&id=309103{$details.id}">
                        {$lang.Invoice} #{$invoice|@invoice}</a> - Logs
                </h1>
            </div>
        {/if}

        {if $whence}
            <div class="lighterblue fs11 pull-left" style="{if !$ajax}padding: 10px{else}padding: 10px 0{/if};">
                {$lang.document_origin}: {$lang[$whence.message]}{if $whence.info}:{/if}
                {if $whence.url}
                    <a href="{$whence.url}" target="_blank">
                        {$whence.info}
                    </a>
                {else}
                    {if $whence.info}{$whence.info}{/if}
                {/if}
            </div>
        {/if}
        <div class="client-pagination-form form-inline text-right">
            <div class="form-group">
                <div class="pagination pull-right" data-profile="clientlist"
                     data-total-pages="{$totalpages}"
                     data-name="invoice-logs"
                     data-updater="#invoice-logs-updater"
                     data-url="?cmd=invoices&action=log&id={$invoice.id}">
                </div>
            </div>
        </div>
        <table class="glike hover" style="width: 100%;" cellspacing="0" cellpadding="3">
            <thead>
            <tr>
                <th style="width: 130px">{$lang.Date}</th>
                <th>Login</th>
                <th>{$lang.duedate}</th>
                <th>{$lang.Total}</th>
                <th>
                    {$lang.status}
                </th>
                <th style="width: 130px"></th>
            </tr>
            </thead>
            <tbody id="invoice-logs-updater">
                {include file="ajax.invoices.tpl" sorterpagination=1}
            </tbody>
        </table>
        <div class="client-pagination-form form-inline text-right">
            <div class="form-group">
                <div class="pagination pull-right" data-profile="clientlist"
                     data-total-pages="{$totalpages}"
                     data-name="invoice-logs"
                     data-updater="#invoice-logs-updater"
                     data-url="?cmd=invoices&action=log&id={$invoice.id}">
                </div>
            </div>
        </div>
    {literal}
        <script>
            $(function () {
                $('.pagination[data-name=invoice-logs]').pagination();
            })
        </script>
    {/literal}
    {/if}
{elseif $action == 'merge' || $action == 'bulk_payment'}
    <input id="bpinvoice_id" type="hidden" value="{$bpinvoice_id}" data-id="{$bpinvoice_id}">
    <div>
        {if $action == 'bulk_payment'}
            Select other invoices of this customer to generate bulk payment invoice.
        {else}
            Select other invoices of this customer to merge them into current one.
            Items from selected invoices will be added to this invoice, and selected invoices will be removed.
        {/if}
        <br>
        <br>
    </div>
    {literal}
        <script>
            $('.invtable .checkAll').change(function() {
                var tr = $(this).is(':checked');
                $('.invtable .check').prop('checked', tr).parent().parent().toggleClass('checkedRow', tr);
            });
            $('.invtable .check').change(function () {
                var tr = $(this).is(':checked');
                $('.invtable .checkall').prop('checked', false);
                $(this).prop('checked', tr).parent().parent().toggleClass('checkedRow', tr);
            });
            $(".mergeselected").chosenedge({
                allow_single_deselect: true,
                width: '100%'
            });
        </script>
    {/literal}
    <select name="{if $action == 'bulk_payment'}bulkselected[]{else}mergeselected[]{/if}" multiple class="form-control mergeselected" style="width: 100%">
        {foreach from=$invoices item=invoice}
            <option value="{$invoice.id}">
                #{$invoice|@invoice}
                 -
                {$invoice.date|dateformat:$date_format}
                 -
                {$invoice.subtotal2|price:$invoice.currency_id}
            </option>
        {/foreach}
    </select>
{else}
    {if $drawdetails}
        {if $invoice.status=='Draft'}
            {include file='invoices/draft_details.tpl'}
        {else}
            {include file='invoices/invoice_details.tpl'}
        {/if} 
    {/if} 
{/if} 
