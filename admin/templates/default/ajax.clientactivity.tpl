{if $action=='cactivity'}
    {if $sorterpagination}
        {foreach from=$logs item=log}
            <tr>
                <td>
                    <a href="?cmd=clients&action=show&id={$log.client_id}">{$log.firstname} {$log.lastname}</a> {if $log.parent_id}(Contact){/if}
                </td>
                <td>{$log.date|dateformat:$date_format}</td>
                <td>{$log.description}</td>
                <td>{$log.ip}</td>
                <td>{$log.admin_name}</td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="5">{$lang.nothingtodisplay}</td>
            </tr>
        {/foreach}
    {else}
        <div class="quicklist_logs clientlist" id="client-activity">
            {include file='_common/quicklists_logs.tpl' active='clientactivity' client_id=$client_id}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                <tr>
                    <th width="150">
                        <a href="?cmd=clientactivity&action=cactivity&id={$client_id}"
                           data-orderby="lastname" class="sortorder">{$lang.Client}</a>
                    </th>
                    <th width="150">
                        <a href="?cmd=clientactivity&action=cactivity&id={$client_id}"
                           data-orderby="date" class="sortorder">{$lang.Date}</a>
                    </th>
                    <th>
                        <a href="?cmd=clientactivity&action=cactivity&id={$client_id}"
                           data-orderby="description" class="sortorder">{$lang.Action}</a>
                    </th>
                    <th width="150">
                        <a href="?cmd=clientactivity&action=cactivity&id={$client_id}"
                           data-orderby="ip" class="sortorder">IP</a>
                    </th>
                    <th width="150">
                        <a href="?cmd=clientactivity&action=cactivity&id={$client_id}"
                           data-orderby="admin_name" class="sortorder">Logged staff</a>
                    </th>
                </tr>
                </tbody>
                <tbody id="client-activity-updater">
                {include file="ajax.clientactivity.tpl" sorterpagination=1}
                </tbody>
            </table>

            {include file="_common/quicklists_pagination.tpl" name='activity'
            url="?cmd=clientactivity&action=cactivity&id=`$client_id`"}

        </div>
    {literal}
        <script>
            $(function () {
                $('.pagination[data-name=client-activity]').pagination({
                    sorter_controls: '#client-activity .sortorder',
                });

                $('[data-filter-modal=#clientactivity]').filterModal({
                    name: 'client-activity',
                    sorter_link: '#client-activity-sorter',
                    updater: '#client-activity-updater',
                });
            })
        </script>
    {/literal}

    {/if}
{elseif $action=='getadvanced'}
    <a href="?cmd=clientactivity&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=clientactivity" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{/if}
