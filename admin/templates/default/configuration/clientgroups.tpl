{if $action=='groups'}
    {if !$groups}
        <div id="blank_state" class="blank_state blank_news">
            <div class="blank_info">
                <h1>Organize your customers into groups</h1>
                Let your priority clients stand out with privileged discounts, automation settings and more - all
                possible from client groups.
                <br/>Note: All clients by default are assigned to "None" group
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd=clients&action=addgroup" style="margin-top:10px">
                    <span>Add custom client group</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {else}
        <div style="padding:15px;">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;"
                   class="whitetable">
                <tbody>
                <tr>
                    <th align="left" colspan="4">Current client groups</th>
                </tr>
                {foreach from=$groups item=group}
                    <tr class="havecontrols  ">
                        <td style="padding-left:10px" width="150"><a
                                    href="?cmd=clients&action=editgroup&id={$group.id}"
                                    class="isclient isclient-{$group.id}">{$group.name}</a></td>
                        <td>{$group.description}</td>
                        <td width="100">
                            <a href="?cmd=clients&list={$group.id}" class="fs11"
                               target="_blank">{$group.count} customers</a>
                        </td>
                        <td width="23" align="center">
                            <a class="delbtn"
                               href="?cmd=clients&action=groups&make=delete&id={$group.id}&security_token={$security_token}"
                               onclick="return confirm('Are you sure? Clients from under this group will be re-assigned to default group (None)')">Delete</a>
                        </td>
                    </tr>
                {/foreach}

                </tbody>
            </table>
            <a style="margin-top:10px" href="?cmd=clients&amp;action=addgroup" class="new_add new_menu">
                <span>Add custom client group</span></a>
            <div class="clear"></div>
        </div>
    {/if}

