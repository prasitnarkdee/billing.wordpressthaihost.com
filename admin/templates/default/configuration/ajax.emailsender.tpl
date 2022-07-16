{if $view_type == 'list'}
    <div style="border: solid 1px #ddd;">
        <div class="row form" style="padding: 10px;">
            <div class="col-sm-4">
                <span><strong>{$sender.email}</strong></span>
                <span> - {if $sender.mailer_type == 'php_mailer'}{$lang.MailUsePHP}{elseif $sender.mailer_type == 'smtp'}{$lang.MailUseSMTP}{else}{$lang.MailUseTransactional}{/if}</span>
            </div>
            <div class="col-sm-4 test-result"></div>
            <div class="col-sm-4 text-right right">
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="email" class="form-control input-sm test-email" placeholder="{$lang.email}">
                        <span class="input-group-btn">
                            <button class="btn btn-sm btn-default" type="button" onclick="testEmailSender($(this), {$sender.id});">{$lang.sendtestmail}</button>
                        </span>
                    </div>
                </div>
                <div class="col-sm-4">
                    <button type="button" class="btn btn-sm btn-primary" onclick="editEmailSender($(this), {$sender.id});">{$lang.Edit}</button>
                    <button type="button" class="btn btn-sm btn-danger" onclick="removeEmailSender($(this), {$sender.id}, '{$lang.areyousure}');">{$lang.Remove}</button>
                </div>
            </div>
        </div>
    </div>

