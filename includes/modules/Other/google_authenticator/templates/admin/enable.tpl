<form action="?cmd=mfa&action=enable&id={$modulesetup_id}" method="POST">
    {securitytoken}
    <div class="panel panel-default">
        <div class="panel-heading">{$lang.mfa}</div>
        <div class="panel-body">
            <div class="alert alert-info">To finish two-factor authentication configuration, please enter the 6-digit code given by your app</div>
            <div class="form-group">
                <label for="code" class="styled">{$lang.securitycode}</label>
                <input name="code" class="styled form-control" size="20" type="text" autofocus/>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" name="make" value="submit" class="btn btn-primary">Continue</button>
        </div>
    </div>
</form>