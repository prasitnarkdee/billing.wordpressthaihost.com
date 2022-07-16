{if $action=='default'}{if $showall}
    <form action="" method="post" id="testform"><input type="hidden" value="{$totalpages}" name="totalpages2"
                                                       id="totalpages"/>
        <div class="blu">
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="left menubar">

            </div>
            <div class="clear"></div>
        </div>

        <a href="?cmd=transactions" id="currentlist" style="display:none"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <tbody>
            <tr>
                <th><a href="?cmd=transactions&orderby=trans_id|ASC" class="sortorder">{$lang.Transactionid}</a></th>
                <th><a href="?cmd=transactions&orderby=lastname|ASC" class="sortorder">{$lang.clientname}</a></th>
                <th><a href="?cmd=transactions&orderby=date|ASC" class="sortorder">{$lang.Date}</a></th>
                <th><a href="?cmd=transactions&orderby=type|ASC" class="sortorder">{$lang.Type}</a></th>
                <th><a href="?cmd=transactions&orderby=status|ASC" class="sortorder">{$lang.status}</a></th>
                <th><a href="?cmd=transactions&orderby=in|ASC" class="sortorder">{$lang.amountin}</a></th>
                <th><a href="?cmd=transactions&orderby=out|ASC" class="sortorder">{$lang.amountout}</a></th>
                <th><a href="?cmd=transactions&orderby=fee|ASC" class="sortorder">{$lang.fees}</a></th>
                <th><a href="?cmd=transactions&orderby=module|ASC" class="sortorder">{$lang.Gateway}</a></th>
                <th width="20">&nbsp;</th>
                <th width="20">&nbsp;</th>
            </tr>
            </tbody>
            <tbody id="updater">{/if}
            {if $transactions}

                {foreach from=$transactions item=transaction}
                    <tr>
                        <td><a href="?cmd=transactions&action=edit&id={$transaction.id}"
                               data-pjax>{$transaction.trans_id}</a></td>
                        <td>{$transaction|@profilelink:true:true}</td>
                        <td>{$transaction.date|dateformat:$date_format}</td>

                        <td>{$transaction.type}</td>
                        <td>
                            <span class="{$transaction.status}">{if $lang[$transaction.status]}{$lang[$transaction.status]}{else}{$transaction.status}{/if}</span>
                        </td>

                        <td>{$transaction.in|price:$transaction.currency_id}</td>
                        <td>{$transaction.out|price:$transaction.currency_id}</td>
                        <td>{$transaction.fee|price:$transaction.currency_id}</td>
                        <td>{$transaction.module}</td>
                        <td><a href="?cmd=transactions&action=edit&id={$transaction.id}"
                               class="editbtn">{$lang.Edit}</a></td>
                        <td>
                            {if !$forbidAccess.deleteTransactions}
                                <a href="?cmd=transactions&make=delete&id={$transaction.id}&security_token={$security_token}"
                                   onclick="return confirm('{$lang.deletetransconfirm}');" class="delbtn">delete</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}

            {else}
                <tr>
                    <td colspan="10"><p align="center">{$lang.Click} <a
                                    href="?cmd=transactions&action=add">{$lang.here}</a> {$lang.notransclick}</p></td>
                </tr>
            {/if}
            {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="10">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> -
                    <span id="sorterhigh">{$sorterhigh}</span> {$lang.of}
                    <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
        </table>
        <div class="blu">
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>

        </div>

        {securitytoken}
    </form>
{/if}
{elseif $action=='edit'}
    {include file='transactions/edit.tpl'}
{elseif $action=='add'}
    {include file='transactions/add.tpl'}
{elseif $action=='clienttransactions'}
    {if $sorterpagination}
        {foreach from=$transactions item=transaction}
            <tr>
                <td><a href="?cmd=transactions&action=edit&id={$transaction.id}">{$transaction.trans_id}</a></td>
                <td>{$transaction.date|dateformat:$date_format}</td>
                <td>{$transaction.type}</td>
                <td>
                    <span class="{$transaction.status}">
                        {if $lang[$transaction.status]}{$lang[$transaction.status]}
                        {else}{$transaction.status}{/if}
                    </span>
                </td>
                <td>{$transaction.in|price:$transaction.currency_id}</td>
                <td>{$transaction.out|price:$transaction.currency_id}</td>
                <td>{$transaction.fee|price:$transaction.currency_id}</td>
                <td>{$transaction.module}</td>
                <td><a href="?cmd=transactions&action=edit&id={$transaction.id}" class="editbtn">{$lang.Edit}</a></td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="9"><strong>{$lang.nothingtodisplay}</strong></td>
            </tr>
        {/foreach}
    {else}
        <div id="client-transactions">
            <div class="blu clearfix">
                {if !$ajax}
                    <div class="blu">
                        <h1>
                            <a href="?cmd=clients&action=show&id={$client.id}">
                                #{$client.id} - {$client|@client}</a> - {$lang.Transactions}
                        </h1>
                    </div>
                {/if}
                <div class="pull-right">
                    {include file='ajax.filterquicktool.tpl' client_id=$client_id
                    loadid='transactions' href="?cmd=transactions&action=getadvanced"}
                    <a href="?cmd=transactions&action=add&related_client_id={$client_id}"
                       class="btn btn-primary  btn-xs" target="_blank"><i class="fa fa-plus"></i> {$lang.newtransaction}
                    </a>
                </div>
                <div class="left">
                    <strong>{$lang.amountin}:</strong> {$stats.in|price:$currency}
                    <strong style="margin-left:10px">{$lang.amountout}:</strong> {$stats.out|price:$currency}
                    <strong style="margin-left:10px">{$lang.fees}:</strong> {$stats.fee|price:$currency}
                </div>
                <div class="clear"></div>
            </div>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                <tr>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="trans_id">{$lang.Transactionid}</a></th>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="date">{$lang.Date}</a></th>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="type">{$lang.Type}</a></th>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="status">{$lang.status}</a></th>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="in">{$lang.amountin}</a></th>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="out">{$lang.amountout}</a></th>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="fees">{$lang.fees}</a></th>
                    <th><a href="?cmd=transactions&action=clienttransactions&id={$client_id}" class="sortorder"
                           data-orderby="module">{$lang.Gateway}</a></th>
                    <th width="20">&nbsp;</th>
                </tr>
                </tbody>
                <tbody id="client-transactions-updater">
                    {include file="ajax.transactions.tpl" sorterpagination=1}
                </tbody>
            </table>
            {include file="_common/quicklists_pagination.tpl" name='transactions'
                url="?cmd=transactions&action=clienttransactions&id=`$client_id`"}
        </div>
        {literal}
            <script>
                $(function () {
                    $('.pagination[data-name=client-transactions]').pagination({
                        sorter_controls: '#client-transactions .sortorder',
                    });

                    $('[data-filter-modal=#transactions]').filterModal({
                        name: 'client-transactions',
                        sorter_link: '#client-transactions-sorter',
                        updater: '#client-transactions-updater',
                    });
                })
            </script>
        {/literal}
    {/if}
{elseif $action=='getadvanced'}
    <a href="?cmd=transactions&resetfilter=1" {if $currentfilter}style="display:inline"{/if}
       class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=transactions" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}</form>
    <script type="text/javascript">bindFreseter();</script>
{/if}