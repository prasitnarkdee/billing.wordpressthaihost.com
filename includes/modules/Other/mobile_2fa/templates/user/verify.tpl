<script type="text/javascript" src="{$system_url}includes/modules/Other/mobile_2fa/lib/scripts.js"></script>
<form action="?cmd=mfa&action=verify{if $smarty.get.redirect}&redirect={$smarty.get.redirect}{/if}" method="POST">
    {securitytoken}
    <div class="wbox">
        <div class="wbox_header">{$lang.login}</div>
        <div class="wbox_content">
            <div class="alert alert-info">{$lang.mobile2fa_login_desc}</div>
            <div style="text-align: center;padding:10px;">
                <button href="#" class="btn btn-request btn-primary" onclick="MFAMOBILE.sendVerify(this);" data-resend="0">
                    <i class="fa fa-envelope"></i>
                    <span data-state="visible">{$lang.mobile2fa_sendpass}</span>
                    <span data-state="hidden" style="display: none;">{$lang.mobile2fa_resendpass}</span>
                </button>
            </div>

            <div style="display: none" id="2faform">
                <div class="form-group" >
                    <label for="code" class="styled">{$lang.password}</label>
                    <input name="code" class="styled form-control" type="number" id="code" autofocus/>
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
    </div>
</form>