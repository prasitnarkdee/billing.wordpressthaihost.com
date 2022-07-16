{if $invoices}
    <div class="table-responsive">
        <table class="table" border="0" cellpadding="0" cellspacing="0" width="100%" style="text-align: left">
            <tbody>
            <tr>
                {if $eumethod && $currentlist != 'receiptpaid' && $currentlist != 'receiptunpaid' && $currentlist != 'receiptcanceled' && $currentlist != 'creditnote'}
                    <th>{$lang.proformaid}</th>
                    <th>{$lang.finalid}</th>
                {else}
                    <th>{$lang.invoicehash}</th>
                {/if}
                <th>{$lang.clientname}</th>
                <th>{$lang.invoicedate}</th>
                <th>{$lang.duedate}</th>
                <th>{$lang.Total}</th>
                <th>{$lang.paymethod}</th>
                <th>{$lang.Status}</th>
            </tr>
            {foreach from=$invoices item=invoice}
                <tr>
                    {if $eumethod && $currentlist != 'receiptpaid' && $currentlist != 'receiptunpaid' && $currentlist != 'receiptcanceled' && $currentlist != 'creditnote'}
                        <td>
                            <a href="?cmd=invoices&action=edit&id={$invoice.id}">
                                {$invoice|@invoice_proforma}
                            </a>
                        </td>
                        <td>
                            <a href="?cmd=invoices&action=edit&id={$invoice.id}">
                                {$invoice.paid_id}
                            </a>
                        </td>
                    {else}
                        <td>
                            <a href="?cmd=invoices&action=edit&id={$invoice.id}">
                                {$invoice|@invoice}
                            </a>
                        </td>
                    {/if}
                    <td>
                        {if $invoice.client_id}
                            {$invoice|@profilelink:true:true}
                        {else}
                            <span style="font-style: italic">{$lang.no_clients_attached}</span>
                        {/if}
                    </td>
                    <td>{$invoice.date|dateformat:$date_format}</td>
                    <td>{$invoice.duedate|dateformat:$date_format}</td>
                    <td>{$invoice.grandtotal|price:$invoice.currency_id}</td>
                    <td>
                        {if $invoice.credit>0 && $invoice.credit>=$invoice.subtotal2}
                            {$lang.paidbybalance}
                        {else}
                            {$invoice.module|default:"`$lang.none`"}
                            {if $invoice.credit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}
                        {/if}
                    </td>
                    <td><span class="{$invoice.status}">{if $lang[$invoice.status]}{$lang[$invoice.status]}{else}{$invoice.status}{/if}</span></td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    {literal}
        <script>
            $('#ticketInvoicesBox').show();
        </script>
    {/literal}
{/if}