{else}
    <div style="border: solid 1px #ddd;" class="email_sender">
        {if $sender}
            <div class="row form" style="padding: 10px;">
                <div class="col-sm-4">
                    <span><strong>{$sender.email}</strong></span>
                    <span> - {if $sender.mailer_type == 'php_mailer'}{$lang.MailUsePHP}{elseif $sender.mailer_type == 'smtp'}{$lang.MailUseSMTP}{else}{$lang.MailUseTransactional}{/if}</span>
                </div>
                <div class="col-sm-4 test-result"></div>
                <div class="col-sm-4 text-right right">
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input type="email" class="form-control input-sm test-email" placeholder="{$lang.email}">
                            <span class="input-group-btn">
                            <button class="btn btn-sm btn-default" type="button" onclick="testEmailSender($(this), false);">{$lang.sendtestmail}</button>
                        </span>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <button type="button" class="btn btn-sm btn-primary" onclick="editEmailSender($(this), {$sender.id});">{$lang.Edit}</button>
                        <button type="button" class="btn btn-sm btn-danger" onclick="removeEmailSender($(this), {$sender.id}, '{$lang.areyousure}');">{$lang.Remove}</button>
                    </div>
                </div>
            </div>
        {else}
            <div class="row form" style="padding: 10px;">
                <div class="col-sm-offset-4 col-sm-4 test-result"></div>
                <div class="col-sm-4">
                    <div class="input-group">
                        <input type="email" class="form-control input-sm test-email" placeholder="{$lang.email}">
                        <span class="input-group-btn">
                            <button class="btn btn-sm btn-default" type="button" onclick="testEmailSender($(this), false);">{$lang.sendtestmail}</button>
                        </span>
                    </div>
                </div>
            </div>
        {/if}
        <div class="row form" style="padding: 10px;">
            <div class="form-group col-sm-4">
                <label>{$lang.email}</label>
                <input type="email" class="form-control sender-email" name="EmailSenders[{$sender_id}][SystemMail]{if $sender_id == 'new'}[{$id}]{/if}" value="{$sender.email}">
            </div>
            <div class="form-group col-sm-3" >
                <label>{$lang.MailerMethod}</label>
                <select class="form-control sender-type" name="EmailSenders[{$sender_id}][MailUseSMTP]{if $sender_id == 'new'}[{$id}]{/if}" style="margin: 0;" onchange="changeEmailSender($(this))">
                    <option value="php_mailer" {if $sender.mailer_type == 'php_mailer'}selected{/if}>{$lang.MailUsePHP}</option>
                    <option value="smtp" {if $sender.mailer_type == 'smtp'}selected{/if}>{$lang.MailUseSMTP}</option>
                    <option value="transactional" {if $sender.mailer_type == 'transactional'}selected{/if}>{$lang.MailUseTransactional}</option>
                </select>
            </div>
            <div class="form-group col-sm-2">
                <label>Log admin notifications</label>
                <div>
                    <div class="checkbox">
                        <label>
                            <input class="sender-log" type="checkbox" value="on" name="EmailSenders[{$sender_id}][LogAdminEmails]{if $sender_id == 'new'}[{$id}]{/if}" {if $sender.log_admin}checked{/if} >
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group col-sm-3">
                <label>Limit mails per cron run</label>
                <input type="number" class="form-control sender-cron" name="EmailSenders[{$sender_id}][EmailsPerCronRun]{if $sender_id == 'new'}[{$id}]{/if}"
                       value="{if $sender.cron_limit}{$sender.cron_limit}{else}0{/if}" >
            </div>
        </div>
        <div class="row form smtp" style="{if !$sender.mailer_data.MailSMTPEmail} display: none;{/if} padding: 10px;">
            <div class="form-group col-sm-4">
                <label>SMTP Email address</label>
                <input type="email" class="form-control sender-smtp-email" value="{$sender.mailer_data.MailSMTPEmail}" name="EmailSenders[{$sender_id}][MailSMTPEmail]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-4" style="max-height: 54px;">
                <label>{$lang.MailSMTPHost}</label> <a class="vtip_description" title="You can explicitly specify protocol in hostname ie:<br>
                    tls://hostname<br>
                    ssl://hostname<br>
                    To disable certificate validation, use /noverify flag, ie:<br>
                    ssl://hostname/noverify"></a>
                <input type="text" class="form-control sender-smtp-host" value="{$sender.mailer_data.MailSMTPHost}" name="EmailSenders[{$sender_id}][MailSMTPHost]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-1">
                <label>{$lang.MailSMTPPort}</label>
                <input type="number" class="form-control sender-smtp-port" value="{$sender.mailer_data.MailSMTPPort}" name="EmailSenders[{$sender_id}][MailSMTPPort]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-3">
                <label>{$lang.MailAuthentication}</label>
                <select class="form-control sender-authentication" name="EmailSenders[{$sender_id}][MailAuthentication]{if $sender_id == 'new'}[{$id}]{/if}" style="margin: 0;"
                    onchange="mailAuthentication($(this))">
                    <option value="password" {if $sender.mailer_data.MailAuthentication == 'password'}selected{/if}>{$lang.password}</option>
                    <option value="oauth2" {if $sender.mailer_data.MailAuthentication == 'oauth2'}selected{/if}>{$lang.oauth2}</option>
                </select>
            </div>
            <div class="form-group col-sm-4 password" {if $sender.mailer_data.MailAuthentication == 'oauth2'}style="display: none;"{/if}>
                <label>{$lang.MailSMTPUsername}</label>
                <input type="text" class="form-control sender-smtp-user" value="{$sender.mailer_data.MailSMTPUsername}" name="EmailSenders[{$sender_id}][MailSMTPUsername]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-4 password" {if $sender.mailer_data.MailAuthentication == 'oauth2'}style="display: none;"{/if}>
                <label>{$lang.MailSMTPPassword}</label>
                <input type="password" class="form-control sender-smtp-pass" value="{$sender.mailer_data.MailSMTPPassword}" name="EmailSenders[{$sender_id}][MailSMTPPassword]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-4 oauth2" {if !$sender || $sender.mailer_data.MailAuthentication == 'password'}style="display: none;"{/if}>
                <label>{$lang.MailProvider}</label>
                <select class="form-control sender-provider" name="EmailSenders[{$sender_id}][MailProvider]{if $sender_id == 'new'}[{$id}]{/if}" style="margin: 0;"
                    onchange="changeProvider($(this))">
                    <option value="custom" {if $sender.mailer_data.MailProvider == 'custom'}selected{/if}>{$lang.MailCustom}</option>
                    {foreach from=$providers item=provider}
                        <option value="{$provider}" {if $sender.mailer_data.MailProvider == $provider}selected{/if}>{$lang[$provider]|default:$provider}</option>
                    {/foreach}
                </select>
            </div>
            <div class="form-group col-sm-4 oauth2" {if !$sender || $sender.mailer_data.MailAuthentication == 'password'}style="display: none;"{/if}>
                <label>{$lang.MailClientID}</label>
                <input type="text" class="form-control sender-smtp-clientid" value="{$sender.mailer_data.MailClientID}" name="EmailSenders[{$sender_id}][MailClientID]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-4 oauth2" {if !$sender || $sender.mailer_data.MailAuthentication == 'password'}style="display: none;"{/if}>
                <label>{$lang.MailClientSecret}</label>
                <input type="password" class="form-control sender-smtp-clientsecret" value="{$sender.mailer_data.MailClientSecret}" name="EmailSenders[{$sender_id}][MailClientSecret]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-4 oauth2" {if !$sender || $sender.mailer_data.MailAuthentication == 'password'}style="display: none;"{/if}>
                <label>{$lang.MailRedirectURL}</label>
                <input type="text" class="form-control sender-smtp-redirect" value="{$oauth_redirect_url}{$sender.id}" disabled>
            </div>
            <div class="form-group col-sm-4 oauth2" {if !$sender || $sender.mailer_data.MailAuthentication == 'password'}style="display: none;"{/if}>
                <label>{$lang.MailConnectionToken}</label>
                <input type="password" class="form-control sender-smtp-connectiontoken" value="{$sender.mailer_data.MailOAuth2Token}" disabled>
            </div>
            <div class="form-group col-sm-4 oauth2 oauth2-custom" {if !$sender || $sender.mailer_data.MailAuthentication == 'password' || $sender.mailer_data.MailProvider != 'custom'}style="display: none;"{/if}>
                <label>{$lang.MailAuthorizeURL}</label>
                <input type="text" class="form-control sender-smtp-authotizeurl" value="{$sender.mailer_data.MailAuthorizeURL}" name="EmailSenders[{$sender_id}][MailAuthorizeURL]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-4 oauth2 oauth2-custom" {if !$sender || $sender.mailer_data.MailAuthentication == 'password' || $sender.mailer_data.MailProvider != 'custom'}style="display: none;"{/if}>
                <label>{$lang.MailAccessTokenURL}</label>
                <input type="text" class="form-control sender-smtp-accesstokenurl" value="{$sender.mailer_data.MailAccessTokenURL}" name="EmailSenders[{$sender_id}][MailAccessTokenURL]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-4 oauth2 oauth2-custom" {if !$sender || $sender.mailer_data.MailAuthentication == 'password' || $sender.mailer_data.MailProvider != 'custom'}style="display: none;"{/if}>
                <label>{$lang.MailResourceOwnerDetailsURL}</label>
                <input type="text" class="form-control sender-smtp-resourceurl" value="{$sender.mailer_data.MailResourceOwnerDetailsURL}" name="EmailSenders[{$sender_id}][MailResourceOwnerDetailsURL]{if $sender_id == 'new'}[{$id}]{/if}">
            </div>
            <div class="form-group col-sm-2 oauth2" {if !$sender || $sender.mailer_data.MailAuthentication == 'password'}style="display: none;"{/if}>
                <a href="{$oauth_redirect_url}{$sender.id}" class="btn btn btn-default" style="margin-top: 22px;">{$lang.Connect}</a>
                <a href="?cmd=configuration&action=oauth_disconnect&sender={$sender.id}" onclick="return confirm('{$lang.areyousure}');"
                   class="btn btn btn-default" style="margin-top: 22px; margin-left: 7px;" {if !$sender.mailer_data.MailOAuth2Token}disabled{/if} >{$lang.Disconnect|default:"Disconnect"}</a>
            </div>
        </div>
        {if $sender.id}
            <input type="hidden" name="EmailSenders[{$sender_id}][edit]" value="{$sender.id}">
        {/if}
    </div>
{/if}