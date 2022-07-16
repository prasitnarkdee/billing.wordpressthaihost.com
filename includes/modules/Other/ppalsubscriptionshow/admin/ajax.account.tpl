
{once}
<div class="btn-group">
    <button type="button" class="btn btn-sm btn-default" >
        PayPal Subscription
    </button>
    {if !$subscription_id}
        <button type="button" class="btn btn-sm btn-primary "  id="setsubscription_trigger" >
            Enter
        </button>
        {else}
        <button type="button" class="btn btn-sm btn-success " id="setsubscription_trigger" >
           {$subscription_id}
        </button>
    {/if}


</div>
<div id="setsubscription" style="display:none;" bootbox data-title="Set PayPal Subscription"
     data-formaction="?cmd=ppalsubscriptionshow&action=setsubscription&item_id={$item_id}&type={$type}">
    <div class="form-group">
        <label>Subscription ID</label>

        <input type="text" class="form-control" value="{$subscription_id}" name="subscription_id" placeholder="I-WJKJX40HPGCA" />
    </div>
    {securitytoken}
</div>
    {literal}
    <script>

        $(function() {
           $('#setsubscription').bootboxform();
           $('#setsubscription_trigger').on('click',function () {

               $('#setsubscription').trigger('show');
           });

        });
    </script>
    {/literal}
{/once}