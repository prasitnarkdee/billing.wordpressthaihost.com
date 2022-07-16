<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3><b>My Multi-factor Auth</b></h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {include file='configuration/leftmenu.tpl'}
            <a href="?cmd=mfa" class="tstyled selected">Multi-factor Auth</a>
        </td>
        <td valign="top" class="bordered">
            <div class="box box-primary no-padding">
                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            <li>
                                <a href="?action=myaccount"><span>My account</span></a>
                            </li>
                            <li class="active">
                                <a href="?cmd=mfa"><span>Multi-factor auth</span></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="box-body">
                    <div id="bodycont">
                        <div class="panel" style="margin-bottom: 0;">
                            <div class="panel-body">
                                {if $modulesetup_id && ($action === 'setup' || $action === 'enable' || $action === 'manage')}
                                    {include file=$formtpl}
                                {elseif $action === 'disable'}
                                    <form action="?cmd=mfa&action=disable" method="POST">
                                        {securitytoken}
                                        <div class="panel panel-default">
                                            <div class="panel-heading">Deactivate MFA</div>
                                            <div class="panel-body">
                                                <div class="alert alert-info">Enter your account password before
                                                    disabling Multi-factor authentication
                                                </div>
                                                <input type="password" id="password" name="password" autocomplete="current-password" class="form-control" placeholder="{$lang.password}" required>
                                            </div>
                                            <div class="panel-footer">
                                                <button type="submit" name="make" value="submit" class="btn btn-primary">Submit</button>
                                            </div>
                                        </div>
                                    </form>
                                {elseif $action === 'default'}
                                    {if $isenabled && (!$moduleactivated || !$moduleactivated.active)}
                                        <div class="alert alert-warning" role="alert">
                                            Multi-factor authentication is  configured incorrectly. <br>
                                            It will not work properly because the configured MFA module is not activated.<br>
                                            Module: <b>{if $moduleactivated}{$moduleactivated.modname}{else}Unknown{/if}</b>
                                            <br>
                                            <a href="?cmd=mfa&action=disable" class="btn btn-danger btn-sm">Deactivate MFA</a>
                                        </div>

                                    {elseif $isenabled}
                                        <div class="alert alert-success" role="alert">
                                            Multi-factor authentication is configured successfully.
                                            Module: <b>{if $moduleactivated}{$moduleactivated.modname}{else}Unknown{/if}</b>
                                        </div>
                                    {else}
                                        <div class="alert alert-danger" role="alert">Multi-factor authentication is not configured yet!</div>
                                    {/if}
                                    <hr>
                                    <p>Select one of available 2FA module below to configure Multi-factor authentication</p>

                                    <table class="table table-bordered" style="max-width: 500px;">
                                        <tbody>
                                            {foreach from=$mfamodules item=modd}
                                                <tr>
                                                    <td><b>{$modd.name}</b></td>
                                                    <td width="1px">
                                                        {if $isenabled && $moduleactivated_id === $modd.id}
                                                            <div style="display:flex;">
                                                                {if $modd.can_manage}
                                                                    <a href="?cmd=mfa&action=manage&id={$modd.id}" class="btn btn-default btn-sm" style="margin-right: 5px;">Manage</a>
                                                                {/if}
                                                                <a href="?cmd=mfa&action=disable" class="btn btn-danger btn-sm">Deactivate</a>
                                                            </div>
                                                        {elseif $isenabled}
                                                            <a href="#" class="btn btn-primary btn-sm disabled">Activate</a>
                                                        {else}
                                                            <a href="?cmd=mfa&action=setup&id={$modd.id}" class="btn btn-primary btn-sm">Activate</a>
                                                        {/if}
                                                    </td>
                                                </tr>
                                            {foreachelse}
                                                <tr>
                                                    <td colspan="100%">
                                                        No MFA module is activated. Enable MFA modules
                                                        <a href="?cmd=managemodules&action=other&do=inactive">here</a>.</td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>