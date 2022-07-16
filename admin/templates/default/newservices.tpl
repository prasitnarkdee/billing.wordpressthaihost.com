<input type="hidden" name="type" value="{$product.type}">

<input type="hidden" value="{$product.visible}" name="visible" id="prod_visibility"/>
<input type="hidden" value="{$product.category_id}" name="category_id" id="category_id"/>
<input type="hidden" value="{$product.id}" name="product_id_" id="product_id"/>

<table width="100%" cellspacing="0" cellpadding="10" border="0">

    <tr>
        <td colspan="2" style="padding:0px;">
            <div class="newhorizontalnav" id="newshelfnav">
                <div class="list-1">
                    <ul>
                        <li>
                            <a href="#"><span class="ico money">{$lang.general_tab}</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico plug">{$lang.connectapp_tab}</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico gear">{$lang.automation_tab}</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico gear">{$lang.Emails}</span></a>
                        </li>
                        <li id="components_tab">
                            <a href="#"><span class="ico globe">Components</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico formn">{$lang.widgets_tab}</span></a>
                        </li>
                        <li class="last">
                            <a href="#"><span class="ico app">{$lang.other_tab}</span></a>
                        </li>
                        {if $modulequotas}
                            <li class="last">
                                <a href="#"><span class="ico app">{$lang.quotas_tab}</span></a>
                            </li>
                        {/if}

                    </ul>
                </div>
                <div class="list-2">
                    <div class="subm1 haveitems">
                        <ul>
                            {if $product.visible=='1'}
                                <li><a href="#" onclick=" $('#prod_visibility').val('0');
                                        $('#hiddenmsg').show();
                                        saveProductFull();"><span>{$lang.hide_product}</span></a></li>
                                <li><a href="#" onclick=" $('#prod_visibility').val(-1);
                                        $('#archivemsg').show();
                                        saveProductFull();"><span>Archive</span></a></li>
                            {/if}
                            <li>
                                <a href="?cmd=services&action=productexport&id={$product_id}"><span>Export
                                        Product</span></a>
                            </li>
                            <li><a href="#" onclick="$(this).hide();
                                    $('#change_orderpage').ShowNicely().show();
                                    return false"><span>{$lang.change_orderpage}</span></a></li>
                            {if !($product.p_options & 128)}
                                <li><a href="#" onclick="$(this).hide();
                                        $('.stockcontrol').ShowNicely().find('#stock-control-check').attr('checked', 'checked');"><span>{$lang.enable_stock}</span></a>
                                </li>
                            {/if}
                            {if $configuration.EnableProRata != 'on'}
                                <li><a href="#" onclick="$('#prorated_ctrl').show();
                                        $('#prorata_on').click();
                                        $(this).hide();
                                        return false"><span>{$lang.new_EnableProRata}</span></a></li>
                            {/if}
                            {if $product.timevalidation=='1' && !($product.valid_to && $product.valid_to!='0000-00-00') && !($product.valid_from && $product.valid_from!='0000-00-00')}
                                <li><a href="#" onclick="$(this).hide();
                                        $('.timecontrol').ShowNicely();
                                        return false;"><span>Enable time based validation</span></a></li>
                            {/if}
                        </ul>
                        <div class="right" style="color:#999999;padding-top:5px">
                            {if $product.id!='new'}
                                <strong>{$lang.cartlink}</strong>
                                <span>{$system_url}?cmd=cart&amp;action=add&amp;id={$product.id}</span>
                                <a style="padding: 0 2px;" class="btn btn-sm copy-link" data-link="{$system_url}?cmd=cart&amp;action=add&amp;id={$product.id}" onclick="return false;"><i class="fa fa-files-o f-a" aria-hidden="true"></i></a>
                                <a style="padding: 0 2px;" class="btn btn-sm" href="{$system_url}?cmd=cart&action=add&id={$product.id}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                            {/if}
                        </div>
                        <script type="text/javascript" src="{$template_dir}js/clipboard.js"></script>
                        {literal}
                            <script>
                                new Clipboard('.copy-link', {
                                    text: function (trigger) {
                                        var link = $(trigger).data('link');
                                        var tooltiptitle = 'Copied';
                                        $(".tooltip").tooltip("destroy");
                                        $(trigger).tooltip({title:tooltiptitle,trigger:'manual',animation:false}).tooltip('show');
                                        setTimeout(function(){
                                            $(trigger).tooltip('hide');
                                        }, 3000);
                                        return link;
                                    }
                                });
                            </script>
                        {/literal}
                        <div class="clear"></div>
                    </div>
                    <div class="subm1" style="display:none"></div>
                    <div class="subm1 haveitems" style="display:none">
                        <ul>
                            <li>
                                <a href="#" onclick="return HBTasklist.assignNew({$product_id}, 'services');">
                                    <span class="addsth"><strong>{$lang.addcustomautomation}</strong></span>
                                </a>
                            </li>
                            {if $otherproducts}
                                <li>
                                    <a href="#" id="premadeautomationswitch" >
                                        <span class="addsth">{$lang.copyautomation}</span></a>
                                </li>
                            {/if}
                        </ul>
                    </div>
                    <div class="subm1" style="display:none"></div>

                    <div class="subm1 haveitems" style="display:none" id="components_menu">
                        <ul class="list-3">
                            <li><a href="#"><span><b>{$lang.forms_tab}</b></span></a></li>
                            <li><a href="#"><span><b>{$lang.addons_tab}</b></span></a></li>
                            <li><a href="#"><span><b>{$lang.domains_tab}</b></span></a></li>
                            <li><a href="#"><span><b>Sub-products</b></span></a></li>
                            {foreach from=$extra_tabs item=etab key=ekey name=tabloop}
                                <li>
                                    <a href="#"><span><b>{if $lang[$ekey]}{$lang[$ekey]}{else}{$ekey}{/if}</b></span></a>
                                </li>
                            {/foreach}
                        </ul>


                    </div>
                    <div class="subm1 {if $product.id!='new'}haveitems{/if}" style="display:none">
                        {if $product.id!='new'}
                            <ul>
                                <li>
                                    <a href="#"
                                       onclick="return HBWidget.addCustomWidgetForm();"><span><b>{$lang.assign_custom_widg}</b></span></a>
                                </li>

                                {if count($widgets)>1}
                                    <li>
                                        <a href="#"
                                           onclick="return HBWidget.enableAllWidgets();"><span>{$lang.enable_all_widgets}</span></a>
                                    </li>
                                    <li>
                                        <a href="#"
                                           onclick="return HBWidget.disableAllWidgets();"><span>{$lang.disable_all_widgets}</span></a>
                                    </li>
                                {/if}

                                <li>
                                    <a href="#" onclick="return HBWidget.refreshWidgetView();"><span>Refresh available
                                            functions</span></a>
                                </li>
                            </ul>
                        {/if}
                    </div>
                    <div class="subm1 {if $product.id!='new'}haveitems{/if}" style="display:none">
                        {if $product.id!='new'}
                            <ul>
                                {if !$haveupgrades}
                                    <li>
                                    <a href="#" onclick="$('#upgradesopt').ShowNicely();
                                                    $(this).hide();
                                                    return false;"><span>{$lang.enable_upgrades}</span></a></li>{/if}

                            </ul>
                        {/if}
                    </div>
                    <div class="subm1 haveitems" >
                        <ul>
                            <li>
                                <a href="#" onclick="return HBTasklist.assignNew({$product_id}, 'metrics');">
                                    <span class="addsth"><strong>{$lang.addcustomautomation}</strong></span>
                                </a>
                            </li>
                            {if $otherproducts}
                                <li>
                                    <a href="#" class="copy_metrics">
                                        <span class="addsth">Copy product metrics</span>
                                    </a>
                                </li>
                            {/if}
                        </ul>
                    </div>
                </div>
            </div>
            <div class="imp_msg"
                 style="{if $product.visible!='0'}display:none{/if};border-top:0px;border-left:0px;border-right:0px;border-bottom-width:1px;"
                 id="hiddenmsg">
                <strong>{$lang.hidden_product_note}.</strong>
                <a class="editbtn" onclick=" $('#prod_visibility').val('1');
                                $('#hiddenmsg').hide();
                                saveProductFull();
                                return false;" href="#">{$lang.show_product}</a>
            </div>
            <div class="imp_msg" style="margin-top:10px;{if $product.visible!=-1}display:none{/if}" id="archivemsg">
                <strong>Note: This product is archived, it is not available in listsings and can't be
                    purchased.</strong>
                <a class="editbtn" onclick=" $('#prod_visibility').val('1');
                                $('#archivemsg').hide();
                                saveProductFull();
                                return false;" href="#">Restore product</a>
            </div>
            <div class="imp_msg" style="margin-top:10px;{if $product.visible!=-2}display:none{/if}" id="archivemsg">
                <strong>Note: This product is Admin-Only, customer will not see any service using this product in client portal</strong>
                <a class="editbtn" onclick=" $('#prod_visibility').val('1');
                                $('#archivemsg').hide();
                                saveProductFull();
                                return false;" href="#">Restore product</a>
            </div>
        </td>
    </tr>
    <tr>

        <td valign="top" class="nicers" style="border:none;" colspan="2">
            <table width="100%" cellspacing="0" cellpadding="6">
                <tbody class="sectioncontent">

                    <tr>
                        <td width="160" align="right"><strong>{$lang.productname}</strong></td>
                        <td class="editor-container">

                            {if $product.id!='new'}
                                <div class="org-content havecontrols"><span
                                            style=" font-size: 16px !important; font-weight: bold;"
                                            class="iseditable">{$product.tag_name}</span> <a href="#"
                                                                                             class="editbtn controls iseditable">{$lang.Edit}</a>
                                </div>
                                <div class="editor">{hbinput value=$product.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="50" name="name"}
                                </div>
                            {else}
                                {hbinput value=$product.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="50" name="name"}
                            {/if}

                        </td>
                    </tr>
                    <tr>
                        <td width="160" align="right"><strong>{$lang.product_code}</strong></td>
                        <td class="editor-container">

                            {if $product.id!='new'}
                                <div class="org-content havecontrols"><span
                                            style=" font-size: 16px !important; font-weight: bold;"
                                            class="iseditable">{$product.code}</span> <a href="#"
                                                                                             class="editbtn controls iseditable">{$lang.Edit}</a>
                                </div>
                                <div class="editor"><input class="havecontrols" type="text" name="code" value="{$product.code}">
                                </div>
                            {else}
                                <input class="havecontrols" type="text" name="code">
                            {/if}

                        </td>
                    </tr>

                    {if $product.id!='new'}
                        <tr style="display:none" id="change_orderpage">
                            <td align="right"><strong>{$lang.OrderPage}</strong></td>
                            <td>
                                <select name="change_orderpage" onchange="this.form.submit()">
                                    {foreach from=$categories item=cat}
                                        {if $cat.contains === 'products'}
                                            <option value="{$cat.id}" {if $cat.id == $product.category_id}selected="selected"{/if}>
                                                {if $cat.parent_id}
                                                    {foreach from=$categories item=catt}
                                                        {if $catt.id === $cat.parent_id}
                                                            {$catt.name}:
                                                        {/if}
                                                    {/foreach}
                                                {/if}
                                                {$cat.name}
                                            </option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}

                    {include file='service_description.tpl'}
                    <tr>
                        <td valign="top" width="160" align="right"><strong>{$lang.Price}</strong></td>
                        <td id="priceoptions">
                            {foreach from=$supported_billingmodels item=bm name=boptloop}
                                <a href="#"
                                   class="billopt {if $smarty.foreach.boptloop.first}bfirst{/if} {if $product.paytype==$bm}checked{/if}"
                                   {if $product.paytype!=$bm}style="display:none"{/if}
                                   onclick='return switch_t2(this, "{$bm}");'>{if $lang[$bm]}{$lang[$bm]}{else}{$bm}{/if}</a>
                                <input type="radio" value="{$bm}" name="paytype"
                                       {if $product.paytype==$bm}checked="checked"{/if} id="{$bm}"
                                       style="display:none"/>
                            {/foreach}

                            <a href="#" class="editbtn" onclick="$(this).hide();
                                            $(this).parent().find('.billopt').show();
                                            return false;">
                                {$lang.Change}
                            </a>
                            {foreach from=$supported_billingmodels item=bm name=boptloop}
                                {include file="productbilling_`$bm`.tpl"}
                            {/foreach}
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" align="right"><strong>{$lang.taxproduct}</strong></td>
                        <td>
                            <label>
                                <input type="radio" {if $product.tax!='1'}checked{/if}
                                       name="tax" value="0" data-toggle/>
                                <strong>{$lang.no}</strong>
                            </label>
                            <label>
                                <input type="radio" {if $product.tax=='1'}checked{/if}
                                       name="tax" value="1" data-toggle="#tax_group"/>
                                <strong>{$lang.yes}</strong>
                            </label>

                            <div class="p5" id="tax_group" {if $product.tax!='1'}style="display: none;"{/if}>
                                {$lang.taxgroup}:
                                <select name="tax_group_id">
                                    {foreach from=$tax_groups item=taxg}
                                        <option value="{$taxg.id}" {if $product.tax_group_id == $taxg.id}selected{/if}>
                                            {$taxg.name}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr class="stockcontrol" {if !($product.p_options & 128)}style="display:none"{/if}>
                        <td valign="top" align="right"><strong>{$lang.stockcontrol}</strong></td>
                        <td>
                            <input type="checkbox" name="p_options[]" value="128"
                                   {if $product.p_options & 128}checked{/if}  id="stock-control-check"/>
                            <div class="p5" id="sstoc" style="margin-top: 10px; border: 1px solid rgb(204, 204, 204);">
                                <div>
                                    {$lang.quantityinstock}
                                    <input type="text" value="{$product.stock}" size="4" name="qty" class="inp"/>
                                    (Used {$product.qty})
                                </div>
                                <div>
                                    <input type="hidden" name="config[ReturnToStockOnTerminate]" value="0"/>
                                    <input type="checkbox" value="1" name="config[ReturnToStockOnTerminate]"
                                           {if $configuration.ReturnToStockOnTerminate == '1'}checked="checked"{/if} />
                                    Return items to stock when service is terminated
                                </div>
                                <div>
                                    Notify about low stock when the number of item drops bellow
                                    <input type="text" value="{$configuration.NotifyLowStock}" size="4"
                                           name="config[NotifyLowStock]" class="inp"/>

                                </div>
                                <div class="clear"></div>
                            </div>
                        </td>
                    </tr>
                    <tr class="stockcontrol" {if !($product.p_options & 128)}style="display:none"{/if} >
                        <td style="vertical-align: top; padding-top: 15px; text-align: right" ><strong>{$lang.stock_when}</strong></td>
                        <td>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="config[StockProductVisibility]" value="follow" {if $configuration.StockProductVisibility == 'follow' || !$configuration.StockProductVisibility}checked{/if}>
                                    {$lang.stock_follow}
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="config[StockProductVisibility]" value="hide" {if $configuration.StockProductVisibility == 'hide'}checked{/if}>
                                    {$lang.stock_hide_product}
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="config[StockProductVisibility]" value="show" {if $configuration.StockProductVisibility == 'show'}checked{/if}>
                                    {$lang.stock_show_product}
                                </label>
                            </div>
                        </td>
                    </tr>

                    {include file="services/prorata.tpl"}

                    {if $product.id!='new'}
                        <tr>
                            <td align="right"><strong>Tags</strong></td>
                            <td>{include file='services/tags.tpl'}</td>
                        </tr>
                    {/if}
                </tbody>


                <tbody class="sectioncontent" style="display:none">
                    <tr>
                        <td colspan="2">
                            <div id="module_tab_switcher" class="clearfix"
                                 {if count($product.modules) <= 1}style="display:none"{/if}>
                                <input type="hidden" name="module_config_active" value="0"/>

                                <ul class="nav nav-tabs" id="module_tab_pick_container">
                                    {foreach from=$product.modules item=module key=kl}
                                        <li class="{if $module.main}active{/if}">
                                            <a class="module_tab_pick" href=""
                                               data-key="{$kl}">
                                                {if $module.main}Main product App
                                                {else}Additional App{/if}
                                                : <span>{$module.modname}</span>
                                            </a>
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                            <div id="module_config_container" class="clearfix">
                                {foreach from=$product.modules item=module key=kl}
                                    {include file='services/ajax.multimodules.tpl' options=$module.options default=$module.default}
                                {/foreach}
                            </div>
                        </td>

                    </tr>


                </tbody>
                <tbody id="billingsopt" class="sectioncontent" style="display:none">
                    <tr>
                        <td colspan="2" style="padding:0px">
                            <table class="editor-container" cellspacing="0" cellpadding="6" width="100%">
                                <tr style="display: none;">
                                    <td colspan="2">
                                        <div id="import-tasks" hidden bootbox
                                             data-btntitle="Copy"
                                             data-title="Copy Automation tasks"
                                             data-btnclass="btn-primary">
                                            <div class="form-group">
                                                <label>Product</label>
                                                <input type="hidden" value="1" data-name="copyautomation"/>
                                                <select class="form-control" data-name="copy_from">
                                                                {foreach from=$otherproducts item=oth}
                                                        <option value="{$oth.id}">
                                                            {$oth.catname} - {$oth.name}
                                                        </option>
                                                                {/foreach}
                                                            </select>
                                                <div class="help-block">
                                                    Select product to copy automation task from.
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" id="tasklistloader">
                                        {include file='ajax.tasklist.tpl'}
                                    </td>
                                </tr>

                                <tr class="odd">
                                    <td align="right" valign="top" width="200"><strong>{$lang.auto_create}</strong></td>

                                    <td id="automateoptions">
                                        <input type="radio" value="0" name="autosetup2"
                                               {if $product.autosetup=='0' || $product.autosetup=='1'}checked="checked"{/if}
                                               id="autooff" onclick="$('#autosetup_opt').hide();
                                                                           $('#autooff_').click();"/>
                                        <label for="autooff"><b>{$lang.no}</b></label>

                                        <input type="radio" value="1" name="autosetup2"
                                               {if $product.autosetup!='0' && $product.autosetup!='1'}checked="checked"{/if}
                                               id="autoon" onclick="$('#autosetup_opt').ShowNicely();
                                                                           $('#autoon_').click();"/>
                                        <label for="autoon"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="autosetup_opt"
                                             style="{if $product.autosetup=='0' || $product.autosetup=='1'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            <input type="radio" style="display:none"
                                                   {if $product.autosetup=='0' || $product.autosetup=='1'}checked="checked"{/if}
                                                   value="0" name="autosetup" id="autooff_"/>
                                            <input type="radio" {if $product.autosetup=='3'}checked="checked"{/if}
                                                   value="3"
                                                   name="autosetup" id="autosetup3"/>
                                            <label for="autosetup3">{$lang.whenorderplaced}</label><br/>
                                            <input type="radio" {if $product.autosetup=='2'}checked="checked"{/if}
                                                   value="2"
                                                   name="autosetup" id="autoon_"/>
                                            <label for="autoon_">{$lang.whenpaymentreceived}</label><br/>
                                            {*}<input type="radio" {if $product.autosetup=='1'}checked="checked"{/if} value="1" name="autosetup" id="autosetup1"/>
                                            <label for="autosetup1">{$lang.whenmanualaccept}</label><br />{*}
                                            <input type="radio" {if $product.autosetup=='4'}checked="checked"{/if}
                                                   value="4"
                                                   name="autosetup" id="autosetup4"/>
                                            <label for="autosetup4">{$lang.procesbycron}</label>
                                            <div class="clear"></div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td width="200" valign="top" align="right"><strong>Automatic Upgrades</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.EnableAutoUpgrades == 'off'}checked{/if}
                                               name="config_EnableAutoUpgrades" value="off"
                                               onclick="$('#upgrades_options').hide(); $('#auto_up_off').click();"
                                               id="upgrades_off"/>
                                        <label for="upgrades_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.EnableAutoUpgrades !== 'off'}checked{/if}
                                               name="config_EnableAutoUpgrades" value="on"
                                               onclick="$('#upgrades_options').ShowNicely(); $('#auto_up_pay').click();"
                                               id="upgrades_on"/>
                                        <label for="upgrades_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="upgrades_options" style="{if $configuration.EnableAutoUpgrades == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            <input type="radio" {if $configuration.EnableAutoUpgrades === 'off'}checked{/if}
                                                   name="config[EnableAutoUpgrades]" id="auto_up_off"
                                                   value="off"  style="display:none"

                                            />
                                            <input type="radio" {if $configuration.EnableAutoUpgrades === 'order'}checked{/if}
                                                   name="config[EnableAutoUpgrades]" id="auto_up_order"
                                                   value="order"
                                            />
                                            <label for="auto_up_order">
                                                {$lang.whenorderplaced}
                                            </label>
                                            <br/>
                                            <input type="radio" {if $configuration.EnableAutoUpgrades === 'on'}checked{/if}
                                                   name="config[EnableAutoUpgrades]"  id="auto_up_pay" value="on"/>
                                            <label for="auto_up_pay">
                                                After receiving payment
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="odd">
                                    <td width="200" valign="top" align="right"><strong>Automatic Renew</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.EnableAutoRenewService == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoRenewService]" value="off"
                                               onclick="$('#renew_options').hide();"
                                               id="renew_off"/>
                                        <label for="renew_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.EnableAutoRenewService == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoRenewService]" value="on"
                                               onclick="$('#renew_options').ShowNicely();"
                                               id="renew_on"/>
                                        <label for="renew_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="renew_options"
                                             style="{if $configuration.EnableAutoRenewService == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            Renew account automatically after receiving payment
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200" valign="top" align="right">
                                        <strong>{$lang.new_EnableAutoSuspension}</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.EnableAutoSuspension == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoSuspension]" value="off"
                                               onclick="$('#suspension_options').hide();"
                                               id="suspend_off"/>
                                        <label for="suspend_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.EnableAutoSuspension == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoSuspension]" value="on"
                                               onclick="$('#suspension_options').ShowNicely()"
                                               id="suspend_on"/>
                                        <label for="suspend_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="suspension_options"
                                             style="{if $configuration.EnableAutoSuspension == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            {$lang.new_EnableAutoSuspension1}
                                            <input type="text" size="3" value="{$configuration.AutoSuspensionPeriod}"
                                                   name="config[AutoSuspensionPeriod]" class="inp config_val"/>
                                            {$lang.new_EnableAutoSuspension2}

                                        </div>
                                    </td>
                                </tr>

                                <tr class="odd">
                                    <td width="200" valign="top" align="right">
                                        <strong>{$lang.new_EnableAutoUnSuspension}</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.EnableAutoUnSuspension == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoUnSuspension]" value="off"
                                               onclick="$('#unsuspension_options').hide();"
                                               id="unsuspend_off"/>
                                        <label for="unsuspend_off"><b>{$lang.no}</b></label>
                                        <input type="radio"
                                               {if $configuration.EnableAutoUnSuspension == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoUnSuspension]" value="on"
                                               onclick="$('#unsuspension_options').ShowNicely();"
                                               id="unsuspend_on"/>
                                        <label for="unsuspend_on"><b>{$lang.yes}</b></label>
                                        <div class="p5" id="unsuspension_options"
                                             style="{if $configuration.EnableAutoUnSuspension == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            {$lang.new_EnableAutoUnSuspension1}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200" valign="top" align="right">
                                        <strong>{$lang.new_EnableAutoTermination}</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.EnableAutoTermination == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoTermination]" value="off"
                                               onclick="$('#termination_options').hide();"
                                               id="termination_off"/>
                                        <label for="termination_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.EnableAutoTermination == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoTermination]" value="on"
                                               onclick="$('#termination_options').ShowNicely();"
                                               id="termination_on"/>
                                        <label for="termination_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="termination_options"
                                             style="{if $configuration.EnableAutoTermination == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            {$lang.new_EnableAutoTermination1}
                                            <input type="text" size="3" value="{$configuration.AutoTerminationPeriod}"
                                                   name="config[AutoTerminationPeriod]" class="inp config_val"/>
                                            {$lang.new_EnableAutoTermination2}
                                            <br/>
                                            <input type="radio"
                                                   {if $configuration.AutoCancelUnpaidInvoices == 'off'}checked="checked"{/if}
                                                   name="config[AutoCancelUnpaidInvoices]" value="off"/> <b>No</b>
                                            <input type="radio" value="on" name="config[AutoCancelUnpaidInvoices]"
                                                   {if $configuration.AutoCancelUnpaidInvoices == 'on'}checked="checked"{/if} />
                                            <b>Yes</b>
                                            Automatically cancel related unpaid invoices
                                        </div>
                                    </td>
                                </tr>

                                <tr class="odd">
                                    <td width="200" valign="top" align="right">
                                        <strong>{$lang.AutoCancelUnpaidOrders}</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.EnableAutoCancelUnpaidOrders == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoCancelUnpaidOrders]" value="off"
                                               onclick="$('#cancel_order_options').hide();"
                                               id="autocancel_off"/>
                                        <label for="autocancel_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.EnableAutoCancelUnpaidOrders == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoCancelUnpaidOrders]" value="on"
                                               onclick="$('#cancel_order_options').ShowNicely()"
                                               id="autocancel_on"/>
                                        <label for="autocancel_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="cancel_order_options"
                                             style="{if $configuration.EnableAutoCancelUnpaidOrders == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            {$lang.AutoCancelUnpaidOrdersDesc1}
                                            <input type="text" size="3" value="{$configuration.AutoCancelUnpaidOrdersPeriod}"
                                                   name="config[AutoCancelUnpaidOrdersPeriod]" class="inp config_val"/>
                                            {$lang.AutoCancelUnpaidOrdersDesc2}

                                        </div>
                                    </td>
                                </tr>


                                <tr>
                                    <td style="vertical-align: top; text-align: right">
                                        <strong>{$lang.InvoiceGeneration} </strong>
                                    </td>
                                    <td>
                                        <input type="radio" {if $configuration.RenewInvoice == 0}checked="checked"{/if}
                                               name="config[RenewInvoice]" value="0" onclick="$('#RenewInvoiceOff').ShowNicely(); $('#RenewInvoiceOn').hide();"
                                               id="igen_off"/><label  for="igen_off"><b>{$lang.no}</b></label>

                                        <input type="radio" {if $configuration.RenewInvoice == 1}checked="checked"{/if}
                                               name="config[RenewInvoice]" value="1" onclick="$('#RenewInvoiceOn').ShowNicely(); $('#RenewInvoiceOff').hide();"
                                               id="igen_on"/><label  for="igen_on"><b>{$lang.yes}</b></label>

                                        <p class="p5" id="RenewInvoiceOn" style="{if  $configuration.RenewInvoice != 1}display:none;{/if}" >
                                            <a id="gen-days-before"></a>
                                            <span class="gen-days-before">
                                                <span class="prorata">{$lang.InvoiceGeneration}</span>
                                                <input type="text" size="3"
                                                       value="{$configuration.InvoiceGeneration}"
                                                       name="config[InvoiceGeneration]"
                                                       class="inp"/>
                                                {$lang.InvoiceGeneration2}.
                                            </span>
                                            <span class="prorata">
                                                Invoice will be generated <span
                                                        class="pror-gendate"></span> day of the month.
                                            </span>
                                        </p>
                                        <p class="p5"  id="RenewInvoiceOff" style="{if  $configuration.RenewInvoice != 0}display:none;{/if}" >
                                            Do not generate renewal invoices for this service automatically. If
                                            enabled, customer will be able to renew service manually using “manual
                                            service renew” client function.
                                        </p>
                                    </td>

                                </tr>

                                <tr class="odd">
                                    <td align="right" style="vertical-align: top">
                                        <strong>Advanced due date
                                            settings
                                        </strong>
                                    </td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.AdvancedDueDate == 'off'}checked="checked"{/if}
                                               name="config[AdvancedDueDate]" value="off"
                                               onclick="$('#advanceddue_options').hide();" id="advanceddue_off"/>
                                        <label for="advanceddue_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.AdvancedDueDate == 'on'}checked="checked"{/if}
                                               name="config[AdvancedDueDate]"
                                               onclick="$('#advanceddue_options').ShowNicely();" id="advanceddue_on"/>
                                        <label for="advanceddue_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="advanceddue_options"
                                             style="{if $configuration.AdvancedDueDate == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">

                                            <p>
                                                {$lang.InvoiceExpectDays}
                                                <input type="text" size="3" class="inp"
                                                       value="{$configuration.InvoiceExpectDays}"
                                                       name="config[InvoiceExpectDays]"/>
                                                {$lang.InvoiceUnpaidReminder2}
                                            </p>
                                            <p>
                                                {$lang.InitialDueDays}
                                                <input type="text" size="3" class="inp"
                                                       value="{$configuration.InitialDueDays}"
                                                       name="config[InitialDueDays]"/>
                                                {$lang.InitialDueDays2}
                                            </p>
                                            <a id="move-due-date"></a>
                                            <p class="move-due-date">
                                                Move due date
                                                <input type="text" size="3" class="inp"
                                                       name="config[MoveDueDays]"
                                                       value="{$configuration.MoveDueDays}"/>
                                                days into future for recurring <span class="prorata">pro-rata</span>
                                                invoices.
                                            </p>
                                        </div>
                                    </td>
                                </tr>

                                <tr class="odd">
                                    <td width="200" valign="top" align="right"><strong>Adjust Initial Period</strong>
                                    </td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.AdsjustDatesOnCreation == 'off'}checked="checked"{/if}
                                               name="config[AdsjustDatesOnCreation]" value="off"/>
                                        <label for="unsuspend_off"><b>{$lang.no}</b></label>
                                        <input type="radio"
                                               {if $configuration.AdsjustDatesOnCreation == 'on'}checked="checked"{/if}
                                               name="config[AdsjustDatesOnCreation]" value="on"/>
                                        <label for="unsuspend_on"><b>{$lang.yes}</b></label>
                                        <div class="p5" id="AdsjustDatesOnCreation_options">
                                            Adjust dates after initial provisioning so that client gets his service for
                                            full
                                            period of time in case he pays few days afer order.
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td width="200" align="right" valign="top">
                                        <strong>{$lang.new_AutoProcessCancellations}</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.AutoProcessCancellations == 'off'}checked="checked"{/if}
                                               name="config[AutoProcessCancellations]" value="off"
                                               onclick="$('#cancelation_options').hide();" id="cancelation_off"/>
                                        <label for="cancelation_off"><b>{$lang.no}</b></label>
                                        <input type="radio"
                                               {if $configuration.AutoProcessCancellations == 'on'}checked="checked"{/if}
                                               name="config[AutoProcessCancellations]" value="on"
                                               onclick="$('#cancelation_options').show();" id="cancelation_on"/>
                                        <label for="cancelation_on"><b>{$lang.yes}</b></label>

                                        <div id="cancelation_options"
                                             style="{if $configuration.AutoProcessCancellations == 'off'}display:none;{/if}margin-top:10px;"
                                             class="p5">
                                            {$lang.new_AutoProcessCancellations1}

                                        </div>
                                    </td>

                                </tr>


                                <tr class="odd">
                                    <td width="200" align="right" valign="top">
                                        <strong>{$lang.new_SendPaymentReminderEmails}</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.SendPaymentReminderEmails == 'off'}checked="checked"{/if}
                                               name="config[SendPaymentReminderEmails]" value="off"
                                               onclick="$('#reminder_options').hide();" id="reminder_off"/>
                                        <label for="reminder_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.SendPaymentReminderEmails == 'on'}checked="checked"{/if}
                                               name="config[SendPaymentReminderEmails]"
                                               onclick="$('#reminder_options').ShowNicely();" id="reminder_on"/>
                                        <label for="reminder_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="reminder_options"
                                             style="{if $configuration.SendPaymentReminderEmails == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">


                                            {$lang.InvoiceUnpaidReminder}
                                            <span>
                                                <input type="checkbox" value="1"
                                                       {if $configuration.InvoiceUnpaidReminder>0}checked="checked"{/if}
                                                       onclick="check_i(this)"/>
                                                <input type="text" size="3" class="config_val  inp"
                                                        {if $configuration.InvoiceUnpaidReminder<=0} value="0" disabled="disabled"{else}value="{$configuration.InvoiceUnpaidReminder}"{/if}
                                                       name="config[InvoiceUnpaidReminder]"/>
                                            </span>
                                            {$lang.InvoiceUnpaidReminder2}
                                            <br/><br/>

                                            {$lang.1OverdueReminder}
                                            <span>
                                                <input type="checkbox" value="1"
                                                       {if $configuration.1OverdueReminder>0}checked="checked"{/if}
                                                       onclick="check_i(this)"/>
                                                <input type="text" size="3" class="config_val  inp"
                                                       {if $configuration.1OverdueReminder<=0}value="0"
                                                       disabled="disabled"
                                                       {else}value="{$configuration.1OverdueReminder}"{/if}
                                                       name="config[1OverdueReminder]"/>
                                            </span>
                                            <span>
                                                <input type="checkbox" value="1"
                                                       {if $configuration.2OverdueReminder>0}checked="checked"{/if}
                                                       onclick="check_i(this)"/>
                                                <input type="text" size="3" class="config_val inp"
                                                       {if $configuration.2OverdueReminder<=0}value="0"
                                                       disabled="disabled"
                                                       {else}value="{$configuration.2OverdueReminder}"{/if}
                                                       name="config[2OverdueReminder]"/>
                                            </span>
                                            <span>
                                                <input type="checkbox" value="1"
                                                       {if $configuration.3OverdueReminder>0}checked="checked"{/if}
                                                       onclick="check_i(this)"/>
                                                <input type="text" size="3" class="config_val  inp"
                                                       {if $configuration.3OverdueReminder<=0}value="0"
                                                       disabled="disabled"
                                                       {else}value="{$configuration.3OverdueReminder}"{/if}
                                                       name="config[3OverdueReminder]"/>
                                            </span>
                                            {$lang.1OverdueReminder2}


                                            <div style="margin:10px 0px 0px;">

                                                <table id="reminder_table" class="table-striped" cellpadding="4">
                                                    <tbody>

                                                        {foreach from=$configuration.InvoiceCustomReminder item=v key=k}
                                                            <tr id="reminder_{$k}">
                                                                <td>Send:</td>
                                                                <td width="180"><select
                                                                            name="config[InvoiceCustomReminder][{$k}][mail]"
                                                                            class="form-control">
                                                                        {foreach from=$emails.Invoice item=mail}
                                                                            <option value="{$mail.id}"
                                                                                    {if $v.mail==$mail.id}selected="selected"{/if}>{$mail.tplname}</option>{/foreach}
                                                                    </select></td>
                                                                <td width="50"><input class="form-control" type="text"
                                                                                      name="config[InvoiceCustomReminder][{$k}][days]"
                                                                                      value="{$v.days}"/></td>
                                                                <td>days</td>
                                                                <td width="80"><select
                                                                            name="config[InvoiceCustomReminder][{$k}][type]"
                                                                            class="form-control">
                                                                        <option value="before"
                                                                                {if $v.type=='before'}selected="selected"{/if}>
                                                                            before
                                                                        </option>
                                                                        <option value="after"
                                                                                {if $v.type=='after'}selected="selected"{/if}>
                                                                            after
                                                                        </option>
                                                                    </select></td>
                                                                <td>due date</td>
                                                                <td><a class="btn btn-default btn-sm"
                                                                       onclick="return HBServices.rmreminder('{$k}');"><i
                                                                                class="fa fa-times-circle"></i></a></td>
                                                            </tr>
                                                        {/foreach}
                                                        <tr id="reminder_template" style="display: none">
                                                            <td>Send:</td>
                                                            <td width="180"><select
                                                                        name="config[InvoiceCustomReminderr][+n+][mail]"
                                                                        class="form-control">
                                                                    {foreach from=$emails.Invoice item=mail}
                                                                        <option
                                                                        value="{$mail.id}">{$mail.tplname}</option>{/foreach}
                                                                </select></td>
                                                            <td width="50"><input class="form-control" type="text"
                                                                                  name="config[InvoiceCustomReminderr][+n+][days]"/>
                                                            </td>
                                                            <td>days</td>
                                                            <td width="80"><select
                                                                        name="config[InvoiceCustomReminderr][+n+][type]"
                                                                        class="form-control">
                                                                    <option value="before">before</option>
                                                                    <option value="after">after</option>
                                                                </select></td>
                                                            <td>due date</td>
                                                            <td><a class="btn btn-default btn-sm"
                                                                   onclick="return HBServices.rmreminder('+n+');"><i
                                                                            class="fa fa-times-circle"></i></a></td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                                <button class="btn btn-sm btn-default"
                                                        onclick="return HBServices.customreminder();">Add more custom
                                                    reminders
                                                </button>
                                            </div>

                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td width="200" align="right" valign="top">
                                        <strong>{$lang.new_LateFeeType_on|capitalize}</strong>
                                    </td>
                                    <td>
                                        <input type="radio" {if $configuration.LateFeeType == '0'}checked="checked"{/if}
                                               name="config[LateFeeType_sw]" value="0"
                                               onclick="$('#latefee_options').hide();" id="latefee_off"/>
                                        <label for="latefee_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.LateFeeType != '0'}checked="checked"{/if}
                                               name="config[LateFeeType_sw]" value="1"
                                               onclick="$('#latefee_options').ShowNicely();" id="latefee_on"/>
                                        <label for="latefee_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="latefee_options"
                                             style="{if $configuration.LateFeeType == '0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            {$lang.new_LateFeeType_on1}
                                            <input size="1" class="inp config_val" value="{$configuration.LateFeeValue}"
                                                   name="config[LateFeeValue]"/>
                                            <select class="inp config_val" name="config[LateFeeType]">
                                                <option {if $configuration.LateFeeType=='1'}selected="selected"{/if}
                                                        value="1">%
                                                </option>
                                                <option {if $configuration.LateFeeType=='2'}selected="selected"
                                                        {/if}value="2">{if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</option>
                                            </select>
                                            {$lang.new_LateFeeType_on2}
                                            <input type="text" size="3" value="{$configuration.AddLateFeeAfter}"
                                                   name="config[AddLateFeeAfter]" class="config_val inp"/>
                                            {$lang.LateFeeType2x}
                                            <br/>
                                        </div>
                                    </td>
                                </tr>

                                <tr class="odd">
                                    <td  align="right" valign="top">
                                        <strong>{$lang.ServiceReminder}</strong>
                                    </td>
                                    <td class="automate-options">
                                        <input type="radio" {if !$showreminders}checked="checked"{/if} name="c_12" value="off" onclick="$('#reminder_product_options').hide();
                                                $('#email_reminder_mail').val(0); $('.remind_check').prop('checked', false); $('.remind_val').prop('disabled', true);" id="reminder_due_off"/><label  for="reminder_due_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $showreminders}checked="checked"{/if} name="c_12" value="on" onclick="$('#reminder_product_options').ShowNicely(); $('.remind_check').prop('checked', true); $('.remind_val').prop('disabled', false);" id="reminder_due_on"/><label  for="reminder_due_on"><b>{$lang.yes}</b></label>
                                        <div class="p5" id="reminder_product_options" style="{if !$showreminders}display:none;{/if}" >

                                            <strong>{$lang.domain_expiring_mail}</strong>
                                            <div class="clear"></div>
                                            <table border="0" cellspacing="0" cellpadding="3" style="margin-top:5px;">
                                                <tr><td> <input class="remind_check" type="checkbox" value="1" {if $configuration.1ServiceReminder>0}checked="checked"{/if} onclick="check_i(this)"/>
                                                        <input type="text" size="3" class="remind_val config_val  inp" {if $configuration.1ServiceReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.1ServiceReminder}"{/if} name="config[1ServiceReminder]" />{$lang.daysbeforeduedate}</td></tr>

                                                <tr class="reminder2" ><td ><input class="remind_check" type="checkbox" value="1" {if $configuration.2ServiceReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="remind_val config_val  inp" {if $configuration.2ServiceReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.2ServiceReminder}"{/if} name="config[2ServiceReminder]" /> {$lang.daysbeforeduedate}</td></tr>
                                                <tr class="reminder3" ><td ><input class="remind_check" type="checkbox" value="1" {if $configuration.3ServiceReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="remind_val config_val  inp" {if $configuration.3ServiceReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.3ServiceReminder}"{/if} name="config[3ServiceReminder]" /> {$lang.daysbeforeduedate}</td></tr>
                                                <tr class="reminder4" ><td ><input class="remind_check" type="checkbox" value="1" {if $configuration.4ServiceReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="remind_val config_val  inp" {if $configuration.4ServiceReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.4ServiceReminder}"{/if} name="config[4ServiceReminder]"/> {$lang.daysbeforeduedate}</td></tr>
                                                <tr class="reminder5" ><td ><input class="remind_check" type="checkbox" value="1" {if $configuration.5ServiceReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="remind_val config_val inp" {if $configuration.5ServiceReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.5ServiceReminder}"{/if} name="config[5ServiceReminder]" /> {$lang.daysbeforeduedate}</td></tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>

                                {if $typetemplates.productconfig.automation.append}
                                    <tr>
                                        <td colspan="2" style="padding:0px;">
                                            {include file=$typetemplates.productconfig.automation.append}
                                        </td>
                                    </tr>
                                {/if}


                            </table>
                        </td>
                    </tr>
                </tbody>


                <tbody style="display:none" class="sectioncontent editor-container" id="service-emails">
                    <tr>
                        <td colspan="2">
                            {include file="services/ajax.service_emails.tpl"}
                        </td>
                    </tr>
                </tbody>


                <tbody style="display:none" class="sectioncontent">
                    <tr>
                        <td colspan="2" style="padding:0px">
                            <table border="0" cellspacing="0" cellpadding="6" width="100%">
                                <tbody style="display:none" class="components_content" id="configfields">
                                    {if $product.id=='new'}
                                        <tr>
                                            <td align="center" colspan="2">
                                                <strong>{$lang.save_product_first}</strong>

                                            </td>
                                        </tr>
                                    {else}
                                        <tr id="importforms" style="display:none">
                                            <td colspan="2">
                                                <a name="import-config"></a>
                                                <div style="margin-bottom: 15px;" class="p6">


                                                    <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <input type="file" name="importforms"/>
                                                                </td>
                                                                <td>
                                                                    <input type="button" value="Import"
                                                                           style="font-weight:bold"
                                                                           onclick="return saveProductFull();">
                                                                    <span class="orspace">{$lang.Or}</span> <a href="#"
                                                                                                               onclick="$('#importforms').hide();
                                                                                                $('#importformsswitch').show();
                                                                                                return false;"
                                                                                                               class="editbtn">{$lang.Cancel}</a>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <span class="pdescriptions fs11">{$lang.importformsnotice}</span>

                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="configeditor">

                                            <td id="configeditor_content" colspan="2">
                                                {include file='ajax.configfields.tpl'}

                                            </td>
                                        </tr>
                                    {/if}

                                </tbody>
                                <tbody id="addconfigopt" class="components_content" style="display:none">

                                    {if $product.id=='new'}
                                        <tr>
                                            <td align="center" colspan="2">
                                                <strong>{$lang.save_product_first}</strong> <a name="addons"></a>
                                            </td>

                                        </tr>
                                    {else}
                                        <tr id="addonseditor">

                                            <td id="addonsditor_content" colspan="2">

                                                {if $addons.addons || $addons.applied}
                                                    {if $addons.applied}
                                                        <div class="p5">
                                                            <table border="0" cellpadding="6" cellspacing="0"
                                                                   width="100%">


                                                                {foreach from=$addons.addons item=f}
                                                                    {if $f.assigned}
                                                                        <tr class="havecontrols">
                                                                        <td width="16">
                                                                            <div class="controls"><a href="#"
                                                                                                     class="rembtn"
                                                                                                     onclick="return removeadd('{$f.id}')">{$lang.Remove}</a>
                                                                            </div>
                                                                        </td>
                                                                        <td align="left">{$lang.Addon}:
                                                                            <strong>{$f.name}</strong>
                                                                        </td>
                                                                        <td align="right">
                                                                            <div class="controls fs11">{$lang.goto} <a
                                                                                        href="?cmd=productaddons&action=addon&id={$f.id}"
                                                                                        class="editbtn editgray"
                                                                                        style="float:none"
                                                                                        target="_blank">{$lang.addonpage}</a>
                                                                            </div>
                                                                        </td>
                                                                        </tr>{/if}{/foreach}


                                                            </table>


                                                        </div>
                                                        <div style="padding:10px 4px">
                                                            {if $addons.available}<a href="#" class="new_control"
                                                                                     onclick="$(this).hide();
                                                                                                $('#addnew_addons').ShowNicely();
                                                                                                return false;"
                                                                                     id="addnew_addon_btn"><span
                                                                        class="addsth">{$lang.assign_new_addons}</span>
                                                                </a>{/if}
                                                        </div>
                                                    {else}
                                                        <div class="blank_state_smaller blank_forms">
                                                            <div class="blank_info">
                                                                <h3>{$lang.offeraddons}</h3>
                                                                <span class="fs11">{$lang.paddonsbsdesc}</span>

                                                                <div class="clear"></div>
                                                                <br/>
                                                                {if $addons.available}
                                                                    <a href="#" class="new_control" onclick="$('#addnew_addons').ShowNicely();
                                                                                                            return false;"><span
                                                                                class="addsth"><strong>{$lang.assign_new_addons}</strong></span></a>
                                                                {else}
                                                                    <a href="?cmd=productaddons&action=addon&id=new"
                                                                       class="new_control" target="_blank"><span
                                                                                class="addsth"><strong>{$lang.createnewaddon}</strong></span></a>
                                                                {/if}
                                                                <div class="clear"></div>

                                                            </div>
                                                        </div>
                                                    {/if}

                                                    {if $addons.available}
                                                        <div class="p6" id="addnew_addons" style="display:none">
                                                        <table cellpadding="3" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    {$lang.Addon}: <select name="addon_id">

                                                                        {foreach from=$addons.addons item=f}{if !$f.assigned}
                                                                            <option value="{$f.id}">{$f.name}</option>
                                                                        {/if} {/foreach}
                                                                    </select>
                                                                </td>
                                                                <td>
                                                                    <input type="button" value="{$lang.Add}"
                                                                           style="font-weight:bold"
                                                                           onclick="return addadd()"/>
                                                                    <span class="orspace">{$lang.Or}</span>
                                                                    <a href="#"
                                                                       onclick="$('#addnew_addons').hide(); $('#addnew_addon_btn').show();return false;"
                                                                       class="editbtn">{$lang.Cancel}</a>
                                                                </td>
                                                            </tr>

                                                        </table></div>{/if}
                                                {else}
                                                    <div class="blank_state_smaller blank_forms">
                                                        <div class="blank_info">
                                                            <h3>{$lang.noaddonsyet}</h3>
                                                            <div class="clear"></div>

                                                            <div class="clear"></div>

                                                        </div>
                                                    </div>
                                                {/if}
                                            </td>
                                        </tr>
                                    {/if}
                                </tbody>
                                <tbody id="domainsopt" style="display:none" class="components_content">


                                    <tr class="odd">
                                        <td width="165" align="right" valign="top" style="padding-top: 8px">
                                            <strong>Hostname</strong>
                                        </td>
                                        <td>
                                            <input type="checkbox" name="hostname" value="1"
                                                   {if $product.hostname=='1'}checked="checked"{/if} /> {$lang.require_hostname}
                                            <br/>
                                            Validation
                                            <select name="p_options[]">
                                                <option value="0">Do not validate provided hostname</option>
                                                <option value="2" {if $product.p_options & 2}selected{/if}>Check if
                                                    provided
                                                    hostname is valid DNS name
                                                </option>
                                                <option value="4" {if $product.p_options & 4}selected{/if}>Check if
                                                    provided
                                                    hostname is valid Domain name (example.com)
                                                </option>
                                                <option value="8" {if $product.p_options & 8}selected{/if}>Check if
                                                    provided
                                                    hostname is valid FQDN (server.example.com)
                                                </option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr >
                                        <td width="165" align="right"  valign="top"  style="padding-top: 8px">
                                            <strong>Auto-generate hostname</strong>
                                        </td>
                                        <td>
                                            <input type="checkbox"  {if $product.autohostname!=''}checked="checked"{/if} value="1" name="autohostname_enable" onchange="$('#autogeneratehostname').toggle();"/> Enable
                                            <br/>
                                            <div id="autogeneratehostname" {if $product.autohostname==''}style="display:none"{/if}>

                                                <div class="form-group">
                                                    <label for="">Auto-hostname pattern</label>
                                                    <input type="text" value="{$product.autohostname}" id="" name="autohostname" class="form-control">
                                                    <p class="help-block">
                                                        Following variables can be used: <br/>
                                                        {literal}
                                                            <code>{$account_id}</code> related account id<br/>
                                                            <code>{$client_id}</code> related client id <br/>
                                                            <code>{$username}</code> unique, random username <br/>
                                                        {/literal}
                                                    </p>

                                                </div>

                                            </div>

                                        </td>
                                    </tr>

                                    <tr id="domain_options_container">
                                        <td align="right"><b>{$lang.offerdomains}</b></td>
                                        <td>
                                            <input type="radio" value="1"
                                                   {if $product.domain_options=='1'}checked="checked"{/if}
                                                   name="domain_options"
                                                   id="domain_options" onclick="$('#domain_options_blank_state').hide();
                                                                                            $('.showdomopt').toggle();"/>
                                            <label for="domain_options">{$lang.yes}</label>
                                            <input type="radio" value="0"
                                                   {if $product.domain_options=='0'}checked="checked"{/if}
                                                   name="domain_options"
                                                   id="domain_options_no" onclick="$('.showdomopt').toggle();"/> <label
                                                    for="domain_options_no">{$lang.no}</label>
                                        </td>
                                    </tr>

                                    <tr {if $product.domain_options!='1'}style="display:none"{/if} class="showdomopt">

                                        <td></td>
                                        <td>
                                            <table cellpadding="6" cellspacing="0" class="editor-container"
                                                   width="100%">

                                                <tr>
                                                    <td colspan="2"><strong>Offer following domain registration/transfer
                                                            options:</strong></td>

                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        {if !$domain_order}
                                                            <div class="blank_state_smaller blank_domains"
                                                                 style="padding:10px 0px;">
                                                                <div class="blank_info">
                                                                    <h3>You dont have any domain order pages set-up
                                                                        yet.
                                                                    </h3>
                                                                    <span class="fs11">With HostBill you can configure
                                                                        various orderpages for domains and offer them
                                                                        with your packages as sub-product.</span>
                                                                    <div class="clear"></div>
                                                                    <br/>
                                                                    <a href="?cmd=services&action=addcategory"
                                                                       class="new_control" target="_blank"><span
                                                                                class="addsth"><strong>Create new domain
                                                                                orderpage</strong></span></a>
                                                                    <div class="clear"></div>

                                                                </div>
                                                            </div>
                                                        {else}
                                                            <select multiple name="domain_op[]"
                                                                    id="domain_op" class="chosen">
                                                                {foreach from=$domain_order item=do}
                                                                    <option value="{$do.id}"
                                                                            {if in_array($do.id, $product.domain_op)}selected{/if}>
                                                                        {$do.name}
                                                                    </option>
                                                                {/foreach}
                                                            </select>
                                                            <span class="fs11">
                                                                <a href="?cmd=services&action=addcategory"
                                                                        class="editbtn" target="_blank">
                                                                    Create new domain orderpage
                                                                </a>
                                                            </span>
                                                        {/if}
                                                    </td>
                                                </tr>
                                                <tr class="odd">
                                                    <td colspan="2">
                                                        <div class="checkbox domain-opt-toggle">
                                                            <label>
                                                                <input type="checkbox" name="owndomain" value="1"
                                                                       {if $product.owndomain=='1'}checked{/if} />
                                                                <strong>{$lang.allow_own_dom}</strong>
                                                            </label>
                                                        </div>
                                                        <div class="domain-opt-box">
                                                            <div class="checkbox">
                                                                <label>
                                                                    <input type="checkbox" name="owndomainwithus" value="1" {if $product.owndomainwithus=='1'}checked{/if} />
                                                                    <strong>{$lang.allow_own_dom_registered_us}</strong>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <div class="checkbox domain-opt-toggle">
                                                            <label>
                                                                <input type="checkbox" name="subdomain" value=""
                                                                       {if $product.subdomain}checked{/if} />
                                                                <strong>{$lang.offersubdomain}</strong>
                                                            </label>
                                                        </div>
                                                        <div class="domain-opt-box">
                                                            <input type="text"
                                                                   value="{$product.subdomain}"
                                                                   name="subdomain"
                                                                   class="form-control"
                                                                   id="off_sub" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                {if $domain_order}
                                                    <tr class="odd">
                                                        <td colspan="2">
                                                            <div class="checkbox domain-opt-toggle">
                                                                <label>
                                                                    <input type="checkbox" name="free_domain" value="1"
                                                                           {if $product.free_domain}checked{/if} />
                                                                    <strong>{$lang.offerfreedom}</strong>
                                                                </label>
                                                            </div>
                                                            <div class="domain-opt-box row">
                                                                <div class="col-md-6">
                                                                    {$lang.offertlds}<br/>
                                                                    <select multiple="multiple" name="free_tlds[]"
                                                                            class="chosen">
                                                                        {foreach from=$tlds item=tld}
                                                                            <option {if $product.free_tlds.tlds[$tld]}selected{/if}>
                                                                                {$tld}
                                                                            </option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    {$lang.offerperiods}<br/>
                                                                    <select multiple="multiple"
                                                                            name="free_tlds_cycles[]"
                                                                            class="chosen">
                                                                        <option {if $product.free_tlds.cycles.Once}selected="selected" {/if}
                                                                                value="Once">{$lang.OneTime}</option>
                                                                        <option {if $product.free_tlds.cycles.Daily}selected="selected" {/if}
                                                                                value="Daily">{$lang.Daily}</option>
                                                                        <option {if $product.free_tlds.cycles.Weekly}selected="selected" {/if}
                                                                                value="Weekly">{$lang.Weekly}</option>
                                                                        <option {if $product.free_tlds.cycles.Monthly}selected="selected" {/if}
                                                                                value="Monthly">{$lang.Monthly}</option>
                                                                        <option {if $product.free_tlds.cycles.Quarterly}selected="selected" {/if}
                                                                                value="Quarterly">{$lang.Quarterly}</option>
                                                                        <option {if $product.free_tlds.cycles.SemiAnnually}selected="selected" {/if}
                                                                                value="SemiAnnually">{$lang.SemiAnnually}</option>
                                                                        <option {if $product.free_tlds.cycles.Annually}selected="selected" {/if}
                                                                                value="Annually">{$lang.Annually}</option>
                                                                        <option {if $product.free_tlds.cycles.Biennially}selected="selected" {/if}
                                                                                value="Biennially">{$lang.Biennially}</option>
                                                                        <option {if $product.free_tlds.cycles.Triennially}selected="selected" {/if}
                                                                                value="Triennially">{$lang.Triennially}</option>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="checkbox">
                                                                        <label>
                                                                            <input type="checkbox" name="config[MatchFreeDomainPeriod]" value="on"
                                                                                   {if $configuration.MatchFreeDomainPeriod == 'on'}checked{/if} />
                                                                            Match free domain period with hosting cycle
                                                                        </label>
                                                                        <span class="vtip_description">
                                                                            Update free domain period to match hosting billing cycle.
                                                                            For example changing from Annually to Biennially will
                                                                            also change domain period to 2 years (when possible).
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                {/if}
                                            </table>
                                        </td>
                                    </tr>


                                </tbody>
                                <tbody style="display:none" class="components_content" id="subproducts">
                                    <tr id="subprod_options_blank_state"
                                        {if $subproducts_applied}style="display:none"{/if}>
                                        <td colspan="2">
                                            <div class="blank_state_smaller blank_domains">
                                                <div class="blank_info">
                                                    <h3>Offer other packages to be purchased and automated with this
                                                        product,
                                                        all in one order.
                                                    </h3>
                                                    <div class="clear"></div>
                                                    <br/>
                                                    <a href="#" class="new_control" onclick="$('#subproducts_options_container').show();
                                                                                                            $('#subprod_options_blank_state').hide();
                                                                                                            return false;
                                                                                                            return false"><span
                                                                class="addsth"><strong>Enable
                                                                Sub-products</strong></span></a>
                                                    <div class="clear"></div>

                                                </div>
                                            </div>

                                        </td>
                                    </tr>
                                    <tr id="subproducts_options_container"
                                        {if !$subproducts_applied}style="display:none"{/if}>
                                        <td colspan="2">
                                            <b>Select packages you wish to offer as a sub-product</b>
                                            <select multiple name="subproducts[]"
                                                    id="subproducts_op"
                                                    class="form-control chosenedge multiopt">
                                                {foreach from=$subproducts item=do}
                                                    <option value="{$do.id}"
                                                            {if $product.subproducts.products[$do.id]}selected="selected"{/if}>{$do.category_name}
                                                        - {$do.name}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                    </tr>


                                </tbody>
                                {foreach from=$extra_tabs item=etab key=ekey name=tabloop}
                                    <tbody style="display:none" class="components_content">
                                        <tr>
                                            <td colspan="2">{include file=$etab}</td>
                                        </tr>
                                    </tbody>
                                {/foreach}
                            </table>

                        </td>
                    </tr>


                </tbody>


                <tbody style="display:none" class="sectioncontent">

                    {if $product.id=='new'}
                        <tr>
                            <td align="center" colspan="2">
                                <strong>{$lang.save_product_first}</strong>

                            </td>
                        </tr>
                    {else}
                        <tr id="widgeteditor">

                            <td id="widgeteditor_content" colspan="2">
                                {include file='ajax.productwidgets.tpl'}
                            </td>
                        </tr>
                    {/if}


                </tbody>

                <tbody style="display:none" class="sectioncontent">
                    <tr>
                        <td width="200" valign="top" align="right"><strong>Limit Per Customer</strong></td>
                        <td>
                            <input type="radio" {if $product.client_limit == '0'}checked="checked"{/if}
                                   name="product_limit_customer" value="off" onclick="$('#limit_options').hide();
                                                                                    $('#client_limit_val').val(0)"/><label><b>{$lang.no}</b></label>
                            <input type="radio" {if   $product.client_limit != '0'}checked="checked"{/if}
                                   name="product_limit_customer" value="on"
                                   onclick="$('#limit_options').ShowNicely()"/><label><b>{$lang.yes}</b></label>
                            <div class="p5" id="limit_options"
                                 style="{if $product.client_limit == '0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                One customer is allowed to order
                                <input type="text" size="3"
                                    value="{$product.client_limit}"
                                    name="client_limit" id="client_limit_val"
                                    class="inp config_val"/> products of this type

                            </div>

                        </td>
                    </tr>
                    <tr>
                        <td width="200" valign="center" align="right"><strong>Allow Cancellations</strong></td>
                        <td>

                            <input class="allow_cancellation" type="radio" {if  !($product.p_options & 1 & 16)  }checked="checked"{/if} name="p_options[1]"
                                   value="0"/><label><b>{$lang.yes}</b></label>, client can cancel service using this product<br>
                            <input class="allow_cancellation" type="radio" {if  $product.p_options & 16  }checked="checked"{/if} name="p_options[1]"
                                   value="16"/><label><b>{$lang.yes}</b></label>, client can cancel service
                                <select name="p_options[2]">
                                    <option value="32" {if  $product.p_options & 32}selected{/if}><strong>For</strong></option>
                                    <option value="64" {if  $product.p_options & 64 || !($product.p_options & 32)}selected{/if}><strong>After</strong></option>
                                </select>
                                <input type="number" min="0" value="{$product.block_cancellation_day}" style="width: 60px;" name="config[BlockCancellationDay]"> days since account creation<br>
                            <input class="allow_cancellation" type="radio" {if $product.p_options & 1 }checked="checked"{/if}
                                   name="p_options[1]"
                                   value="1"/><label><b>{$lang.no}</b></label>, client cannot cancel service with this product<br>

                            {literal}
                                <script>
                                    $('.cancellation_type_input').on('change', function () {
                                        if (!check_cancellation_type()) {
                                            $('.allow_cancellation').last().prop('checked', true);
                                            $('.cancellation_type').slideUp();
                                        }
                                    });
                                    $('.allow_cancellation').on('init change', function () {
                                        if ($(this).prop('checked')) {
                                            if ($(this).val() === '1') {
                                                $('.cancellation_type').slideUp();
                                            } else {
                                                $('.cancellation_type').slideDown();
                                                if (!check_cancellation_type())
                                                    $('.cancellation_type_input').first().prop('checked', true);
                                            }
                                        }
                                    }).trigger('init');

                                    function check_cancellation_type() {
                                        var cancel = false;
                                        $('.cancellation_type_input').each(function () {
                                            if ($(this).prop('checked'))
                                                cancel = true;
                                        });

                                        return cancel;
                                    }
                                </script>
                            {/literal}
                        </td>
                    </tr>
                    <tr class="cancellation_type" {if $product.p_options & 1 }style="display: none;" {/if}>
                        <td width="200" valign="center" align="right"><strong>Allowed Cancellation Types</strong></td>
                        <td>
                            <input name="config[CancellationTypeImmediate]" type="checkbox" value="on" class="inp cancellation_type_input"
                                   {if $configuration.CancellationTypeImmediate=='on'}checked="checked"{/if} />
                            Immediate<br/>
                            <input name="config[CancellationTypeEndPeriod]" type="checkbox" value="on" class="inp cancellation_type_input"
                                   {if $configuration.CancellationTypeEndPeriod=='on'}checked="checked"{/if} />
                            End of billing period<br/>
                        </td>
                    </tr>
                    <tr class="cancellation_type" {if $product.p_options & 1 }style="display: none;" {/if}>
                        <td width="200" valign="center" align="right"><strong>Pro-rate cancellations</strong></td>
                        <td>
                            <input name="config[CancellationPostPaidProrata]" type="radio" value="off" class="inp cancellation_type_input" {if !$configuration.CancellationPostPaidProrata || $configuration.CancellationPostPaidProrata=='off'}checked="checked"{/if} />
                            <label><strong>No</strong></label> <br>

                            <input name="config[CancellationPostPaidProrata]" type="radio" value="immediate" class="inp cancellation_type_input" {if $configuration.CancellationPostPaidProrata=='immediate'}checked="checked"{/if} />
                            <label><strong>Yes, for pre-paid services (for immediate cancelations)</strong></label> <br>

                            <input name="config[CancellationPostPaidProrata]" type="radio" value="on" class="inp cancellation_type_input" {if $configuration.CancellationPostPaidProrata=='on'}checked="checked"{/if} />
                            <label><strong>Yes, for post-paid services</strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>Upgrade pro-rata</strong></td>
                        <td>
                            <select name="config[UpgradeProratePrecision]">
                                <option value="seconds" {if $configuration.UpgradeProratePrecision == 'seconds'}selected{/if}>
                                    Seconds - calculate charge based on time left to due date
                                </option>
                                <option value="hours" {if $configuration.UpgradeProratePrecision == 'hours'}selected{/if}>
                                    Hours - calculate charge based on hours left to due date
                                </option>
                                <option value="days" {if $configuration.UpgradeProratePrecision == 'days'}selected{/if}>
                                    Days - calculate charge based on days left to due date
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>Credit on Downgrade</strong></td>
                        <td>
                            <select name="config[CreditOnDowngradeOverride]">
                                <option value="">
                                    Default, use system billing settings
                                </option>
                                <option value="off" {if $configuration.CreditOnDowngradeOverride == 'off'}selected{/if}>
                                    No, do not credit customer pro-rated amount on package
                                    downgrade
                                </option>
                                <option value="on" {if $configuration.CreditOnDowngradeOverride == 'on'}selected{/if}>
                                    Yes, credit customer pro-rated amount on package
                                    downgrade
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>Credit note on Downgrade</strong></td>
                        <td>
                            <select name="config[CNoteDowngradeOverride]" style="width: 315px;">
                                <option value="">
                                    Default, use system billing settings
                                </option>
                                <option value="off" {if $configuration.CNoteDowngradeOverride == 'off'}selected{/if}>
                                    No, do not issue credit notes on downgrades
                                </option>
                                <option value="on" {if $configuration.CNoteDowngradeOverride == 'on'}selected{/if}>
                                    Yes, issue credit notes on downgrades
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <strong>Full Month Billing</strong>
                            <a class="vtip_description"><span>
                                When enabled all invoices for this service will show dates from
                                first to last day of the month, regardless of the actual billing dates.
                                First order will bill for two months if order is submitted after
                                the first day of the month.
                            </span></a>
                        </td>
                        <td>
                            <select name="config[BillFullMonth]">
                                <option value="0">
                                    Disabled
                                </option>
                                <option value="1" {if $configuration.BillFullMonth == '1'}selected{/if}>
                                    Enabled
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>Contract template</strong></td>
                        <td>
                            <select name="contract_id" style="width: 315px;">
                                <option value="0">-None-</option>
                                {foreach from=$contracts item=contract}
                                    <option value="{$contract.id}" {if $product.contract_id == $contract.id}selected{/if}>{$contract.name}</option>
                                {/foreach}
                            </select>
                            <a href="?cmd=configuration&action=contracts" target="_blank">See all contract templates</a>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <strong>Clientarea Layout</strong>
                            <a class="vtip_description" title="Decide how client area will look like. Note that this option works only on latest HostBill themes and may be overridden by provisioning module theme"></a>
                        </td>
                        <td>
                            <select name="layout" style="width: 315px;">
                                <option {if $product.layout === 'left'}selected="selected"{/if} value="left">Left menu</option>
                                <option {if $product.layout === 'right'}selected="selected"{/if} value="right">Right menu</option>
                                <option {if $product.layout === 'top'}selected="selected"{/if} value="top">Top menu</option>
                            </select>
                        </td>
                    </tr>
                    <tr id="upgradesopt" {if !$haveupgrades}style="display:none"{/if}>
                        <td colspan="2">
                            <h3>{$lang.Upgrades}</h3>
                            <table border="0" cellspacing="0" cellpadding="3" width="100%">
                                <tr>
                                    <td valign="top" align="center" width="49%">
                                        {if $upgrades}
                                            {$lang.aaplicableupgrades}
                                            <br/>
                                            <select multiple="multiple" name="upgrades2[]"
                                                    style="width:100%;height:400px;"
                                                    id="listAvailU" class="multiopt">

                                                {foreach from=$upgrades item=cat}
                                                    {if !$cat.assigned}
                                                        <option value="{$cat.id}">{$cat.catname}: #{$cat.id} {$cat.name} </option>
                                                    {/if}
                                                {/foreach}
                                            </select>
                                            <br/>
                                        {else}
                                            {$lang.noupgrades}
                                        {/if}
                                    </td>
                                    <td valign="middle" width="40" align="center">
                                        <input type="button" value=">>" onclick="addItem('upd');
                                                                                                return false;"
                                               name="move"/>
                                        <input type="button" value="<<" onclick="delItem('upd');
                                                                                                return false;"
                                               name="move"/>
                                    </td>
                                    <td valign="top" align="center" width="49%">
                                        {$lang.appliedupgrades} <br/>
                                        <select multiple="multiple" name="upgrades[]" style="width:100%;height:400px;"
                                                id="listAlreadyU" class="multiopt">

                                            {foreach from=$upgrades item=cat}
                                                {if $cat.assigned}
                                                    <option value="{$cat.id}">{$cat.catname}: #{$cat.id} {$cat.name}</option>
                                                {/if}
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                </tbody>

                <tbody style="display:none" class="sectioncontent">
                    <tr>
                        <td align="center" colspan="2">
                            {include file="services/metrics.tpl"}
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>

    </tr>
    <tr>
        <td class="nicers" style="border:0px" colspan="2">
            <a class="new_dsave new_menu" href="#" onclick="return saveProductFull();">
                <span>{$lang.savechanges}</span>
            </a>
        </td>

    </tr>
</table>


<div class="clear"></div>