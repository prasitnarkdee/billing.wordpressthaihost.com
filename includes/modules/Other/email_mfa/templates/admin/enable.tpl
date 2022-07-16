<script type="text/javascript" src="{$system_url}includes/modules/Other/email_mfa/lib/scripts.js"></script>
<form action="?cmd=mfa&action=enable&id={$modulesetup_id}" method="POST">
    {securitytoken}
    <div class="panel panel-default">
        <div class="panel-heading">{$lang.mfa}</div>
        <div class="panel-body">
            <div class="alert alert-info">To finish two-factor authentication configuration, please enter the code sent to your by Email</div>
            <div class="form-group">
                <label for="code" class="styled">{$lang.securitycode}</label>
                <input name="code" class="styled form-control" size="20" type="text" autofocus/>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" name="make" value="submit" class="btn btn-primary">Continue</button>
            <a href="#" class="btn btn-request btn-primary" onclick="MFAEMAIL.sendEnable(this);return false;" data-module-id="{$modulesetup_id}" data-resend="0">
                <i class="fa fa-envelope"></i>
                <span data-state="visible">{$lang.email_mfa_sendpass}</span>
                <span data-state="hidden" style="display: none;">{$lang.email_mfa_resendpass}</span>
            </a>
        </div>
    </div>
</form>