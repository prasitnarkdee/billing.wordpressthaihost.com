<tr>
    <td id="getvaluesloader">
        {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}
                {else}{$test_connection_result.result}
                {/if}
                {if $test_connection_result.error}: {$test_connection_result.error}
                {/if}
            </span>
        {/if}
    </td>
    <td id="onappconfig2_"><div id="">
            <ul class="breadcrumb-nav" style="margin-top:10px;">
                <li><a href="#" class="active" onclick="load_onapp_section('provisioning')">Info</a></li>
                <li><a href="#" class="" onclick="load_onapp_section('resources')">Settings</a></li>
            </ul>
            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
                <div class="onapptab" id="provisioning_tab">
                    <b style="color:red">Important:</b> Before using, please refer to <a href="https://hostbill.atlassian.net/wiki/display/DOCS/Script+Provisioning" target="_blank">Documentation</a>


                </div>
                <div class="onapptab form" id="resources_tab">
                    <h4><input type="checkbox" {if $default.script_create}checked="checked"{/if} onclick="$('#show_create').toggle();"/> Create Addon: </h4>
                    <table border="0" cellspacing="0" cellpadding="6" width="100%" id="show_create" {if !$default.script_create}style="display: none" {/if} >
                        <tr>
                            <td width="160"><label >Script <a class="vtip_description" title="Select script from scripts directory"></a></label></td>
                            <td >
                                <select name="options[script_create]" id="script_create" style="width:100%;margin:0px">
                                    <option value="" {if !$default.script_create}selected="selected"{/if}>--select--</option>
                                    {foreach from=$scripts item=sc}
                                        <option {if $default.script_create == $sc }selected="selected"{/if}>{$sc}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >Arguments <a class="vtip_description" title="Enter arguments, one per box that will be passed during this function to script, you can use variables here. Empty arguments are not passed"></a></label></td>
                            <td>
                                <table border="0" cellspacing="0" cellpadding="3" id="tr_create" width="100%">

                                    {foreach from=$default.arguments_create item=attribute key=k}
                                        {if !$attribute}{break}{/if}
                                        <tr id="tr{$k}">
                                            <td ><input type="text" name="options[arguments_create][{$k}]" value="{$attribute|escape:'html':'utf-8'}" style="width:100%;" /></td>
                                            <td width="50"><a onclick="tr_remove_row(this);
                                                    return false" class="rembtn" href="#">Remove</a></td>
                                        </tr>
                                    {/foreach}
                                    <tr id="tr{if $default.arguments_create}{$k+1}{else}0{/if}">
                                        <td ><input type="text" name="options[arguments_create][{if $default.arguments_create}{$k+1}{else}0{/if}]" value="" style="width:100%;" /></td>

                                        <td width="50"><a onclick="tr_remove_row(this);
                                                return false" class="rembtn" href="#">Remove</a></td>
                                    </tr>
                                </table>
                                <a href="#" class="editbtn" onclick="tr_add_row('#tr_create');  return false;">Add new argument</a>
                            </td>
                        </tr>
                    </table>
                    <h4><input type="checkbox" {if $default.script_suspend}checked="checked"{/if} onclick="$('#show_suspend').toggle();"/> Suspend Addon: </h4>
                    <table border="0" cellspacing="0" cellpadding="6" width="100%" id="show_suspend" {if !$default.script_suspend}style="display: none" {/if}>

                        <tr>
                            <td width="160"><label >Script <a class="vtip_description" title="Select script from scripts directory"></a></label></td>
                            <td >
                                <select name="options[script_suspend]" id="script_suspend" style="width:100%;margin:0px">
                                    <option value="" {if !$default.script_suspend}selected="selected"{/if}>--select--</option>
                                    {foreach from=$scripts item=sc}
                                        <option {if $default.script_suspend == $sc }selected="selected"{/if}>{$sc}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >Arguments <a class="vtip_description" title="Enter arguments, one per box that will be passed during this function to script, you can use variables here. Empty arguments are not passed"></a></label></td>
                            <td>
                                <table border="0" cellspacing="0" cellpadding="3" id="tr_suspend" width="100%">

                                    {foreach from=$default.arguments_suspend item=attribute key=k}
                                        {if !$attribute}{break}{/if}
                                        <tr id="tr{$k}">
                                            <td ><input type="text" name="options[arguments_suspend][{$k}]" value="{$attribute|escape:'html':'utf-8'}" style="width:100%;" /></td>
                                            <td width="50"><a onclick="tr_remove_row(this);
                                                    return false" class="rembtn" href="#">Remove</a></td>
                                        </tr>
                                    {/foreach}
                                    <tr id="tr{if $default.arguments_suspend}{$k+1}{else}0{/if}">
                                        <td ><input type="text" name="options[arguments_suspend][{if $default.arguments_suspend}{$k+1}{else}0{/if}]" value="" style="width:100%;" /></td>

                                        <td width="50"><a onclick="tr_remove_row(this);
                                                return false" class="rembtn" href="#">Remove</a></td>
                                    </tr>
                                </table>
                                <a href="#" class="editbtn" onclick="tr_add_row('#tr_suspend');  return false;">Add new argument</a>
                            </td>
                        </tr>

                    </table>

                    <h4><input type="checkbox" {if $default.script_unsuspend}checked="checked"{/if} onclick="$('#show_unsuspend').toggle();"/> Unsuspend Addon: </h4>
                    <table border="0" cellspacing="0" cellpadding="6" width="100%" id="show_unsuspend" {if !$default.script_unsuspend}style="display: none" {/if}>

                        <tr>
                            <td width="160"><label >Script <a class="vtip_description" title="Select script from scripts directory"></a></label></td>
                            <td >
                                <select name="options[script_unsuspend]" id="script_unsuspend" style="width:100%;margin:0px">
                                    <option value="" {if !$default.script_unsuspend}selected="selected"{/if}>--select--</option>
                                    {foreach from=$scripts item=sc}
                                        <option {if $default.script_unsuspend == $sc }selected="selected"{/if}>{$sc}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >Arguments <a class="vtip_description" title="Enter arguments, one per box that will be passed during this function to script, you can use variables here. Empty arguments are not passed"></a></label></td>
                            <td>
                                <table border="0" cellspacing="0" cellpadding="3" id="tr_unsuspend" width="100%">

                                    {foreach from=$default.arguments_unsuspend item=attribute key=k}
                                        {if !$attribute}{break}{/if}
                                        <tr id="tr{$k}">
                                            <td ><input type="text" name="options[arguments_unsuspend][{$k}]" value="{$attribute|escape:'html':'utf-8'}" style="width:100%;" /></td>
                                            <td width="50"><a onclick="tr_remove_row(this);
                                                    return false" class="rembtn" href="#">Remove</a></td>
                                        </tr>
                                    {/foreach}
                                    <tr id="tr{if $default.arguments_unsuspend}{$k+1}{else}0{/if}">
                                        <td ><input type="text" name="options[arguments_unsuspend][{if $default.arguments_unsuspend}{$k+1}{else}0{/if}]" value="" style="width:100%;" /></td>

                                        <td width="50"><a onclick="tr_remove_row(this);
                                                return false" class="rembtn" href="#">Remove</a></td>
                                    </tr>
                                </table>
                                <a href="#" class="editbtn" onclick="tr_add_row('#tr_unsuspend');  return false;">Add new argument</a>
                            </td>
                        </tr>

                    </table>
                    <h4><input type="checkbox" {if $default.script_terminate}checked="checked"{/if} onclick="$('#show_terminate').toggle();"/> Terminate Addon: </h4>
                    <table border="0" cellspacing="0" cellpadding="6" width="100%" id="show_terminate" {if !$default.script_terminate}style="display: none" {/if}>

                        <tr>
                            <td width="160"><label >Script <a class="vtip_description" title="Select script from scripts directory"></a></label></td>
                            <td >
                                <select name="options[script_terminate]" id="script_terminate" style="width:100%;margin:0px">
                                    <option value="" {if !$default.script_terminate}selected="selected"{/if}>--select--</option>
                                    {foreach from=$scripts item=sc}
                                        <option {if $default.script_terminate == $sc }selected="selected"{/if}>{$sc}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >Arguments <a class="vtip_description" title="Enter arguments, one per box that will be passed during this function to script, you can use variables here. Empty arguments are not passed"></a></label></td>
                            <td>
                                <table border="0" cellspacing="0" cellpadding="3" id="tr_terminate" width="100%">

                                    {foreach from=$default.arguments_terminate item=attribute key=k}
                                        {if !$attribute}{break}{/if}
                                        <tr id="tr{$k}">
                                            <td ><input type="text" name="options[arguments_terminate][{$k}]" value="{$attribute|escape:'html':'utf-8'}" style="width:100%;" /></td>
                                            <td width="50"><a onclick="tr_remove_row(this);
                                                    return false" class="rembtn" href="#">Remove</a></td>
                                        </tr>
                                    {/foreach}
                                    <tr id="tr{if $default.arguments_terminate}{$k+1}{else}0{/if}">
                                        <td ><input type="text" name="options[arguments_terminate][{if $default.arguments_terminate}{$k+1}{else}0{/if}]" value="" style="width:100%;" /></td>

                                        <td width="50"><a onclick="tr_remove_row(this);
                                                return false" class="rembtn" href="#">Remove</a></td>
                                    </tr>
                                </table>
                                <a href="#" class="editbtn" onclick="tr_add_row('#tr_terminate');  return false;">Add new argument</a>
                            </td>
                        </tr>

                    </table>


                    <strong>Variables that can be used in arguments:</strong><br>
                    {literal}
                        <code>{$client.id}</code> Client ID <br>
                        <code>{$client.firstname}</code> Client First Name <br>
                        <code>{$client.lastname}</code> Client Last Name <br>
                        <code>{$client.phonenumber}</code> Client Phone Number <br>
                        <code>{$client.email}</code> Client Email Address <br>
                        <code>{$client.companyname}</code> Client Organization <br>
                        <code>{$client.address1}</code> Client Address 1 <br>
                        <code>{$client.address2}</code> Client Address 2 <br>
                        <code>{$client.city}</code> Client City <br>
                        <code>{$client.state}</code> Client State/Region <br>
                        <code>{$client.postcode}</code> Client Zip Code <br>
                        <code>{$client.country}</code> Client Country <br>


                        <code>{$product.id}</code> product id <br>
                        <code>{$product.name}</code> product name <br>
                        <code>{$server.name}</code> Connection from Settings->apps name <br>


                        <code>{$account.id}</code> account id <br>
                        <code>{$account.domain}</code> account hostname <br>
                        <code>{$account.username}</code> account username <br>
                        <code>{$account.password}</code> account password <br>
                        <code>{$account.newpassword}</code> new account password (for password change call)<br>
                        <code>{$account.status}</code> account status<br>
                        <code>{$account.firstpayment}</code> account first payment amount<br>
                        <code>{$account.total}</code> account recurring amount<br>
                        <code>{$account.billingcycle}</code> account billing cycle<br>
                        <code>{$account.next_due}</code> account next due date <br>
                        <code>{$account.next_invoice}</code> account next invoice date<br>

                        <code>{$forms.VARNAME}</code> value of Components::Forms  for related product - element with variable name: VARNAME, ie: <br>


                    {/literal}

                </div>

            </div>
            {literal}


            <script type="text/javascript">
                function tr_remove_row(el) {
                    var table = $(el).parents('table').eq(0);
                    if ($(table).find('tr').length > 2) {
                        $(el).parents('tr').eq(0).remove();
                    } else {
                        $(el).parents('tr').eq(0).find('input').val('');
                    }

                }
                function tr_add_row(table) {
                    var t = $(table+' tr:last');
                    if (!t.attr('id')) {
                        return false;
                    }
                    var prev = t.attr('id').replace(/[^0-9]/g, '');
                    next = parseInt(prev) + 1;
                    var nw = t.clone();
                    nw.attr('id', 'tr' + next);
                    nw.find('input, select').each(function () {
                        var n = $(this).attr('name');
                        n = n.replace("[" + prev + "]", "[" + next + "]");
                        $(this).attr('name', n).val('');
                    });

                    $(table).append(nw);
                    return false;
                }

                function load_onapp_section(section) {


                    var tab = $('#' + section + '_tab');
                    if (!tab.length)
                        return false;
                    var elements = tab.find('.tofetch').not('.fetched').not('.disabled');
                    if (!elements.length)
                        return false;
                }
                function append_onapp() {

                    $('#onappconfig2_').TabbedMenu({elem: '.onapptab', picker: '.breadcrumb-nav a', aclass: 'active', picker_id: 'nan1'});

                    $(document).ajaxStop(function () {
                        $('.onapp-preloader').hide();
                    });

                }
                {/literal}{if $_isajax}setTimeout('append_onapp()', 50);{else}appendLoader('append_onapp');{/if}{literal}
            </script>

            {/literal}

        </div>

    </td>
</tr>