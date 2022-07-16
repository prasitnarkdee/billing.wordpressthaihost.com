<script type="text/javascript" src="{$system_url}includes/modules/Other/mobile_2fa/lib/scripts.js"></script>
<form action="?cmd=mfa&action=enable&id={$modulesetup_id}" method="POST" id="2faform">
    {securitytoken}
    <div class="wbox">
        <div class="wbox_header">{$lang.mfa}</div>
        <div class="wbox_content">
            <div class="alert alert-info">{$lang.mobile2fa_login_desc}</div>
            <div class="form-group">
                <label for="code" class="styled">{$lang.securitycode}</label>
                <input name="code" class="styled form-control w-auto" size="20" type="text" autofocus/>
            </div>

            <hr>
            <button type="submit" name="make" value="submit" class="btn btn-primary">{$lang.submit}</button>
            <button href="#" class="btn btn-request btn-primary" onclick="MFAMOBILE.sendEnable(this);" data-module-id="{$modulesetup_id}" data-resend="0">
                <i class="fa fa-envelope"></i>
                <span data-state="visible">{$lang.mobile2fa_sendpass}</span>
                <span data-state="hidden" style="display: none;">{$lang.mobile2fa_resendpass}</span>
            </button>
        </div>
    </div>
</form>