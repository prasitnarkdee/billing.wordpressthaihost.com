{if $api_key_set}
    {if $revolut_webhook}
        <b style="color:green">Webhook URL configured successfully!</b>
        <div><b>ID:</b> {$revolut_webhook.id}</div>
        <div><b>URL:</b> {$revolut_webhook.url}</div>
        <div><b>Events:</b> {', '|implode:$revolut_webhook.events}</div>
    {else}
        <b style="color:red;">Webhook not configured! Payments will not work successfully.</b> <br>
        To setup Revolut Webhook URL use button below:<br>
        <button type="button" class="btn btn-xs btn-default" onclick="ajax_update('?cmd=revolut&action=webhookconfigure&make=setup', '','#revolutwebhookconfig',true);">Setup webhook URL</button>
    {/if}
{else}
    <b style="color:red;">Webhook not configured! Payments will not work successfully.</b> <br>
    <ol>
        <li>Enter the "API Key"</li>
        <li>Save changes</li>
        <li>Click on the "Setup webhook" button</li>
    </ol>
    <button class="btn btn-default btn-sm" disabled="disabled">Setup webhook</button>
{/if}