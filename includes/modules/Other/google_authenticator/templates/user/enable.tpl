<form action="?cmd=mfa&action=enable&id={$modulesetup_id}" method="POST">
    {securitytoken}
    <div class="wbox">
        <div class="wbox_header">Google Authenticator</div>
        <div class="wbox_content">
            <div class="alert alert-info">To finish two-factor authentication configuration, please enter the 6-digit code given by your app</div>
            <div class="form-group">
                <label for="code" class="styled">{$lang.securitycode}</label>
                <input name="code" class="styled form-control w-auto" size="20" type="text" autofocus/>
            </div>
            <button type="submit" name="make" value="submit" class="btn btn-primary">{$lang.submit}</button>
        </div>
    </div>
</form>