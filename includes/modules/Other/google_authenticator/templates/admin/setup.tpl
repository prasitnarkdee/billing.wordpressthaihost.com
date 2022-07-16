<script type="text/javascript" src="{$system_url}includes/modules/Other/google_authenticator/lib/qrcode.min.js"></script>
<script type="text/javascript" src="{$system_url}includes/modules/Other/google_authenticator/lib/scripts.js"></script>
<form action="?cmd=mfa&action=setup&id={$modulesetup_id}" method="POST">
    {securitytoken}
    <div class="panel panel-default">
        <div class="panel-heading">Google Authenticator</div>
        <div class="panel-body">
            <div class="pull-left">
                <div id="imageQRCode" style="margin-right: 20px;"></div>
                <input class="codeInput" readonly="readonly" name="code" style="width: 200px;margin-top: 10px;">
            </div>
            <div style="margin-left: 20px;">
                <p>
                    Our system uses time-based one time passwords
                    (TOTP) as the underlying technology for our two-factor authentication.
                    Please type in the code or scan the QR-code with one of the applications listed below
                    to enable an additional layer of security for your
                    account.
                </p>
                <p>
                    Please use one of the following applications: <br>
                <ul>
                    <li>Authenticator (Windows Phone)<br></li>
                    <li>Authy (Android/iPhone)<br></li>
                    <li>Google Authenticator (Android/iPhone/BlackBerry)<br></li>
                    <li>LastPass Authenticator (Android/iPhone/Windows Phone)<br></li>
                </ul>
                </p>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" name="make" value="submit" class="btn btn-primary">Continue</button>
            <a href="#" class="btnGenerateCode" data-bn="{$bn}" data-label="{$label}">{$lang.gauth_generatecode|default:"Generate new code"}</a>
        </div>
    </div>
</form>
