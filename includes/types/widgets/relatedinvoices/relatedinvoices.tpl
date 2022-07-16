<div class="wbox">
    <div class="wbox_header">
        {$lang.invoices}
    </div>
    <div class="wbox_content">
        {if $relinvoices}
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>{$lang.invoicenum}</th>
                            <th>{$lang.status}</th>
                            <th>{$lang.total}</th>
                            <th>{$lang.invoicedate}</th>
                            <th class="noncrucial">{$lang.duedate}</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach from=$relinvoices item=invoice}
                        <tr>
                            <td  class="inline-row">
                                <a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank">
                                    #{$invoice|@invoice}
                                </a>
                            </td>
                            <td  class="inline-row-right">
                                <span class="badge badge-{$invoice.status}">{$lang[$invoice.status]}</span>
                            </td>
                            <td data-label="{$lang.total}: ">{$invoice.total|price:$invoice.currency_id}</td>
                            <td data-label="{$lang.invoicedate}: ">{$invoice.date|dateformat:$date_format}</td>
                            <td  class="noncrucial">
                                {$invoice.duedate|dateformat:$date_format}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        {else}
            <section class="py-4 text-center text-muted m-10">
                {$lang.nothing}
            </section>
        {/if}
    </div>
</div>