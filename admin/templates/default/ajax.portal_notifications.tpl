{if $action=='clientnotifications'}
    {if $sorterpagination}
        {foreach from=$notifications item=item}
            <tr>
                <td><a href="?cmd=portal_notifications&action=show&id={$item.id}">{$item.subject}</a></td>
                <td>
                    <a href="?cmd=clients&action=show&id={$item.client_id}">#{$item.client_id} {$item.firstname} {$item.lastname}</a>
                </td>
                <td>
                    {$item.rel_type|capitalize}
                </td>
                <td>
                    {if $item.url}
                        <a href="{$item.url}">#{$item.rel_id}</a>
                    {elseif $item.rel_type && $item.rel_id} {$item.rel_id}
                    {else} -
                    {/if}
                </td>
                <td>
                    {$item.type|capitalize}
                </td>
                <td>{$item.date_added|dateformat:$date_format}</td>
                <td>{if $item.seen}
                        <span class="Successfull">Yes</span>
                        ({$item.date_seen|dateformat:$date_format}){else}
                        <span class="Failure">No</span>
                    {/if}</td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="7">{$lang.nothingtodisplay}</td>
            </tr>
        {/foreach}
    {else}
        <div class="quicklist_logs clientlist" id="client-notifications">
            {include file='_common/quicklists_logs.tpl' active='portal_notifications' client_id=$client_id}

            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                <tr>
                    <th>
                        <a href="?cmd={$cmd}&action={$action}&id={$client_id}"
                           data-orderby="subject" class="sortorder">{$lang.Subject}</a>
                    </th>
                    <th>
                        <a href="?cmd={$cmd}&action={$action}&id={$client_id}"
                           data-orderby="client_id" class="sortorder">Sended to</a>
                    </th>
                    <th width="170">
                        <a href="?cmd={$cmd}&action={$action}&id={$client_id}"
                                data-orderby="rel_type" class="sortorder">Relation Type</a>
                    </th>
                    <th width="170">
                        <a href="?cmd={$cmd}&action={$action}&id={$client_id}"
                                data-orderby="rel_id" class="sortorder">Relation Item</a>
                    </th>
                    <th>
                        <a href="?cmd={$cmd}&action={$action}&id={$client_id}"
                           data-orderby="type" class="sortorder">Type</a>
                    </th>
                    <th width="170">
                        <a href="?cmd={$cmd}&action={$action}&id={$client_id}"
                                data-orderby="date_added" class="sortorder">{$lang.Date}</a>
                    </th>
                    <th width="170">
                        <a href="?cmd={$cmd}&action={$action}&id={$client_id}"
                                data-orderby="seen" class="sortorder">Seen</a>
                    </th>
                </tr>
                </tbody>
                <tbody id="client-notifications-updater">
                    {include file="ajax.portal_notifications.tpl" sorterpagination=1}
                </tbody>
            </table>
            {include file="_common/quicklists_pagination.tpl" name='notifications'
                url="?cmd=portal_notifications&action=clientnotifications&id=`$client_id`"}

            <script>
                {literal}
                $(function () {
                    $('.pagination[data-name=client-notifications]').pagination({
                        sorter_controls: '#client-notifications .sortorder',
                    });

                    $('[data-filter-modal="#portal_notifications"]').filterModal({
                        name: 'client-notifications',
                        sorter_link: '#client-notifications-sorter',
                        updater: '#client-notifications-updater',
                    });
                });
                {/literal}
            </script>
        </div>
    {/if}
{elseif $action=='getadvanced'}
    <a href="?cmd=portal_notifications&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=portal_notifications" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{elseif $action=='show'}
    <table class="table" style="table-layout: fixed;">
        <tr>
            <td width="10%"><b>To</b></td>
            <td><a href="?cmd=clients&action=show&id={$notification.client_id}">#{$notification.client_id} {$notification.firstname} {$notification.lastname}</a></td>
        </tr>
        <tr>
            <td width="10%"><b>Date created</b></td>
            <td>{$notification.date_added|dateformat:$date_format}</td>
        </tr>
        <tr>
            <td width="10%"><b>{$lang.reltype}</b></td>
            <td>
                {if $notification.rel_type}
                    {if $lang[$notification.rel_type]}{$lang[$notification.rel_type]}
                    {else}{$notification.rel_type}
                    {/if}
                {else}
                    -
                {/if}
            </td>
        </tr>
        <tr>
            <td width="10%"><b>{$lang.relid}</b></td>
            <td>
                {if $notification.url} <a href="{$notification.url}">#{$notification.rel_id}</a>
                {elseif $notification.rel_type && $notification.rel_id} {$notification.rel_id}
                {else} -
                {/if}
            </td>
        </tr>
        <tr>
            <td width="10%"><b>{$lang.Subject}</b></td>
            <td>{$notification.subject}</td>
        </tr>
        <tr>
            <td width="10%"><b>Seen</b></td>
            <td>{if $notification.seen} <span style="color: green;">Yes</span> ({$notification.date_seen|dateformat:$date_format}) {else}No{/if}</td>
        </tr>
        <tr>
            <td width="10%"><b>Body</b></td>
            <td>{if $notification.body} {$notification.body} {else} - {/if}</td>
        </tr>
    </table>
{elseif $action=='default'}
    {if $notifications}
        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right"><div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=portal_notifications" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover" style="table-layout: fixed;">
            <tbody>
                <tr>
                    <th><a href="?cmd=portal_notifications&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                    <th><a href="?cmd=portal_notifications&orderby=client_id|ASC"  class="sortorder">Sended to</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=rel_type|ASC"  class="sortorder">Relation Type</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=rel_id|ASC"  class="sortorder">Relation Item</a></th>
                    <th><a href="?cmd=portal_notifications&orderby=type|ASC"  class="sortorder">Type</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=date_added|ASC"  class="sortorder">{$lang.Date}</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=seen|ASC"  class="sortorder">Seen</a></th>
                </tr>
            </tbody>
            <tbody id="updater">
        {/if}
        {foreach from=$notifications item=item}
            <tr>
                <td><a href="?cmd=portal_notifications&action=show&id={$item.id}">{$item.subject}</a></td>
                <td><a href="?cmd=clients&action=show&id={$item.client_id}">#{$item.client_id} {$item.firstname} {$item.lastname}</a></td>
                <td>
                    {$item.rel_type|capitalize}
                </td>
                <td>
                    {if $item.url} <a href="{$item.url}">#{$item.rel_id}</a>
                    {elseif $item.rel_type && $item.rel_id} {$item.rel_id}
                    {else} -
                    {/if}
                </td>
                <td>
                    {$item.type|capitalize}
                </td>
                <td>{$item.date_added|dateformat:$date_format}</td>
                <td>{if $item.seen}<span class="Successfull">Yes</span> ({$item.date_seen|dateformat:$date_format}){else}<span class="Failure">No</span>{/if}</td>
            </tr>
        {/foreach}
        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="7">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">
                <div class="right"><div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}</form>
        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="5"><p align="center" >{$lang.nothingtodisplay}</p></td>
            </tr>
        {/if}
    {/if}
{/if}
