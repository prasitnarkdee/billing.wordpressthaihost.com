{if $custom_overrides.cart3}
    {include file=$custom_overrides.cart3}
{else}
    <link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
    {literal}
        <script type="text/javascript">
            function changeCycle(forms) {
                $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
                return true;
            }
        </script>
    {/literal}
    <div class="default-cart">
        <form action="" method="post" id="cart3">

            {if $parent_account}
                <div class="wbox">
                    <div class="wbox_header">
                        <strong>{$lang.relatedservice}</strong>
                    </div>
                    <div class="wbox_content">
                        <span>{$lang.iamorderingforaccount}</span>
                        <a target="_blank" href="{$ca_url}clientarea&action=services&service={$parent_account.id}">#{$parent_account.id} {$parent_account.category_name} - {$parent_account.product_name} {if $parent_account.label} <small>({$parent_account.label})</small> {/if}</a>
                    </div>
                </div>
            {/if}

            {if $product.description!='' || $product.paytype=='Once' || $product.paytype=='Free'}
                <div class="wbox">
                    <div class="wbox_header">
                        <strong>{$product.name}</strong>
                    </div>
                    <div class="wbox_content" id="product_description">

                        {$product.description}

                        {if $product.paytype=='Free'}<br />
                            <input type="hidden" name="cycle" value="Free" />
                            {$lang.price} <strong>{$lang.free}</strong>

                        {elseif $product.paytype=='Once'}<br />
                            <input type="hidden" name="cycle" value="Once" />
                            {price product=$product}
                            {$lang.price}  <strong>@@price</strong> {$lang.once} @@setupline<<' + '@
                            {/price}
                        {/if}

                    </div>
                </div>
            {/if}



            {if   $product.type=='Dedicated' || $product.type=='Server' || $product.hostname || $custom || ($product.paytype!='Once' && $product.paytype!='Free')}

                <div class="wbox">
                    <div class="wbox_header">
                        <strong>{$lang.config_options}</strong>
                    </div>
                    <div class="wbox_content">

                        {if $product.paytype!='Once' && $product.paytype!='Free'}

                            <div class="cart-item cart-cycle">
                                <div class="pb10"  width="175">
                                    <strong>{$lang.pickcycle}</strong>
                                </div>
                                <div class="pb10">
                                    <select name="cycle"   onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}" style="width:99%">
                                        {price product=$product}
                                        <option value="@@cycle" @@selected>@@line</option>
                                        {/price}
                                    </select>
                                </div>
                            </div>

                        {/if}

                        {if $product.hostname}
                            <div class="cart-item cart-hostname">
                                <div class="pb10" width="175">
                                    <strong>{$lang.hostname}</strong> *
                                </div>
                                <div class="pb10">
                                    <input name="domain" type="text" value="{$item.domain}"
                                           class="styled" size="50" style="width:96%"/>
                                </div>
                            </div>
                        {/if}

                        {if $custom}
                            <input type="hidden" name="custom[-1]" value="dummy" />
                            {foreach from=$custom item=cf}
                                {if $cf.items}

                                    <div class="cart-form cart-item {if $cf.key|strstr:'cf_'}{$cf.key} cf_option{/if}">
                                        <label for="custom[{$cf.id}]" class="styled">
                                            {$cf.name} {if $cf.options & 1}*{/if}
                                        </label>
                                        {if $cf.description!=''}
                                            <div class="fs11 descr" style="">{$cf.description}</div>
                                        {/if}

                                        {include file=$cf.configtemplates.cart}
                                    </div>

                                {/if}
                            {/foreach}

                        {/if}


                        <small>{$lang.field_marked_required}</small>

                    </div>
                </div>
            {/if}

            {if $subproducts}
                <div class="wbox">
                    <div class="wbox_header">
                        <strong>{$lang.additional_services}</strong>
                    </div>
                    <div class="wbox_content">

                        {foreach from=$subproducts item=a key=k}
                            <div class="cart-item cart-subproduct">
                                <div class="checkbox">
                                    <input name="subproducts[{$k}]" type="checkbox" value="1"
                                           id="subproducts{$k}"
                                           {if $selected_subproducts.$k}checked="checked"{/if}
                                           onchange="simulateCart('#cart3');"/>
                                    <label for="subproducts{$k}">{$a.category_name} - {$a.name}</label>
                                </div>
                                <div class="cart-item-price">
                                    {price product=$a}
                                    {if $a.paytype=='Free'}
                                        {$lang.free}
                                        <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                    {elseif $a.paytype=='Once'}
                                        <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                        @@line
                                    {else}
                                        <select name="subproducts_cycles[{$k}]"
                                                onchange="if ($('input[name=\'subproducts[{$k}]\']').is(':checked'))
                                                            simulateCart('#cart3');">
                                            <option value="@@cycle" @@selected>@@line</option>
                                        </select>
                                    {/if}
                                    {/price}
                                </div>
                            </div>

                        {/foreach}

                    </div>
                </div>
            {/if}

            {if $addons}
                <div class="wbox">
                    <div class="wbox_header">
                        <strong>{$lang.addons_single}</strong>
                    </div>
                    <div class="wbox_content">
                        <p>{$lang.addons_single_desc}</p>


                        {foreach from=$addons item=a key=k}
                            <div class="cart-item cart-addon">
                                <div class="checkbox">
                                    <input name="addon[{$k}]" type="checkbox" value="1"
                                           id="addon{$k}"
                                           {if $selected_addons.$k}checked="checked"{/if}
                                           onchange="simulateCart('#cart3');"/>
                                    <label for="addon{$k}">{$a.name}</label>
                                </div>
                                {if $a.description!=''}
                                    <div class="cart-item-description">
                                        {$a.description}
                                    </div>
                                {/if}
                                <div class="cart-item-price">
                                    {price product=$a}
                                    {if $a.paytype=='Free'}
                                        {$lang.free}
                                        <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                                    {elseif $a.paytype=='Once'}
                                        <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                        @@line
                                    {else}
                                        <select name="addon_cycles[{$k}]"   onchange="if ($('input[name=\'addon[{$k}]\']').is(':checked'))
                                                    simulateCart('#cart3');">
                                            <option value="@@cycle" @@selected>@@line</option>
                                        </select>
                                    {/if}
                                    {/price}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/if}

            <input name='action' value='addconfig' type='hidden' />

            <div class="orderbox">
                <div class="orderboxpadding">
                    <center>
                        <input type="submit" value="{$lang.continue}"
                               style="font-weight:bold;font-size:12px;"
                               class="padded btn  btn-primary"/>
                    </center>
                </div>
            </div>
        </form>
    </div>
{/if}