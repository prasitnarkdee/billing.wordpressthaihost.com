<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3><b>{$lang.promotionsmanagment}</b></h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {if $cmd=='productoffer'}
                <a href="?cmd=productoffer&action=add" class="tstyled btn btn-success">
                    <strong>Add new offer</strong>
                </a>
            {elseif $cmd=='creditvouchers'}
                <a href="?cmd=creditvouchers&action=new_batch" class="tstyled btn btn-success">
                    <strong>{$lang.addnewbatch}</strong>
                </a>
            {elseif $cmd=='coupons' && in_array($action, array('batches', 'batch'))}
                <a href="?cmd=coupons&action=batch" class="tstyled btn btn-success">
                    <strong>Add new code batch</strong>
                </a>
            {else}
                <a href="?cmd=coupons&action=new" class="tstyled btn btn-success">
                    <strong>{$lang.addnewcode}</strong>
                </a>
            {/if}
            <br/>
            <a href="?cmd=coupons" class="tstyled {if $cmd=='coupons' && !in_array($action, array('batches', 'batch'))}selected{/if}">
                {$lang.promocodes}
            </a>
            <a href="?cmd=coupons&action=batches" class="tstyled {if $cmd=='coupons' && in_array($action, array('batches', 'batch'))}selected{/if}">
                Code Batches
            </a>
            <a href="?cmd=creditvouchers" class="tstyled {if $cmd=='creditvouchers'}selected{/if}">
                {$lang.creditvouchers}
            </a>
            <a href="?cmd=productoffer" class="tstyled {if $cmd=='productoffer'}selected{/if}">
                Free products
            </a>
        </td>
        <td valign="top" class="bordered">
            <div class="box box-primary no-padding">
                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            <li {if $cmd=='coupons' && !in_array($action, array('batches', 'batch'))} class="active"{/if}>
                                <a href="?cmd=coupons"><span>{$lang.promocodes}</span></a>
                            </li>
                            <li {if $cmd=='coupons' && in_array($action, array('batches', 'batch'))} class="active"{/if}>
                                <a href="?cmd=coupons&action=batches"><span>Code Batches</span></a>
                            </li>
                            <li {if $cmd=='creditvouchers'} class="active"{/if}>
                                <a href="?cmd=creditvouchers"><span>{$lang.creditvouchers}</span></a>
                            </li>
                            <li {if $cmd=='productoffer'} class="active"{/if}>
                                <a href="?cmd=productoffer"><span>Free products</span></a>
                            </li>
                        </ul>
                    </div>
                    {if $cmd=='productoffer'}
                        {include file='promotions/productoffer.tpl' section='submenu'}
                    {elseif $cmd=='creditvouchers'}
                        {include file='promotions/creditvouchers.tpl' section='submenu'}
                    {elseif $cmd=='coupons' && in_array($action, array('batches', 'batch'))}
                        {include file='promotions/coupon_batches.tpl' section='submenu'}
                    {else}
                        {include file='promotions/coupons.tpl' section='submenu'}
                    {/if}
                </div>
                <div class="box-body">
                    <div id="bodycont">
                        {if $cmd=='productoffer'}
                            {include file='promotions/productoffer.tpl'}
                        {elseif $cmd=='creditvouchers'}
                            {include file='promotions/creditvouchers.tpl'}
                        {elseif $cmd=='coupons' && in_array($action, array('batches', 'batch'))}
                            {include file='promotions/coupon_batches.tpl'}
                        {else}
                            {include file='promotions/coupons.tpl'}
                        {/if}
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>