{else}
    <link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css"/>
{literal}
    <style>
        .sub-section {
            margin: 20px 0;
        }

        .sub-section:first-child {
            margin-top: 5px;
        }
        .sub-section-header {
            border-bottom: 1px solid #b9b9b9;
        }

        .toggle-override .contener {
            padding: 10px;
            background: #fafafa;
        }

        .shownice .toggle-override .contener {
            background: #fffed1
        }

        .contener .radio:first-child {
            margin-top: 0;
        }

        .option-line {
            margin: 5px 0;
        }

        .contener p:first-child, .option-line:first-child {
            margin-top: 0
        }

        .contener p:last-child, .option-line:last-child {
            margin-bottom: 0;
        }

    </style>
{/literal}
    <script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js?v={$hb_version}"></script>
    {if $action == 'overrides'}
        <div class="blu">
            <div class="menubar">
                <a href="?cmd=clients&action=show&id={$client.id}">
                    <strong>&laquo; Back to {$client|@profilelink:false:false:true}</strong>
                </a>
            </div>
        </div>
    {/if}
    <form action="" method="post" id="sme">
        <div id="newshelfnav" class="newhorizontalnav">
            <input type="hidden" name="picked_tab" id="picked_tab" value="{$picked_tab}"/>
            <div class="list-1">
                <ul>
                    {if $action !== 'overrides'}
                        <li>
                            <a href="#">General</a>
                        </li>
                    {/if}

                    <li>
                        <a href="#" rel="billing">Billing <span
                                    class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}"
                                    style="display: none">0</span></a>
                    </li>
                    <li>
                        <a href="#" rel="automation">Automation <span
                                    class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}"
                                    style="display: none">0</span></a>
                    </li>
                    <li>
                        <a href="#" rel="orders">Orders <span
                                    class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}"
                                    style="display: none">0</span></a>
                    </li>
                    <li>
                        <a href="#" rel="discounts">Discounts <span
                                    class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}"
                                    style="display: none">0</span></a>
                    </li>
                    <li class="last">
                        <a href="#" rel="support">Support & Notifications <span
                                    class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}"
                                    style="display: none">0</span></a>
                    </li>
                </ul>
            </div>
        </div>

        <div style="padding:15px;">
            {if $action !== 'overrides'}
                <div class="sectioncontent">
                    <table width="100%" cellspacing="0" cellpadding="6">
                        <tbody>
                        <tr>
                            <td width="160" align="right"><strong>Name</strong></td>
                            <td class="editor-container">
                                <input style="font-size: 16px !important; font-weight: bold;" class="inp" size="50"
                                       name="name" value="{$groupx.name}"/>
                            </td>
                        </tr>

                        <tr>
                            <td width="160" align="right"><strong>Group color<a class="vtip_description"
                                                                                title="Group members will be listed using this color"></a></strong>
                            </td>
                            <td class="editor-container">
                                <input id="colorSelector_i" type="hidden" class="w250" size="7" name="color"
                                       value="{$groupx.color}" style="margin-bottom:5px"/>
                                <div id="colorSelector"
                                     style="border: 2px solid #ddd; cursor: pointer; float: left; height: 15px;margin: 6px 0 5px 8px;position:relative; width: 40px; background: {$groupx.color};"
                                     onclick="$('#colorSelector_i').click()">
                                    <div style="position:absolute; bottom:0; right: 0; color:white; background:url('{$template_dir}img/imdrop.gif') no-repeat 3px 4px #ddd; height:10px; width:10px"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="160" align="right"><strong>Admin-only description</strong></td>
                            <td class="editor-container">
                                <textarea name="description"
                                          style="width:400px;height:50px">{$groupx.description}</textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            {/if}


            <div class="sectioncontent" style="display:none">
                {if $action == 'overrides'}
                    {include file="configuration/clientgroup/generic.tpl"
                    settings=$settings|@filter_tags:'billing,tax'}
                {/if}
                <div class="sub-section">
                    <h1 class="sub-section-header">Invoice</h1>
                    {include file="configuration/clientgroup/generic.tpl"
                    settings=$settings|@filter_tags:'billing,invoice'}
                </div>

                <div class="sub-section">
                    <h1 class="sub-section-header">Payment & Credit</h1>
                    {include file="configuration/clientgroup/generic.tpl"
                    settings=$settings|@filter_tags:'billing,payment'}
                    {include file="configuration/clientgroup/generic.tpl"
                    settings=$settings|@filter_tags:'billing,credit'}
                </div>

                <div class="sub-section">
                    <h1 class="sub-section-header">Templates</h1>
                    {include file="configuration/clientgroup/generic.tpl"
                    settings=$settings|@filter_tags:'billing,template'}
                </div>

            </div>

            <div class="sectioncontent" style="display:none">

                {include file="configuration/clientgroup/generic.tpl"
                settings=$settings|@filter_tags:'automation,general'}

                {include file="configuration/clientgroup/generic.tpl"
                settings=$settings|@filter_tags:'automation,hosting' section='Services'}

                {include file="configuration/clientgroup/generic.tpl"
                settings=$settings|@filter_tags:'automation,domain' section='Domains'}

                {include file="configuration/clientgroup/generic.tpl"
                settings=$settings|@filter_tags:'automation,invoice' section="Invoice"}

                {include file="configuration/clientgroup/generic.tpl"
                settings=$settings|@filter_tags:'automation,overdue' section="Overdue"}

            </div>

            <div class="sectioncontent" style="display:none">
                {include file="configuration/clientgroup/generic.tpl"
                settings=$settings|@filter_tags:'orders'}
            </div>

            <div class="sectioncontent" style="display:none">
                {include file="configuration/clientgroup/generic.tpl"
                settings=$settings|@filter_tags:'discount'}

                <div class="panel panel-default">
                    <div class="panel-heading">Category / product specific discount</div>
                    <table class="table">
                        <tbody id="product-discounts">
                        {foreach from=$groupx.discounts item=discount name=fl}
                            <tr id="{$discount.key}" class="dis_{$discount.key}" data-type="{$discount.domain_type}">
                                <td style="padding-left:10px">{$discount.name}
                                    <input type="hidden" name="discounts[{$smarty.foreach.fl.index}][discount]"
                                           value="{$discount.discount}"/>
                                    <input type="hidden" name="discounts[{$smarty.foreach.fl.index}][type]"
                                           value="{$discount.type}"/>
                                    <input type="hidden" name="discounts[{$smarty.foreach.fl.index}][product_id]"
                                           value="{$discount.key}"/>
                                    <input type="hidden" name="discounts[{$smarty.foreach.fl.index}][domain_type]"
                                           value="{$discount.domain_type}"/>
                                </td>
                                <td width="140">{$discount.domain_type}</td>
                                <td width="140">{$discount.discount} {if $discount.type=='percent'}%{/if}</td>
                                <td width="40"><a href="#" class="btn btn-default remove-entry btn-sm">Remove</a>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>

                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-5">
                                <label>New discount category / product</label>
                                <select class="form-control" id="product_id" data-chosen>
                                    {foreach from=$services item=category}
                                        {if $category.products}
                                            <optgroup label="{$category.name}">
                                                <option value="cat_{$category.id}" data-ctype="{$category.ctype}">{$category.name} - Entire category
                                                </option>
                                                {foreach from=$category.products item=prod}
                                                    <option value="prod_{$prod.id}" data-ctype="{$category.ctype}">{$category.name}
                                                        - {$prod.name}</option>
                                                {/foreach}
                                            </optgroup>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group col-md-4 domain_type_div">
                                <label>Apply to</label>
                                <select class="form-control" id="domain_type" data-chosen multiple>
                                    <option>Register</option>
                                    <option>Transfer</option>
                                    <option>Renew</option>
                                </select>
                            </div>
                            <div class="form-group col-md-1 discount_div">
                                <label>Discount</label>
                                <input type="text" class="form-control" value="0.00" size="5" id="discount_value">
                            </div>
                            <div class="form-group col-md-1 type_div">
                                <label>Type</label>
                                <select class="form-control" id="discount_type">
                                    <option value="fixed">Fixed</option>
                                    <option value="percent">Percent</option>
                                </select>
                            </div>
                            <div class="form-group col-md-1">
                                <label class="visible-md-block visible-lg-block">&nbsp;</label>
                                <a class="btn btn-default add-product-dicount" href="#">Add</a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="sectioncontent" style="display:none">
                <div class="sub-section">
                    <h1 class="sub-section-header">Notification</h1>
                    {include file="configuration/clientgroup/generic.tpl"
                    settings=$settings|@filter_tags:'notification'}

                </div>
                <div class="sub-section">
                    <h1 class="sub-section-header">Support</h1>
                    {include file="configuration/clientgroup/generic.tpl"
                    settings=$settings|@filter_tags:'support'}


                    <div class="panel panel-default">
                        <div class="panel-heading">Auto CC emails to ticket</div>
                        <div class="panel-body">
                            <p>
                                Emails listed below will be automatically added to new tickets assigned to
                                client{if $action !== 'overrides'}s from this group{/if}.
                            </p>
                            <p id="add-cc-body"></p>
                            <input type="hidden" name="settings[SupportCC]"
                                   value="{$configuration.SupportCC|escape}" id="cc-form">
                            <div class="input-group col-lg-3 col-md-4 col-sm-6">
                                <input type="email" id="add-cc-form" class="form-control"/>
                                <span class="input-group-btn">
                                <button class="btn btn-default" id="add-cc-btn"><i class="fa fa-plus"></i></button>
                            </span>
                            </div>
                        </div>
                    </div>


                    <div class="panel panel-default">
                        <div class="panel-heading">Override Support Rates</div>
                        <table class="table">
                            <tbody id="support-rates">
                            {foreach from=$supportrates item=rate}
                                {if $configuration.SupportRates[$rate.id]}
                                    <tr id="rate_{$rate.id}">
                                        <td style="padding-left:10px">
                                            {$rate.name} ({$rate.price|price}{if $rate.type == 'hourly'} per Hour{/if})
                                            <input type="hidden" name="settings[SupportRates][{$rate.id}]"
                                                   value="{$configuration.SupportRates[$rate.id]}"/>
                                        </td>
                                        <td width="140">{$configuration.SupportRates[$rate.id]} {$currency.iso} {$rate.type|capitalize}</td>
                                        <td width="40"><a href="#"
                                                          class="btn btn-default remove-entry btn-sm">Remove</a></td>
                                    </tr>
                                {/if}
                            {/foreach}
                            </tbody>
                        </table>

                        <div class="panel-body">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>Support Rate</label>
                                    <select class="form-control" id="rate_id" data-chosen>
                                        {foreach from=$supportrates item=rate}
                                            <option value="{$rate.id}"
                                                    data-type="{$rate.type|capitalize}"
                                                    data-price="{$rate.price}">
                                                {$rate.name}
                                                ({$rate.price|price}{if $rate.type == 'hourly'} per Hour{/if})
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="form-group col-md-3">
                                    <label>Price</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" value="0.00"
                                               size="5" id="rate_value">
                                        <span class="input-group-addon" id="currency-iso">{$currency.iso}</span>
                                    </div>
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="visible-md-block visible-lg-block">&nbsp;</label>
                                    <a class="btn btn-default add-support-rate" href="#">Add</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary">
                {$lang.savechanges}
            </button>
            <div class="clear"></div>
        </div>
        <input type="hidden" name="make" value="s"/>
        {securitytoken}
    </form>
{/if}

