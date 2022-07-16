{foreach from=$contracts item=ct}
    <tr>
        <td>{$ct.number}</td>
        <td>{$ct.created_at|dateformat:$date_format}</td>
        <td><a href="?cmd=contracts&onumber={$ct.order_number}" target="_blank">{$ct.template_name}</a></td>
        {if $accepted !== false}
            <td>{if $ct.accepted_at}{$ct.accepted_at|dateformat:$date_format}{else}-{/if}</td>
            <td>
                {if $ct.accepted_by}
                    {if $ct.accepted_by < 0} Admin {else}
                        {$ct.accepted_by|@client}
                    {/if}
                {else}-{/if}
            </td>
        {/if}
        <td><span class="label label-{$ct.status}">{$lang[$ct.status]}</span></td>
        <td width="150">
            <a href="?cmd=contracts&onumber={$ct.order_number}">{$lang.view|ucfirst}</a>
            <a target="_blank" href="?cmd=contracts&action=pdf&oid={$ct.order_id}&onumber={$ct.order_number}&cid={$ct.id}&ctid={$ct.template_id}&pid={$ct.product_id}&ptype={$ct.contract_target}&hash={$ct.pdf_hash|urlencode}" >{$lang.download}</a>
        </td>
    </tr>
{foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}