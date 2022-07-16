<script type="text/javascript" src="{$system_url}includes/modules/Other/google_authenticator/lib/qrcode.min.js"></script>
<script type="text/javascript" src="{$system_url}includes/modules/Other/google_authenticator/lib/scripts.js"></script>
<form action="?cmd=mfa&action=setup&id={$modulesetup_id}" method="POST">
    {securitytoken}
    <div class="wbox">
        <div class="wbox_header">Google Authenticator</div>
        <div class="wbox_content">
            <div class="card-text d-flex flex-column flex-md-row mb-2">
                <div class="d-flex flex-column">
                    <div id="imageQRCode" class="mr-3"></div>
                    <input type="text" class="codeInput mt-2 form-control styled" readonly="readonly" name="code" style="width: 200px;">
                </div>
                <div class="">
                    <p>
                        {$lang.gauth_setup_desc}
                    </p>
                    <p>
                        {$lang.gauth_use_apps}  <br>
                        <ol>
                            <li><a href="https://www.microsoft.com/en-us/p/microsoft-authenticator/9nblgggzmcj6" rel="noreferrer nofollow noopener" target="_blank">Authenticator (Windows Phone)</a> <br></li>
                            <li><a href="https://authy.com/download/" target="_blank"  rel="noreferrer nofollow noopener" >Authy (Android/iPhone)</a> <br></li>
                            <li><a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2"  rel="noreferrer nofollow noopener"  target="_blank">Google Authenticator (Android/iPhone/BlackBerry)</a> <br></li>
                            <li><a href="https://lastpass.com/auth/" target="_blank"  rel="noreferrer nofollow noopener" >LastPass Authenticator (Android/iPhone/Windows Phone)</a> <br></li>
                        </ol>
                    </p>
                </div>
            </div>

            <button type="submit" name="make" value="submit" class="btn btn-primary">{$lang.continue}</button>
            <a href="#" class="btnGenerateCode" data-bn="{$bn}" data-label="{$label}">{$lang.gauth_generatecode|default:"Generate new code"}</a>
        </div>
    </div>
</form>