<script type="text/javascript" src="{$template_dir}js/clientgroups.js?v={$hb_version}"></script>
{literal}
    <script type="text/x-handlebars-template" id="product-discount">
        <tr id="{{product_id}}" class="dis_{{product_id}}" data-type="{{domain_type}}">
            <td style="padding-left:10px">
                {{name}}
                <input type="hidden" name="discounts[{{id}}][discount]" value="{{discount}}"/>
                <input type="hidden" name="discounts[{{id}}][type]" value="{{type}}"/>
                <input type="hidden" name="discounts[{{id}}][product_id]" value="{{product_id}}"/>
                <input type="hidden" name="discounts[{{id}}][domain_type]" value="{{domain_type}}"/>
            </td>
            <td width="140">{{domain_type}}</td>
            <td width="140">{{discount}} {{typeunit}}</td>
            <td width="40">
                <a href="#" class="btn btn-default remove-entry btn-sm">Remove</a>
            </td>
        </tr>
    </script>
    <script type="text/x-handlebars-template" id="suport-rate">
        <tr id="rate_{{id}}">
            <td style="padding-left:10px">
                {{name}}
                <input type="hidden" name="settings[SupportRates][{{rate_id}}]" value="{{price}}"/>
            </td>
            <td width="140">{{price}} {{type}}</td>
            <td width="40">
                <a href="#" class="btn btn-default remove-entry btn-sm">Remove</a>
            </td>
        </tr>
    </script>
{/literal}

