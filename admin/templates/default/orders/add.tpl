{if $action == 'createdraft'}
    {if $ajax}
        {include file='orders/ajax.add.tpl'}
    {else}
        <div class="blu" style="padding: 5px 0 8px 3px;">
            <a href="?cmd=orders" >
                <strong>&laquo; {$lang.backtoorders}</strong>
            </a>
        </div>
        {if $estimate}
            <div style="padding:5px;" class="lighterblue fs11">
                {$lang.order_draft_has_estimate}:
                <a href="?cmd=estimates&action=edit&id={$estimate.id}" target="_blank">
                    #{$estimate.id}
                </a>
                <hr style="margin: 10px 0px 0px 0px;"/>
            </div>
        {/if}

        <div class="order-draft">
            <h1>{$lang.newdraft} #{$draft.id}</h1>
            <div id="order_details">
                {include file='orders/ajax.add.tpl' }
            </div>

            <h1>Order items</h1>
            <form action="?cmd={$cmd}&action={$action}&make=add" method="post" onsubmit="order.edit(this); return false;">
                <input type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                <table width="100%" class="ordertable" cellpadding="3" cellspacing="0" border="0" >
                    <thead>
                    <tr >
                        <th style="width:30px"><img id="loadingindyk" style="display:none" src="{$template_dir}img/ajax-loader3.gif" /></th>
                        <th>
                            <a name="order_items"></a>
                            {$lang.Category}
                        </th>
                        <th >{$lang.Item}</th>
                        <th>{$lang.Configuration}</th>
                        <th style="width:134px">{$lang.setupfee}</th>
                        <th style="width:123px">{$lang.Price}</th>
                        <th style="width:30px">QTY</th>
                    </tr>
                    </thead>
                    <tbody class="order_items">
                    {include file='orders/ajax.add.tpl' make='getservice'}
                    </tbody>
                </table>
                <div class="p6 secondtd">
                    <a class="btn btn-success btn-sm" onclick="$(this).parents('form').submit(); return false;" >{$lang.savedraft|capitalize}</a>
                    <a class="btn btn-default btn-sm" href="?cmd={$cmd}&action={$action}&id={$draft_id}" >{$lang.revertchanges}</a>
                    <a class="btn btn-warning btn-sm" href="?cmd={$cmd}&action={$action}&id={$draft.id}&make=delete"
                       onclick="return confirm('{if $estimate}{$lang.order_draft_has_estimate2}\n{/if}{$lang.deleteorderconfirm}');" >{$lang.deldraft}</a>
                    <div class="order_price right">
                        {if $admindata.access.viewOrdersPrices}{$draft.price.cost|price:$draft.currency}{else}-{/if}
                    </div>
                    <div class="order_price_label right">Order total:</div>

                </div>

            </form>

            <h1>Add new item</h1>

            <ul id="tabbedmenu" class="tabs">
                <li class="tpicker active"><a onclick="return false" href="#tab1">New Service</a></li>
                <li class="tpicker"><a onclick="return false" href="#tab2">Clone/Upgrade Existing Services</a> </li>
            </ul>
            <div class="tab_container" style="overflow: visible">
                <form class="tab" action="?cmd={$cmd}&action={$action}&make=add" method="post" onsubmit="order.additem(this); return false;">
                    <input type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                    <table width="100%" class="draft-input" cellpadding="3" cellspacing="0" border="0" >
                        <tbody>
                        <tr >
                            <td style="width:160px">Select a product</td>
                            <td>
                                <select class="inp" style="min-width:160px" onchange="order.list_items(this)" name="items">
                                    <option value="service">{$lang.none}</option>
                                    <option value="service">{$lang.Service}</option>
                                    <option value="domain">{$lang.Domain}</option>
                                </select>
                            </td>
                        </tr>
                        </tbody>
                        <tbody id="order_item">
                        <tr ><td></td></tr>
                        </tbody>
                    </table>
                </form>
                <form class="tab" action="?cmd={$cmd}&action={$action}&make=add" method="post" onsubmit="order.additem(this); return false;">
                    <input type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                    <table width="100%" class="draft-input" cellpadding="3" cellspacing="0" border="0" >
                        <tbody>
                        <tr >
                            <td style="width:160px">Select client service</td>
                            <td>
                                <select class="inp client_services" style="min-width:160px" onchange="return order.load_service(this);" name="service">
                                    <option value="0">{$lang.none}</option>
                                    {foreach from=$clientservices item=item}
                                        <option value="{$item.id}">#{$item.id} {$item.name}{if $item.domain}({$item.domain}){/if}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr><td colspan="2" id="client_service"></td></tr>
                    </table>
                </form>
            </div>

            <h1>When ready:</h1>
            <ul id="tabbedmenu2" class="tabs">
                <li class="tpicker active"><a onclick="return false" href="#tab1">Generate Order</a></li>
                <li class="tpicker"><a onclick="return false" href="#tab2">Generate Estimate</a> </li>
            </ul>
            <div class="tab_container" style="overflow: visible" id="order_submit">
                <form class="tab2" style="padding:10px" method="post"
                      action="?cmd={$cmd}&action={$action}&id={$draft.id}&make=create">
                    {securitytoken}

                    <input type="hidden" name="invoice_generate" value="0">
                    <input type="hidden" name="confirm" value="0">
                    <input type="hidden" name="invoice_info" value="0">

                    <div class="form-group">
                        <label for="hostUrl">Additional options</label>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="1" name="invoice_generate"
                                       class="draft-option"
                                       {if $draft.options.generate_invoice}checked{/if} />
                                {$lang.generateinvoice}
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="1" name="confirm" class="draft-option"
                                       {if $draft.options.confirm_email}checked{/if} />
                                {$lang.sendconfirmemail}
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input id="invsend" type="checkbox" value="1" name="invoice_info"
                                       class="draft-option"
                                       {if !$draft.options.generate_invoice}disabled{/if}
                                       {if $draft.options.send_invoice}checked{/if} />
                                {$lang.sendinvoiceinfo}
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="keep_draft" value="1">
                                Don't remove this draft after generating order
                            </label>
                        </div>

                        {if $contract_templates}
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="force_generate_contract" value="1" class="draft-option" />
                                    Force generate new contract for this order
                                </label>
                            </div>

                            <div class="contract-template-select" style="display: none;">
                                <span>Contract template</span>
                                <select name="force_generate_contract_template">
                                    {foreach from=$contract_templates item=ct}
                                        <option value="{$ct.id}">{$ct.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        {/if}

                        {adminwidget module="orderdraft" section="additional_options"}
                    </div>

                    <button  type="submit" class="btn btn-primary"
                             onclick="return order.confirm_unsaved('There are some unsaved changes, do you want to continue?')" >{$lang.generatefromdraft}</button>



                </form>
                <form class="tab2" style="padding:10px" method="post" action="?cmd={$cmd}&action={$action}&id={$draft.id}&make=estimate">
                    {securitytoken}
                    <div class="form-group">
                        <label for="hostUrl">Additional options</label>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="dont_prorate" value="1" checked />
                                Do not use pro-rata on estimate items
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="accept_draft" value="1" checked />
                                Allow client to accept estimate in client portal
                            </label>
                        </div>

                        <div class="checkbox" style="display: none">
                            <label>
                                <input type="checkbox" name="lock_invoice" value="1" checked />
                                Lock invoice generated from client-accepted order for admin review
                            </label>
                        </div>

                        {adminwidget module="estimate" section="additional_options"}

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="send_draft" value="1" checked />
                                Send estimate to client
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="keep_draft" value="1" checked />
                                Don't remove this draft after generating estimate
                            </label>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="date_created" style="display: block">Estimate date</label>
                        <input type="text" name="date_created" value="{$details.date_created|dateformat:$date_format|regex_replace:'! [^\s]*$!':''}" class="haspicker "/>
                        <div class="clear"></div>
                    </div>
                    <div class="form-group">
                        <label for="date_expires" style="display: block">Estimate valid until</label>
                        <input type="text" name="date_expires" value="{$details.date_created|dateformat:$date_format|regex_replace:'! [^\s]*$!':''}" class="haspicker "/>
                        <div class="clear"></div>
                    </div>


                    <button type="submit" class="btn btn-primary"
                            onclick="return order.confirm_unsaved('There are some unsaved changes, do you want to continue?')" >Generate Estimate from this draft</button>


                </form>
            </div>

            <script type="text/javascript" src="{$template_dir}js/order.js?v={$hb_version}"></script>
            {literal}
            <script type="text/javascript">
                {/literal}
                order.cmd = '{$cmd}';
                order.action = '{$action}';
                {literal}
                order.cycle = {{/literal}
                    h:'{$lang.h}',d:'{$lang.d}',w:'{$lang.w}',m:'{$lang.m}',q:'{$lang.q}',
                    s:'{$lang.s}',a:'{$lang.a}',b:'{$lang.b}',t:'{$lang.t}',p4:'{$lang.p4}',
                    p5:'{$lang.p5}'
                {literal}};

                $(function(){
                    $('.order_items').delegate('input:not(.noevent), select:not(.noevent)', 'change',
                        function(data){
                        order.get_service($('.order_items').parents('form')[0]);
                    });
                    $('#tabbedmenu').TabbedMenu({elem:'.tab',picker:'li.tpicker',aclass:'active'});
                    $('#tabbedmenu2').TabbedMenu({elem:'.tab2',picker:'li.tpicker',aclass:'active'});

                    lock_estimate();

                    $('input[name="accept_draft"]').on('change', function () {
                        lock_estimate();
                    });

                    $('.draft-option').on('change', function () {
                        if(this.getAttribute('name') === 'invoice_generate'){
                            $('input[name=invoice_info]').prop('disabled', !this.checked)
                        }

                        if(this.getAttribute('name') === 'force_generate_contract'){
                            $('.contract-template-select').toggle(this.checked);
                            $('select[name=contract_id]').val('0');
                        }

                        let form = $('#order_details form');
                        let opt = $(this).closest('form').serializeForm();

                        for(let [key, value] of Object.entries(opt)){
                            let elm = form.find('input[name="'+key+'"]');
                            if(elm.length && elm.attr('type') === 'hidden'){
                                elm.val(value);
                            }
                        }
                        order.save_details();
                    });

                    $('select[name=contract_id]').on('change', function() {
                        $('.force_generate_contract').prop('checked', false).trigger('change');
                    });
                });

                function lock_estimate() {
                    var generate = $('input[name="accept_draft"]').prop('checked');
                    var lock = $('input[name="lock_invoice"]').parents('div .checkbox');
                    if (generate === true) {
                        lock.show();
                    } else {
                        lock.hide();
                    }
                }

            </script>
            {/literal}
            <br/>
            {include file='_common/noteseditor.tpl'}
            <script type="text/javascript">AdminNotes.show();AdminNotes.hide();</script>
        </div>

        <div class="blu">
            <a href="?cmd=orders" ><strong>&laquo; {$lang.backtoorders}</strong></a>
        </div>
    {/if}
{/if}
