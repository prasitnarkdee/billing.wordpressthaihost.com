{if $custom_overrides.cart5}
    {include file=$custom_overrides.cart5}
{else}
    <link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
    {if $paymodule}
        <br />
        <br />

        <center>
            {$lang.redirection}<br />
            <img src="{$template_dir}img/ajax-loading.gif" alt=""/><br />
            {$paymodule}
        </center>

    {elseif $thanks}
        <h1 class="cart2">{$lang.order_ok}</h1>
        <p>{$lang.order_thanks}</p>
        {if $order_num}
        <h2>{$lang.order_num} {$order_num}</h2>
        <p>{$lang.order_thanks2}</p>
        {/if}
    {/if}
    <img src="?cmd=cronimg&action=afterorder" alt="" />
{/if}