{if $custom_overrides.cart1}
    {include file=$custom_overrides.cart1}
{else}
    <link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
    <p>
        {$lang.productconfig1_desc}
    </p>

    <script type="text/javascript">
        {literal}
        function on_submit() {
            var data = {
                layer: 'ajax',
                product_id: $('#product_id').val(),
                product_cycle: $('#product_cycle').val()
            };

            if ($("input[value='illregister']").is(':checked')) {
                //own
                data.sld = $('#sld_register').val();
                data.tld = $('.tld_register:visible').serializeArray().map(function(a){return a.value;});
                ajax_update('?cmd=checkdomain&action=checkdomain', data, '#updater', true);
            } else if ($("input[value='illtransfer']").is(':checked')) {
                //transfer
                data.sld = $('#sld_transfer').val();
                data.tld = $('#tld_transfer').val();
                ajax_update('?cmd=checkdomain&action=checkdomain&transfer=true', data, '#updater', true);
            } else if ($("input[value='illupdate']").is(':checked')) {
                if ($('#iwantupdate_cart').is(':checked')) {
                    var item = $('.iwantupdate_cart_select option:selected');
                    var sld = item.attr('data-sld');
                    var tld = item.attr('data-tld');
                    $('input[name="sld_update"]').val(sld);
                    $('input[name="tld_update"]').val(tld);
                } else if ($('#iwantupdate_myaccount').is(':checked')) {
                    var item = $('.iwantupdate_myaccount_select option:selected');
                    var wipe = /^[-\.]+|[-\.]+$|^((?!xn).{2})--|[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _]|^w{1,3}$|^w{1,3}\./g;
                    var domain = item.attr('data-domain').trim().toLowerCase().replace(wipe, '$1');
                    var dot = (domain + '.').indexOf('.');
                    var parts = [domain.slice(0, dot), domain.slice(dot + 1)];
                    var sld = parts[0];
                    var tld = parts[1] ? '.' + parts[1].replace(wipe, '') : '';
                    $('input[name="sld_update"]').val(sld);
                    $('input[name="tld_update"]').val(tld);
                }
                return true;
            } else if ($("input[value='illsub']").is(':checked')) {
                return true;
            }
            return false;
        }

        function toggleCard(item) {
            $('.owndomain_card_toggler').not(item).prop('checked', false);
            $('.items .item-body').hide();
            if ($(item).is(':checked')) {
                $(item).closest('.item').find('.item-body').show();
            }
        }
        {/literal}
    </script>
    <style>
        {literal}
        .d-flex {
            display: flex !important; }
        .flex-column {
            flex-direction: column !important; }
        .mb-3,
        .my-3 {
            margin-bottom: 1rem !important; }
        .w-100{width:100% !important}
        .card {
            margin: 0 0 20px 0; }
        .bg-white {
            background-color: #fff !important; }
        .p-3 {
            padding: 1rem !important; }
        .text-left {
            text-align: left !important; }
        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1rem; }
        #illupdate label {
            margin-bottom: 0;
        }
        {/literal}
    </style>
    <div class="default-cart">
        <form action="" method="post" onsubmit="return on_submit();" name="domainpicker">
            <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
            <input type="hidden" value="{$cart_contents[0].recurring}" id="product_cycle" name="product_cycle" />
            <input type="hidden" name="make" value="checkdomain" />

            {if $allowregister}
                <p class="domain-action domain-action-register">
                    <input type="radio" name="domain" value="illregister" onclick="$('#options').find('div.slidme').hide();
                        $('#illregister').show();" checked="checked" id="illregister_input" />
                    <label for="illregister_input">{$business_name|string_format:$lang.iwantregister}</label>
                </p>
            {/if} {if $allowtransfer}
                <p class="domain-action domain-action-transfer">
                    <input type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illtransfer').show();" value="illtransfer" name="domain"  id="illtransfer_input" />
                    <label for="illtransfer_input">{$business_name|string_format:$lang.iwanttransfer}</label>
                </p>
            {/if} {if $allowown}
                <p class="domain-action domain-action-own">
                    <input type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illupdate').show();" value="illupdate" name="domain" id="illupdate_input" />
                    <label for="illupdate_input">{$lang.iwantupdate}</label>
                </p>
            {/if} {if $subdomain}
                <p class="domain-action domain-action-sub">
                    <input type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illsub').show();" value="illsub" name="domain" id="illsub_input"  />
                    <label for="illsub_input">{$lang.iwantsub}</label>
                </p>
            {/if}
            <br/>
            <div id="options" class="form-horizontal">

                {if $allowregister}
                    <div  id="illregister" class="t1 slidme">
                        <div class="domain-inputbox">
                            <div id="multisearch" class="left domain-input-bulk domain-input">
                                <textarea name="sld_register" id="sld_register"></textarea>
                            </div>
                            <div class="domain-tld-bulk domain-tld-multiselect" style="display: none;">
                                <select  name="tld[]" class="tld_register" multiple>
                                    {foreach from=$tld_reg item=tldname name=ttld}
                                        <option value="{$tldname}" {if $smarty.foreach.ttld.first}selected{/if} >{$tldname}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="domain-tld-bulk domain-tld-checkbox" >
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                                    <tr>
                                        {foreach from=$tld_reg item=tldname name=ttld}
                                        {if $smarty.foreach.ttld.index && $smarty.foreach.ttld.index % 4 == 0}</tr><tr>{/if}
                                        <td width="25%">
                                            <input type="checkbox" name="tld[]" value="{$tldname}"
                                                   {if $smarty.foreach.ttld.first}checked="checked"{/if}
                                                   class="tld_register"/> {$tldname}
                                        </td>

                                        {/foreach}
                                    </tr>
                                </table>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                {/if}
                {if $allowtransfer}
                    <div  id="illtransfer" style="display: none;" class="slidme form-horizontal">
                        <div class="domain-inputbox">
                            www.
                            <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled span3"/>
                            <select name="tld_transfer" id="tld_transfer" class="span2">
                                {foreach from=$tld_tran item=tldname}
                                    <option>{$tldname}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                {/if}
                {if $allowown}
                    <div  id="illupdate" style="display: none;" class="slidme text-left">
                        <div class="d-flex flex-column items text-left">
                            {if $allowownoutside}
                                <div class="mb-3 w-100 card item">
                                    <div class="card-body bg-white">
                                        <div class="mb-3">
                                            <input id="iwantupdate_outside" type="radio" class="owndomain_card_toggler" checked="checked" onclick="toggleCard($(this));" />
                                            <label for="iwantupdate_outside">{$lang.iwantupdate_outside|sprintf:$business_name}</label>
                                        </div>
                                        <div class="item-body form-group">
                                            <div class="domain-inputbox">
                                                www.
                                                <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled span3"/>
                                                .
                                                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span1"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {else}
                                <input type="hidden" name="sld_update" id="sld_update"/>
                                <input type="hidden" name="tld_update" id="tld_update"/>
                            {/if}
                            {foreach from=$shoppingcart item=order}
                                {foreach from=$order.domains item=domenka}
                                    {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                        {assign var=showcartdomainselect value=true}
                                        {break}
                                    {/if}
                                {/foreach}
                            {/foreach}
                            {if $showcartdomainselect}
                                <div class="mb-3 w-100 card item">
                                    <div class="card-body bg-white">
                                        <div class="mb-3">
                                            <input id="iwantupdate_cart" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                            <label for="iwantupdate_cart">{$lang.iwantupdate_cart}</label>
                                        </div>
                                        <div class="item-body my-3" style="display: none">
                                            <select class="form-control iwantupdate_cart_select">
                                                {foreach from=$shoppingcart item=order key=k}
                                                    {foreach from=$order.domains item=domenka key=kk}
                                                        {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                                            {assign var=showdomenka value=true}

                                                            {foreach from=$shoppingcart item=order2}
                                                                {if $order2.product.domain === $domenka.name}
                                                                    {assign var=showdomenka value=false}
                                                                    {break}  {* domain is already used by other hosting *}
                                                                {/if}
                                                            {/foreach}

                                                            {if $showdomenka}
                                                                <option data-sld="{$domenka.sld}" data-tld="{$domenka.tld}">{$domenka.name}</option>
                                                            {/if}
                                                        {/if}
                                                    {/foreach}
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            <div class="mb-3 w-100 card item">
                                <div class="card-body bg-white">
                                    <div class="mb-3">
                                        <input id="iwantupdate_myaccount" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                        <label for="iwantupdate_myaccount">{$lang.iwantupdate_myaccount}</label>
                                    </div>
                                    <div class="item-body" style="display: none">
                                        {if $logged=="1"}
                                            <div class="my-2">
                                                {clientservices}
                                                {if $client_domains}
                                                    <select class="form-control iwantupdate_myaccount_select">
                                                        {foreach from=$client_domains item=domenka key=kk}
                                                            {if $domenka.status === 'Active' || $domenka.status === 'Pending Registration' || $domenka.status === 'Pending Transfer'}
                                                                <option data-domain="{$domenka.name}">{$domenka.name}</option>
                                                            {/if}
                                                        {/foreach}
                                                    </select>
                                                {else}
                                                    <div class="mt-3 text-left">
                                                        <span>{$lang.youdonthaveactivedomain}</span>
                                                    </div>
                                                {/if}
                                            </div>
                                        {else}
                                            <div class="bg-light p-3 my-3 text-left">
                                                <span>{$lang.pleaseloginyouraccount}</span>.
                                                <a href="?cmd=login">{$lang.login}</a>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                {if $subdomain}
                    <div  id="illsub" style="display: none;" class="slidme form-horizontal">
                        <div class="domain-inputbox">
                            www.
                            <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled span3"/>
                            {$subdomain}
                        </div>
                    </div>
                {/if}
            </div>

            <div class="domain-submit">
                <input type="submit" value="{$lang.continue}" class="padded btn btn-primary"/>
            </div>
        </form>

        <form method="post" action="">
            <div id="updater">
                {include file="ajax.checkdomain.tpl"}
            </div>
        </form>
    </div>
{/if}
