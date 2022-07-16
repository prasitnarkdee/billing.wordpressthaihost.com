<div id="dns-form">
    {include file='tpl/ajax.form.tpl'}
</div>

<br>
<div class="row">
    <form action="?cmd={$modulename}&action=addzone" method="post" class="form-horizontal">
        <div class="form-group">
            <input type='hidden' name="server_id" value="{$server_id}" class="form-control" readonly>
            <input type='hidden' name="zone_id" value="{$zone_id}" class="form-control" readonly>
            <div class="col-sm-1" style="margin-left: 20px;">
                <button type="submit" value="true" class="btn btn-success">{if isset($lang.adddomain)}{$lang.adddomain}{else}Add domain{/if}</button>
            </div>
            <div class="col-sm-2" style="margin-left: 20px;">
                <a class="btn btn-info" href="?cmd={$modulename}&security_token={$security_token}&refresh=1&action=showzones&server_id={$server_id}" >Refresh listing</a>
                <a class="btn btn-default" href="?cmd={$modulename}" >Go Back</a>
            </div>
        </div>
        {securitytoken}
    </form>
</div>