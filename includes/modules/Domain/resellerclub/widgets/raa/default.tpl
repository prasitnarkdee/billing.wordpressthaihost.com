{if $resellerclub.raaVerificationStatus}
    <label>{$lang.raa_status}:</label>
    {if $resellerclub.raaVerificationStatus == 'Verified'}
        <label class="label label-success badge badge-success">{$lang[$resellerclub.raaVerificationStatus]|default:$resellerclub.raaVerificationStatus}</label>
    {elseif $resellerclub.raaVerificationStatus == 'Pending' || $resellerclub.raaVerificationStatus == 'Suspended'}
        <label class="label label-warning badge badge-{if $resellerclub.raaVerificationStatus == 'Pending'}primary{else}warning{/if}">{$lang[$resellerclub.raaVerificationStatus]|default:$resellerclub.raaVerificationStatus}</label><br>
        <div class="alert alert-warning" role="alert">
            {$resellerclub.registrantcontact.emailaddr|string_format:$lang.raa_not_verified}
            {if $raa_deadline}
                {$raa_deadline|string_format:$lang.raa_deadline}
            {/if}
            <br><br>
            <a href="{$widget_url}&raa=resend&security_token={$security_token}" class="btn btn-success">{$lang.resend_email}</a>
        </div>
    {elseif $resellerclub.raaVerificationStatus}
        <label class="label label-default badge badge-info">{$lang[$resellerclub.raaVerificationStatus]|default:$resellerclub.raaVerificationStatus}</label>
    {/if}<hr><br>
{/if}
