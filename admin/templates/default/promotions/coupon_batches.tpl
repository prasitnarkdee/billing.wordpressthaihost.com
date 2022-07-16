{if $section=='submenu'}
    {if $action == 'batches'}
        <div class="list-2">
            <div class="haveitems">
                <ul>
                    <li><a href="?cmd=coupons&action=batch">Create new batch</a></li>
                </ul>
            </div>
        </div>
    {/if}
    {if $action !== 'batches'}
        <ul class="breadcrumb" style="margin-bottom: 0">
            <li>
                <a href="?cmd=coupons&action=batches">List Batches</a>
            </li>
            {if  $action == 'batch' && !$batch.id}
                <li>Add new codes batch</li>
            {elseif $action == 'batch' && $batch.id}
                <li class="active">
                    Batch:
                    <a href="?cmd=coupons&action=batch&id={$batch.id}">
                        #{$batch.id} {$batch.name}
                    </a>
                </li>
                {if $make == 'codes'}
                    <li class="active">{$lang.codes}</li>
                {/if}
            {/if}
        </ul>
    {/if}
{elseif $action=='batches'}
    {if $batches}
        <form action="" method="post" id="testform">
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=coupons&action=batches" id="currentlist" style="display:none" updater="#updater"></a>
            <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
                <tbody>
                <tr>
                    <th width="100px"><a href="?cmd=coupons&action=batches&orderby=id|ASC" class="sortorder">ID</a></th>
                    <th width="300px"><a href="?cmd=coupons&action=batches&orderby=name|ASC" class="sortorder">Batch name</a></th>
                    <th><a href="?cmd=coupons&action=batches&orderby=status|ASC" class="sortorder">Status</a></th>
                    <th><a href="?cmd=coupons&action=batches&orderby=prefix|ASC" class="sortorder">Prefix code</a></th>
                    <th><a href="?cmd=coupons&action=batches&orderby=type|ASC" class="sortorder">Coupon type</a></th>
                    <th><a href="?cmd=coupons&action=batches&orderby=discount|ASC" class="sortorder">Discount</a></th>
                    <th>Coupons</th>
                    <th>Used</th>
                    <th><a href="?cmd=coupons&action=batches&orderby=notes|ASC" class="sortorder">Notes</a></th>
                    <th><a href="?cmd=coupons&action=batches&orderby=created_at|ASC" class="sortorder">Created</a></th>
                    <th><a href="?cmd=coupons&action=batches&orderby=expires_at|ASC" class="sortorder">Expires</a></th>
                    <th width="200"></th>
                </tr>
                </tbody>
                <tbody id="updater">
                    {include file="promotions/ajax.coupon_batches.tpl"}
                </tbody>
                <tbody id="psummary">
                <tr>
                    <th colspan="100%">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                                id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                                id="sorterrecords">{$sorterrecords}</span>
                    </th>
                </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
        </form>
    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>Manage Code Batches</h1>
                Use this feature to generate batches of coupons
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd=coupons&action=batch" style="margin-top:10px">
                    <span>Add new coupon batch</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=='batch' && $make=='codes'}
    <form action="" method="post" id="testform">
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        <div class="blu">
            <div class="left">
                <a href="?cmd=coupons&action=batch&make=csv&id={$batch.id}&security_token={$security_token}" class="btn btn-sm btn-default">Export to CSV</a>
            </div>
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        <a href="?cmd=coupons&action=batch&make=codes&id={$batch.id}" id="currentlist" style="display:none" updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
            <tr>
                <th style="width:90px"><a href="?cmd=coupons&action=batch&make=codes&id={$batch.id}&orderby=id|ASC" class="sortorder">{$lang.couponhash}</a></th>
                <th style="width:30%"><a href="?cmd=coupons&action=batch&make=codes&id={$batch.id}&orderby=code|ASC" class="sortorder">{$lang.Code}</a></th>
                <th style="width:15%"><a href="?cmd=coupons&action=batch&make=codes&id={$batch.id}&orderby=status|ASC" class="sortorder">{$lang.status}</a></th>
                <th style="width:15%"><a href="?cmd=coupons&action=batch&make=codes&id={$batch.id}&orderby=coupon_type|ASC" class="sortorder">{$lang.coupontype}</a></th>
                <th style="width:15%"><a href="?cmd=coupons&action=batch&make=codes&id={$batch.id}&orderby=value|ASC" class="sortorder">{$lang.Discount}</a></th>
                <th style="width:15%"><a href="?cmd=coupons&action=batch&make=codes&id={$batch.id}&orderby=num_usage|ASC" class="sortorder">{$lang.Used}</a></th>
                <th width="20"></th>
            </tr>
            </tbody>
            <tbody id="updater">
                {include file="promotions/ajax.coupon_batches.tpl"}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="7">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                            id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                            id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
        </table>
        <div class="blu">
            <div class="left">
                <a href="?cmd=coupons&action=batch&make=csv&id={$batch.id}&security_token={$security_token}" class="btn btn-sm btn-default">Export to CSV</a>
            </div>
            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        {securitytoken}
    </form>


