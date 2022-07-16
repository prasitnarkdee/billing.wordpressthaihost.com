{*
    Don't remember to add:
    1. "Remember me" function
    2. "Logout" button
*}
<form action="?cmd=mfa&action=verify{if $smarty.get.redirect}&redirect={$smarty.get.redirect}{/if}" method="POST">
    {securitytoken}
    <div class="wbox">
        <div class="wbox_header">{$lang.login}</div>
        <div class="wbox_content">
            <div class="alert alert-info">{$lang.securitycode_info}</div>
            <div class="form-group">
                <label for="code" class="styled">{$lang.securitycode}</label>
                <input name="code" class="styled form-control w-auto" size="20" type="text" autofocus/>
            </div>
            {if $enabled_remembering}
                <div class="checkbox" style="margin:10px 0;">
                    <label>
                        <input name="rememberme" value="1" type="checkbox"/>
                        {$lang.gauth_rememberme|sprintf:$remembering_days}
                    </label>
                </div>
            {/if}
            <button type="submit" name="make" value="submit" class="btn btn-primary">{$lang.submit}</button>
            <a class="btn btn-light ml-1 " href="?action=logout">{$lang.logout}</a>
        </div>
    </div>
</form>
