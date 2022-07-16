{if $make==='codes'}
    {foreach from=$coupons item=coupon}
        <tr>
            <td>{$coupon.id}</td>
            <td>{$coupon.code}</td>
            <td>
                {if $coupon.status == 'Active'}
                    <span style="color: #00CE3C"><b>{$coupon.status}</b></span>
                {else}
                    <span style="color: #6f828b"><b>{$coupon.status}</b></span>
                {/if}
            </td>
            <td>{$coupon.coupon_type|ucfirst}</td>
            <td>{if $coupon.type=='percent'}{$coupon.value}%{else}{$coupon.value|price:$currency}{/if}</td>
            <td>
                <a href="?cmd=logs&action=coupons&filter[coupon]={$coupon.code}&resetfilter=1">{$coupon.num_usage}</a>
            </td>
            <td>
                <a href="?cmd=coupons&action=batch&make=delete_coupon&id={$coupon.id}&batch_id={$coupon.batch_id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.confirmdel}')">{$lang.Delete}</a>
            </td>
        </tr>
    {/foreach}
{else}
    {foreach from=$batches item=batch}
        <tr>
            <td><a href="?cmd=coupons&action=batch&id={$batch.id}" >{$batch.id}</a></td>
            <td><a href="?cmd=coupons&action=batch&id={$batch.id}" >{$batch.name}</a></td>
            <td>
                {if $batch.status == 'Active'}
                    <span style="color: #00CE3C"><b>{$batch.status}</b></span>
                {else}
                    <span style="color: #6f828b"><b>{$batch.status}</b></span>
                {/if}
            </td>
            <td><a href="?cmd=coupons&action=batch&id={$batch.id}" >{$batch.prefix}</a></td>
            <td>{$batch.coupon_type|ucfirst}</td>
            <td>{if $batch.type=='percent'}{$batch.value}%{else}{$batch.value|price:$currency}{/if}</td>
            <td>{$batch.coupons_count}</td>
            <td>{$batch.coupons_used}</td>
            <td>{$batch.coupon_config.notes}</td>
            <td>{$batch.created_at|dateformat:$date_format}</td>
            <td>{$batch.coupon_config.expires}</td>
            <td>
                <a href="?cmd=coupons&action=batch&id={$batch.id}&make=codes" class="btn btn-sm btn-default">List codes</a>
                <a href="?cmd=coupons&action=batch&id={$batch.id}" class="btn btn-sm btn-info">Manage</a>
                <a href="?cmd=coupons&action=batch&id={$batch.id}&make=delete&security_token={$security_token}" class="btn btn-sm btn-default" style="color:red" onclick="return confirm('Are you sure you want to delete this batch with ALL related coupons?')">{$lang.Delete}</a>
            </td>
        </tr>
    {/foreach}
{/if}