{elseif $action=='batch'}
    <script src="{$template_dir}js/coupons.js?v={$hb_version}"></script>
    <link href="{$template_dir}js/chosen/chosen.css" rel="stylesheet" media="all">
    <script type="text/javascript" src="{$template_dir}js/chosen/chosen.min.js?v={$hb_version}"></script>
    <form method="post">
        <input type="hidden" name="make" value="{if $action=='batch' && $batch.id}update{else}add{/if}"/>
        <div class="lighterblue2">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-6 col-md-8 col-xs-12">
                        <table border="0" cellpadding="6" cellspacing="0" width="100%">
                            <tbody>
                            <tr>
                                <td><h4>Batch details</h4></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td width="250" align="right"><label for="name"><strong>Batch name</strong></label></td>
                                <td>
                                    <input type="text" name="name" id="name" class="form-control" value="{$batch.name}">
                                </td>
                            </tr>
                            <tr>
                                <td width="160" align="right"><strong>{$lang.status}</strong></td>
                                <td>
                                    <select class="form-control" name="status" id="status">
                                        <option value="Active" {if $batch.status=='Active'}selected="selected"{/if}>Active</option>
                                        <option value="Archived" {if $batch.status=='Archived'}selected="selected"{/if}>Archived</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="onchange_codelayout_hide">
                                <td width="250" align="right"><label for="complexity"><strong>Code complexity</strong></label>
                                </td>
                                <td>
                                    {if $action=='batch' && !$batch.id}
                                        <select class="form-control" name="complexity" id="complexity">
                                            {foreach from=$complexity key=key item=item}
                                                <option value="{$key}" {if $key==2}selected="selected"{/if}>{$item.name}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $action=='batch' && $batch.id && $batch.code_layout == 4}
                                        <i>n/a</i>
                                    {else}
                                        {$complexity[$batch.complexity].name}
                                    {/if}
                                </td>
                            </tr>
                            <tr class="onchange_codelayout_hide">
                                <td width="250" align="right">
                                    <label for="prefix"><strong>Code prefix</strong>
                                        <a class="vtip_description" title="Prefix for each generated code"></a>
                                    </label>
                                </td>
                                <td>
                                    {if $action=='batch' && !$batch.id}
                                        <div class="input-group">
                                            <input type="text" name="prefix" id="prefix" class="form-control" size="4">
                                        </div>
                                    {else}
                                        {if $batch.prefix}{$batch.prefix}{else}<i>None</i>{/if}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td width="250" align="right">
                                    <label for="size"><strong>Generated coupons</strong>
                                        <a class="vtip_description" title="The number of generated codes"></a>
                                    </label>
                                </td>
                                <td>
                                    {if $action=='batch' && !$batch.id}
                                        <div class="input-group">
                                            <input type="text" name="size" id="size" class="form-control" size="4">
                                        </div>
                                    {else}
                                        <div class="creditVouchersSize">{$batch.coupons_count}</div>
                                    {/if}
                                </td>
                            </tr>
                            {if $action=='batch' && $batch.id}
                                <tr>
                                    <td width="250" align="right">
                                        <label><strong>Total coupon usage</strong></label></td>
                                    <td>{$batch.coupons_used}</td>
                                </tr>
                                <tr>
                                    <td width="250" align="right" style="background-color: #eeeeee;">
                                        <label for="generate_codes">
                                            <strong>Generate new coupons</strong>
                                        </label>
                                    </td>
                                    <td style="background-color: #eeeeee; width: 260px; float: left">
                                        <div class="input-group">
                                            <input type="number" name="generate_codes" id="generate_codes" value="" class="form-control">
                                            <span class="input-group-btn">
                                                <a href="#" onclick="generateCodes($(this),{$batch.id});return false;" class="btn btn-default">Generate</a>
                                            </span>
                                        </div>
                                        <div class="creditVouchersLoaderImg"><img src="ajax-loading.gif"></div>
                                    </td>
                                </tr>
                            {/if}
                            <tr>
                                <td><h4>Coupon details</h4></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td width="250" align="right">
                                    <strong>{$lang.coupontype}</strong>
                                </td>
                                <td>
                                    <select class="form-control" name="coupon_type" id="coupon_type">
                                        <option value="cart" {if $batch.coupon_type=='cart'}selected="selected"{/if}>Cart coupon</option>
                                        <option value="invoice" {if $batch.coupon_type=='invoice'}selected="selected"{/if}>Invoice coupon</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td width="250" align="right"><strong>{$lang.Discount}</strong></td>
                                <td><input class="inp" size="4" name="value" value="{$batch.value}"/>
                                    <select class="inp" name="type">
                                        <option value="percent" {if $batch.type=='percent'}selected="selected"{/if}>{$lang.percent}</option>
                                        <option value="fixed" {if $batch.type=='fixed'}selected="selected"{/if}>{$lang.fixed}</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="250" align="right"><strong>{$lang.disctype}</strong></td>
                                <td>
                                    <select class="form-control coupon-type-cart" name="coupon_config[cycle]" id="cycle_code">
                                        <option value="once" {if $batch.coupon_config.cycle=='once'}selected="selected"{/if}>{$lang.applyonce}</option>
                                        <option value="recurring" {if $batch.coupon_config.applyto!='setupfee' && $batch.coupon_config.cycle=='recurring'}selected="selected"{/if} {if $batch.coupon_config.applyto=='setupfee'}disabled="disabled"{/if}>{$lang.Recurring}</option>
                                    </select>
                                    <div class="form-control coupon-type-invoice">
                                        {$lang.applyonce}
                                    </div>
                                </td>
                            </tr>

                            <tr id="increase_in_days" {if $batch.coupon_config.cycle!='recurring'} style="display: none;" {/if}>
                                <td width="250" align="right">
                                    <strong>Set regular price after</strong>
                                    <a class="vtip_description" title="Use this if you wish to set package price back to regular in certain time - ie. you wish to discount only first 3 months"></a>
                                </td>
                                <td>
                                    <input type="checkbox" id="increase_in_days_check" name="coupon_config[increase_in_days_check]" onclick="check_i(this)" {if $batch && $batch.coupon_config.cycle=='recurring' && $batch.coupon_config.increase_in_days > 0}checked="checked"{/if} />
                                    <input size="4" id="increase_in_days" name="coupon_config[increase_in_days]" class="inp config_val" {if !$batch || $batch.coupon_config.increase_in_days=='0'}disabled="disabled"{/if}value="{$batch.coupon_config.increase_in_days}"/>days
                                </td>
                            </tr>
                            <tr>
                                <td width="250" align="right"><strong>Apply to</strong></td>
                                <td >
                                    <select class="form-control coupon-type-cart" name="coupon_config[applyto]" onchange="recurring_check(this.value);" id="apply_code">
                                        <option value="price" {if $batch.coupon_config.applyto=='price'}selected="selected"{/if}>Recurring price</option>
                                        <option value="setupfee" {if $batch.coupon_config.applyto=='setupfee'}selected="selected"{/if}>Setup fee</option>
                                        <option value="both" {if $batch.coupon_config.applyto=='both'}selected="selected"{/if}>Total price</option>
                                    </select>
                                    <div class="form-control coupon-type-invoice">Total price</div>
                                </td>
                            </tr>
                            <tr>
                                <td width="250" align="right"><strong>{$lang.appby}</strong></td>
                                <td >
                                    <select class="form-control coupon-type-cart" name="coupon_config[clients]" onchange="client_check(this.value);" id="apply_clients">
                                        <option value="all" {if $batch.coupon_config.clients=='all'}selected="selected"{/if}>{$lang.allcusts}</option>
                                        <option value="new" {if $batch.coupon_config.clients=='new'}selected="selected"{/if}>{$lang.onlynewcusts}</option>
                                        <option value="existing" {if $batch.coupon_config.clients=='existing'}selected="selected"{/if}>{$lang.existcusts}</option>
                                    </select>
                                    <div class="form-control coupon-type-invoice">
                                        {$lang.existcusts}
                                    </div>
                                </td>
                            </tr>

                            <tr id="specify" {if $batch.coupon_config.clients!='existing'}style="display:none"{/if}>
                                <td width="250" align="right"><strong>{$lang.specifiedcusts}</strong></td>
                                <td id="loadcustomers">
                                    {if $batch.coupon_config.client_id=='0'} {$lang.allcustx}
                                        <a href="#" onclick="ajax_update('?cmd=coupons&action=getclients&batchmode=1',{literal}{}{/literal}, '#loadcustomers', true);return false;">{$lang.clherex}</a>
                                    {else}
                                        <input type="hidden" name="coupon_config[client_id]" value="{$batch.coupon_config.client_id}"/>
                                        <a href="?cmd=clients&action=show&id={$batch.coupon_config.client_id}">#{$batch.coupon_config.client_id} {$batch.lastname} {$batch.firstname}</a>
                                        <a href="#" onclick="ajax_update('?cmd=coupons&action=getclients&batchmode=1',{literal}{}{/literal}, '#loadcustomers', true);return false;">Change customer</a>
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td width="250" align="right"><strong>{$lang.maxusage}</strong></td>
                                <td>
                                    <input type="checkbox" name="coupon_config[max_usage_limit]" onclick="check_i(this)" {if $batch && $batch.coupon_config.max_usage}checked="checked"{/if} />
                                    <input size="4" name="coupon_config[max_usage]" class="inp config_val" {if !$batch || !$batch.coupon_config.max_usage}disabled="disabled"{/if}value="{$batch.coupon_config.max_usage}"/>
                                </td>
                            </tr>

                            <tr>
                                <td width="250" align="right"><strong>Max. use per one client</strong></td>
                                <td>
                                    <input type="checkbox" name="coupon_config[max_client_usage_limit]" onclick="check_i(this)" {if $batch && $batch.coupon_config.max_client_usage}checked="checked"{/if} />
                                    <input size="4" name="coupon_config[max_client_usage]" class="inp config_val" {if !$batch || !$batch.coupon_config.max_client_usage}disabled="disabled"{/if}value="{$batch.coupon_config.max_client_usage}"/>
                                </td>
                            </tr>

                            <tr>
                                <td width="250" align="right"><strong>{$lang.expdate}</strong></td>
                                <td>
                                    <input type="checkbox" onclick="check_i(this)" style="float:left" {if $batch && $batch.coupon_config.expires}checked="checked"{/if}/>
                                    <input name="coupon_config[expires]" class="inp config_val haspicker" {if !$batch || !$batch.coupon_config.expires} disabled="disabled"{/if} {if $batch.coupon_config.expires}value="{$batch.coupon_config.expires}"{/if}/>
                                </td>
                            </tr>

                            <tr>
                                <td width="250" align="right"><strong>{$lang.notesadmin}</strong></a></td>
                                <td><textarea name="coupon_config[notes]" style="height: 4em; width: 100%;">{if $batch.coupon_config.notes}{$batch.coupon_config.notes}{/if}</textarea>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-6" id="applicable">
                        <div class="form-group" id="toggles">
                            <label>{$lang.appliesto}:</label>
                            <div class="checkbox" style="margin-top: 0;">
                                <label>
                                    <input type="hidden" name="coupon_config[apply_products]" value="0"/>
                                    <input type="checkbox" id="apply_products" name="coupon_config[apply_products]" value="1" data-toggle="#products" data-clear="1" {if $batch.coupon_config.products}checked="checked"{/if}/> {$lang.Products}
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="hidden" name="coupon_config[apply_categories]" value="0"/>
                                    <input type="checkbox" id="apply_categories" name="coupon_config[apply_categories]" value="1" data-toggle="#categories" data-clear="1" {if $batch.coupon_config.categories}checked="checked"{/if}/> Categories
                                </label>
                            </div>

                            <div class="checkbox">
                                <label>
                                    <input type="hidden" name="coupon_config[apply_domains]" value="0"/>
                                    <input type="checkbox" id="apply_domains" name="coupon_config[apply_domains]" value="1" data-toggle="#domains" data-clear="1" {if $batch.coupon_config.domains}checked="checked"{/if}/> {$lang.Domains}
                                </label>
                            </div>

                            <div class="checkbox">
                                <label>
                                    <input type="hidden" name="coupon_config[apply_addons]" value="0"/>
                                    <input type="checkbox" id="apply_addons" name="coupon_config[apply_addons]" value="1" data-toggle="#addons" data-clear="1" {if $batch.coupon_config.addons}checked="checked"{/if}/> {$lang.Addons}
                                </label>
                            </div>

                            <div class="checkbox">
                                <label>
                                    <input type="hidden" name="coupon_config[apply_forms]" value="0"/>
                                    <input type="checkbox" id="apply_forms" name="coupon_config[apply_forms]" value="1" data-toggle="#forms" data-clear="1" {if $batch.coupon_config.forms}checked="checked"{/if} disabled/>
                                    Form components
                                    <span class="vtip_description">
                                    <div>
                                        When this option is enabled product price <strong><u>will not</u></strong> be
                                        discounted. Discount will only apply to price from selected form components.
                                        When disabled discount is calculated from product price and all forms that allow
                                        it.
                                    </div>
                                </span>
                                </label>
                            </div>
                        </div>

                        <div class="form-group" id="products" hidden>
                            <label>{$lang.appliproduc}</label>
                            <select multiple="multiple" name="coupon_config[products][]" class="form-control" data-chosen data-placeholder="Select applicable products" id="product_selector">
                                <option value="0" {if $batch.coupon_config.products.0=='0'}selected="selected"{/if} >{$lang.applytoall}</option>
                                {foreach from=$products item=i }
                                    {foreach from=$i item=prod name=product}
                                        {if $smarty.foreach.product.first}<optgroup label="{$prod.catname}">{/if}
                                        <option value="{$prod.id}" {if in_array($prod.id, $batch.coupon_config.products)}selected="selected"{/if}>{$prod.name}</option>
                                        {if $smarty.foreach.product.last}</optgroup>{/if}
                                    {/foreach}
                                {/foreach}
                            </select>
                        </div>

                        <div class="form-group" id="categories" hidden>
                            <label>Applicable categories</label>
                            <select multiple="multiple" name="coupon_config[categories][]" class="form-control" data-chosen data-placeholder="Select applicable product categories" id="category_selector">
                                {foreach from=$categories item=i key=c }
                                    <option value="{$c}" {if in_array($c, $batch.coupon_config.categories)}selected="selected"{/if}>{$i}</option>
                                {/foreach}
                            </select>
                        </div>

                        <div class="form-group" id="upgrades" hidden>
                            <label>{$lang.applyupgrades}</label>
                            <select multiple="multiple" name="coupon_config[upgrades][]" class="form-control">
                                <option value="0" {if $batch.coupon_config.upgrades.0=='0'}selected="selected"{/if}>{$lang.applyallupgrades}</option>
                                {foreach from=$upgrades item=i key=k}
                                    <option value="{$k}" {if in_array($k, $batch.coupon_config.upgrades)}selected="selected"{/if}>{$i}</option>
                                {/foreach}
                            </select>
                        </div>

                        <div class="form-group" id="addons" hidden>
                            <label>{$lang.appliaddons}</label>
                            <select multiple="multiple" name="coupon_config[addons][]" class="form-control" data-chosen data-placeholder="Select applicable addons" id="addon_selector">
                                <option value="0" {if $batch.coupon_config.addons.0=='0'}selected="selected"{/if}>{$lang.applialladd}</option>
                                {foreach from=$addons item=i key=k}
                                    <option value="{$k}" {if in_array($k, $batch.coupon_config.addons)}selected="selected"{/if}>{$i}</option>
                                {/foreach}
                            </select>
                        </div>

                        <div class="form-group" id="domains" hidden>
                            <label>{$lang.applidom}</label>

                            <select multiple="multiple" name="coupon_config[domains][]" class="form-control" data-chosen
                                    data-placeholder="Select applicable TLDs" id="domain_selector">
                                <option value="0" {if $batch.coupon_config.domains.0=='0'}selected="selected"{/if}>{$lang.applitld}</option>
                                {foreach from=$domains item=i key=k}
                                    <option value="{$k}" {if in_array($k, $batch.coupon_config.domains)}selected="selected"{/if}>{$i}</option>
                                {/foreach}
                            </select>
                            <div>
                                <div class="checkbox">
                                    <label>
                                        <input name="coupon_config[options][]" value="1" type="checkbox" {if in_array(1, $batch.coupon_config.options)}checked{/if}/>
                                        Apply to domain registration
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="coupon_config[options][]" value="2" type="checkbox" {if in_array(2, $batch.coupon_config.options)}checked{/if}/>
                                        Apply to domain transfers
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="coupon_config[options][]" value="4" type="checkbox" {if in_array(4, $batch.coupon_config.options)}checked{/if}/>
                                        Apply to domain renewals
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" id="cycles" hidden>
                            <label>{$lang.appcycles}</label>
                            <select multiple="multiple" name="coupon_config[cycles][]" class="form-control" data-chosen
                                    data-placeholder="Select applicable cycles" id="cycle_selector">
                                <option value="0" {if $batch.coupon_config.cycles.0=='0' || !$batch.id}selected="selected"{/if}>{$lang.appallcyc}</option>
                                {assign var='semi' value='Semi-Annually'}
                                <option value="Hourly" {if $batch.coupon_config.cycles.Hourly} selected="selected"{/if}>{$lang.Hourly}</option>
                                <option value="Daily" {if $batch.coupon_config.cycles.Daily} selected="selected"{/if}>{$lang.Daily}</option>
                                <option value="Weekly" {if $batch.coupon_config.cycles.Weekly} selected="selected"{/if}>{$lang.Weekly}</option>
                                <option value="Monthly" {if $batch.coupon_config.cycles.Monthly} selected="selected"{/if}>{$lang.Monthly}</option>
                                <option value="Quarterly" {if $batch.coupon_config.cycles.Quarterly} selected="selected"{/if}>{$lang.Quarterly}</option>
                                <option value="Semi-Annually" {if $batch.coupon_config.cycles[$semi]} selected="selected"{/if}>{$lang.SemiAnnually}</option>
                                <option value="Annually" {if $batch.coupon_config.cycles.Annually} selected="selected"{/if}>{$lang.Annually}</option>
                                <option value="Biennially" {if $batch.coupon_config.cycles.Biennially} selected="selected"{/if}>{$lang.Biennially}</option>
                                <option value="Triennially" {if $batch.coupon_config.cycles.Triennially} selected="selected"{/if}>{$lang.Triennially}</option>
                                {foreach from=$periods item=p}
                                    {assign var='tld' value="tld$p"}
                                    <option value="tld{$p}" {if $batch.coupon_config.cycles.$tld} selected="selected"{/if}>{$lang.Domains} {$p} {$lang.years}</option>
                                {/foreach}
                            </select>
                        </div>

                        <div class="form-group" id="forms" hidden>
                            <label>Applicable form components</label>
                            <select multiple="multiple" name="coupon_config[forms][]" class="form-control" data-chosen data-placeholder="Select applicable form variables" id="form_selector">
                                {foreach from=$applyforms item=variable}
                                    <option value="{$variable}" {if in_array($variable, $batch.coupon_config.forms)}selected="selected"{/if}>{$variable}</option>
                                {/foreach}
                            </select>
                            <div class="help-block">
                                <small>Select variables used in forms that you want to discount.</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        {literal}
            <style>
                .creditVouchersLoaderImg {
                    display: none;
                    margin: 0 auto;
                    text-align: center;
                }
            </style>
            <script>
                $(function () {
                    $('#code_layout').change(function () {
                        var sv = $(this).val() == 4;
                        console.log(sv);
                        $('.onchange_codelayout_hide').toggle(!sv);
                        $('.onchange_codelayout_show').toggle(sv);
                    }).trigger('change');
                });
            </script>
        {/literal}
        {if $action=='batch' && $batch.id}
            <a href="?cmd=coupons&action=batch&id={$batch.id}&make=codes" style="margin: 8px;" class="btn btn-default">Display codes</a>
        {/if}

        <div class="blu">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td>
                        {if $action=='batch' && !$batch.id}
                            <button class="btn btn-primary">Create batch</button>
                        {elseif $action=='batch' && $batch.id}
                            <button class="btn btn-primary">Save changes</button>
                        {/if}
                        <a class="btn btn-default" href="?cmd=coupons&action=batches">Cancel</a>
                    </td>
                </tr>
            </table>
        </div>
        {securitytoken}
    </form>
{/if}
