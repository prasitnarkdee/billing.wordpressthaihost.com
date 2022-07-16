<form method="POST" action="">
    <input type="hidden" value="{$server|escape}" name="server">
    {if !$zones && !$search}
        <p class="error">
            There are no DNS zones for this server.
        </p>
        <a class="dns-btn" href="?cmd={$modulename}&security_token={$security_token}" >Go Back</a>
    {else}
        <p class="info">Found {$zones_count} zone(s)</p>
        <div class="blu">
            <div class="left">
                <input type="text" name="search" value="{$search}" width="200" placeholder="{$lang.Search}" class="search form-control" style="min-width: 300px;">
            </div>
            <div class="right"><div class="pagination"></div></div>
            <div class="clear"></div>
        </div>
        <a href="?cmd={$modulename|strtolower}&action=showzones&server_id={$server|escape}{if $search}&search={$search}{/if}"
           id="currentlist" style="display:none" updater="#updater"></a>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>
                    <a href="?cmd={$modulename|strtolower}&action=showzones&server_id={$server|escape}&orderby=name|ASC" class="sortorder">Zone(s)</a>
                </th>
                <th class="text-center">
                    <strong>{if isset($lang.AccountId)}{$lang.AccountId}{else}Account Id{/if}</strong>
                </th>
                <th>
                    <strong>{$lang.Client}</strong>
                </th>
            </tr>
            </thead>
            <tbody id="updater">
            {include file='tpl/ajax.show.tpl'}
            </tbody>
        </table>
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages">
        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="clear"></div>
        </div>
        {securitytoken}
    {/if}
</form>

{literal}
<script>
    $(function () {

        var timer = null;
        $('.search').keydown(function(){
            clearTimeout(timer);
            timer = setTimeout(update_records, 1000)
        });

        function update_records() {
            var search = $('.search').val(),
                server = $('input[name=server]').val(),
                page = $('#domains_per_page').val();
            $('#dns-form').addLoader();
            ajax_update("?cmd=dns_zone_editor&action=showzones", {
                server: server,
                search: search,
                dns_per_page: page,
                page: 0,
                nsearch: true
            }, $('#dns-form'), true);
        }

    })
</script>
{/literal}