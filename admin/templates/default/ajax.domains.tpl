{if $action=='sync'}
    {include file='ajax.domainsync.tpl'}
{elseif $action=='getowners'}

    <div class="row">
        <div class="col-md-6 form-inline col-md-offset-3">
            <div class="form-group">
                <label>{$lang.newowner}</label>
                <select name="new_owner_id" class="form-control" load="clients" style="min-width:180px">

                </select>


            </div>
            <input type="submit" name="changeowner" value="{$lang.changedomainowner}"  style="font-weight:bold" class="btn btn-primary btn"/>

            <input type="button" value="{$lang.Cancel}" onclick="$('#ChangeOwner').hide();return false;" class="btn btn-default btn"/>

        </div>
    </div>
    <script>Chosen.find()</script>
{elseif $action=='cancelrequests'}
    {if $requests}
        <div class="box box-primary  no-padding" style="margin-top:20px;">
            <div class="box-header" style="padding:5px 10px;">
                <h3 class="box-title" style="font-size:12px">{$lang.canceltitle}</h3>
            </div>
            <div class="box-body">
                <table border="0" class="table whitetable">
                    {foreach from=$requests item=req}
                        <tr>
                            <td>
                                <a href="?cmd=domains&action=edit&id={$req.item_id}">
                                    #{$req.item_id} {$req.domain}
                                </a>
                            </td>
                        </tr>
                    {/foreach}
                </table>

            </div>
        </div>
    {/if}

{elseif $action=='getqueue'}

    <strong>{$lang.automationqueue}</strong>
    <div  class="p5 fs11">


        {foreach from=$queue item=q}
            <span class="left"  style="{if $q.status=='Canceled'}text-decoration:line-through;color:#808080{elseif $q.status=='OK'}color:#7ebd7a{elseif $q.when<0 && $q.status!='OK'}color:red{elseif $q.status=='Failed'}color:red{/if}" >
                {if $q.when>=0 }
                    {$lang.in}
                {/if} 
                {if $q.wt}
                    <b>{$q.wt}</b>
                {else}
                    <b>{$q.when}</b> {$lang.days} 
                    {if $q.when<0 }{$lang.ago}
                    {/if}
                {/if} 
                ({$q.date|dateformat:$date_format})
                {if $q.email_id}
                    <a target="_blank" href="?cmd=emailtemplates&action=edit&id={$q.email_id}">
                    {/if}
                    {if $lang[$q.task]}{$lang[$q.task]}
                    {else}{$q.task}
                    {/if}
                    {if $q.email_id}
                    </a>
                {/if}
                <br/>
            </span>
            {if $q.status=='Pending'}
                <a href="#" class="rembtn left" style="margin-left:6px;" 
                   onclick="if (confirm('Are you sure you wish to cancel this task?')) ajax_update('?cmd=domains&action=getqueue&id={$domain_id}&make=canceltask&task={$q.custom_id}', false, '#autoqueue', true); return false;">
                    {$lang.Remove}
                </a>
            {/if}
            {if $q.status=='Canceled' && $q.when>=0}
                <a href="#" class="editbtn left" style="margin-left:6px;" 
                   onclick="ajax_update('?cmd=domains&action=getqueue&id={$domain_id}&make=activatetask&task={$q.custom_id}', false, '#autoqueue', true); return false;">
                    {$lang.Activate}
                </a>
            {/if}
            <div class="clear"></div>
        {foreachelse}
            {$lang.noupcomingtasks}
        {/foreach}

    </div>

    <div id="tasklistloader" class="clear fs11">
        {include file='ajax.tasklist.tpl' place='singledomain' product_id=$domain_id}
    </div>

    <div class="fs11" style="text-align: right;padding-top: 5px">
        <!-- Single button -->
        <div class="btn-group pull-left">
            <a href="#" class="btn btn-default btn-sm" onclick=" ajax_update('?cmd=domains&action=getqueue&id={$domain_id}', false, '#autoqueue', true); return false">Refresh</a>
            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Schedule task <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="?cmd=tasklist&action=assigntask&id={$domain_id}&place=singledomain"
                       onclick="return HBTasklist.assignNew({$domain_id}, 'singledomain')">For this domain</a>
                </li>
                <li><a  href="?cmd=services&action=product&id={$pid}&picked_tab=2" target="_blank">For this tld</a></li>
            </ul>
        </div>

        <div >{$lang.currservertime} {$currentt|dateformat:$date_format}</div>
    </div>

    <div id="related-items" class="service-task-list" style="margin-top:17px">
        <strong>Related services</strong>
        {include file='ajax.accountrelations.tpl' place='domains' item_id=$domain_id item_type='Domain'
                 client_id=$client.id items=$relations client_currency=$service_currency}
    </div>

{elseif $action=='default'}
    {if $domains}
        {foreach from=$domains item=domain}
            <tr>
                <td><input type="checkbox" class="check" value="{$domain.id}" name="selected[]"/></td>
                <td><a href="?cmd=domains&action=edit&id={$domain.id}">{$domain.id}</a></td>
                <td>{if $domain.type=='Transfer'}{$lang.Transfer}: {/if}<a href="?cmd=domains&action=edit&id={$domain.id}">{$domain.name}</a>{if $domain.premium} <label class="label label-danger-invert">premium</label>{/if}</td>
                <td>{$domain|@profilelink:true:true}</td>
                <td>{if $domain.module}{$domain.module}{else}<em>{$lang.none}</em>{/if}</td>
                <td>{$domain.period} {$lang.yearslash}</td>
                <td align="center">{if $domain.date_created == '0000-00-00'}-{else}{$domain.date_created|dateformat:$date_format}{/if}</td>
                <td align="center">{if $domain.expires == '0000-00-00'}-{else}{$domain.expires|dateformat:$date_format}{/if}</td>
                <td><span class="{$domain.status}">{$lang[$domain.status]}</span> </td>
                <td>
                    {if $domain.autorenew=='1'}<span title="{$lang.autorenewis}{$lang.On}" class="domainicon autorenew_on"></span>{/if}
                    {if $domain.autorenew=='0'}<span title="{$lang.autorenewis}{$lang.Off}" class="domainicon autorenew_off"></span>{/if}
                    {if $domain.reglock=='0'}<span title="{$lang.reglockis}{$lang.Off}" class="domainicon reglock_off"></span>{/if}
                    {if $domain.reglock=='1'}<span title="{$lang.reglockis}{$lang.On}" class="domainicon reglock_on"></span>{/if}
                    {if $domain.idprotection=='0'}<span title="{$lang.idprotectionis}{$lang.Off}" class="domainicon protection_off"></span>{/if}
                    {if $domain.idprotection=='1'}<span title="{$lang.idprotectionis}{$lang.On}" class="domainicon protection_on"></span>{/if}

                </td>
                <td><a href="?cmd=domains&action=edit&id={$domain.id}" class="editbtn">{$lang.Edit}</a></td>

            </tr>

        {/foreach}
    {else}
        <tr><td colspan="11"><p align="center" >{$lang.Click} <a href="?cmd=orders&action=add">{$lang.here}</a> {$lang.toaddnewdomain}</p></td></tr>

    {/if}
{elseif $action=='log'}
    {if $sorterpagination}
        {foreach from=$loglist item=logg}
            <tr>
                <td>{$logg.date|dateformat:$date_format}</td>
                <td>{$logg.admin_login}</td>
                <td>{$logg.module}</td>
                <td>{$logg.action}</td>
                <td>{if $logg.result == 1}<font style="color:#006633">{$lang.Success}</font>{else}<font
                            style="color:#990000">{$lang.Failure}</font>{/if}</td>
                <td>
                    {if $logg.change}
                        {if $logg.change.serialized}
                            <ul class="log_list">
                                {foreach from=$logg.change.data item=change}
                                    <li>
                                        {if $change.name}<span class="log_change">{$change.name} :</span>
                                        {/if}
                                        {if $change.from == ''}
                                            <em>(empty)</em>
                                        {else}{$change.from}
                                        {/if}
                                        {if isset($change.to)} ->
                                            {if $change.to == 'empty'}<em>({$lang.empty})</em>
                                            {else}{$change.to}
                                            {/if}
                                        {/if}
                                    </li>
                                {/foreach}
                            </ul>
                        {else}{$logg.change.data}
                        {/if}
                    {/if}
                </td>
                <td>{$logg.error}</td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="6"><strong>{$lang.nothingtodisplay}</strong></td>
            </tr>
        {/foreach}
    {else}
        <div class="client-pagination-form form-inline text-right">
            <div class="form-group">
                <div class="pagination pull-right" data-profile="clientlist"
                     data-total-pages="{$totalpages}"
                     data-name="domain-logs"
                     data-updater="#domain-logs-updater"
                     data-url="?cmd=domains&action=log&id={$dom_id}">
                </div>
            </div>
        </div>
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike hover">
            <tbody>
            <tr>
                <th width="8%">{$lang.Date}</th>
                <th>{$lang.adminlogin}</th>
                <th>{$lang.Module}</th>
                <th width="18%">{$lang.Action}</th>
                <th width="8%">{$lang.Result}</a></th>
                <th width="35%">{$lang.Change}</th>
                <th width="16%">{$lang.Error}</th>
            </tr>
            </tbody>
            <tbody id="domain-logs-updater">
            {include file="ajax.domains.tpl" sorterpagination=1}
            </tbody>
        </table>
        <div class="client-pagination-form form-inline text-right">
            <div class="form-group">
                <div class="pagination pull-right" data-profile="clientlist"
                     data-total-pages="{$totalpages}"
                     data-name="domain-logs"
                     data-updater="#domain-logs-updater"
                     data-url="?cmd=domains&action=log&id={$dom_id}">
                </div>
            </div>
        </div>
    {literal}
        <script>
            $(function () {
                $('.pagination[data-name=domain-logs]').pagination();
            })
        </script>
    {/literal}
    {/if}
{elseif $action=='clientdomains'}
{if $sorterpagination}
    {foreach from=$domains item=domain}
        <tr>
            <td><input type="checkbox" class="check" value="{$domain.id}" name="selected[]"></td>
            <td><a href="?cmd=domains&action=edit&id={$domain.id}">{$domain.id}</a></td>
            <td>{if $domain.type=='Transfer'}{$lang.Transfer}: {/if}
                <a href="?cmd=domains&action=edit&id={$domain.id}">
                    {$domain.name}
                </a>
                {if $domain.premium}
                <label class="label label-danger-invert">premium</label>
                {/if}
            </td>

            <td>{$domain.period} {$lang.yearslash}</td>
            <td>{$domain.module}</td>
            <td><span class="{$domain.status}">{$lang[$domain.status]}</span></td>
            {if $admindata.access.viewDomainsPrices}
                <td>{$domain.recurring_amount|price:$domain.currency_id}</td>
            {/if}
            <td>{$domain.expires|dateformat:$date_format}</td>
            <td><a href="?cmd=domains&action=edit&id={$domain.id}" class="editbtn">{$lang.Edit}</a></td>
        </tr>
        {foreachelse}
            <tr>
                <td colspan="9">{$lang.nothingtodisplay}</td>
            </tr>
        {/foreach}
    {else}
        <div id="client-domains">
            <div class="blu clearfix">
                <div class="pull-right">
                    {include file='ajax.filterquicktool.tpl' client_id=$client_id
                        loadid='domainsfilter' href="?cmd=domains&action=getadvanced"}
                    <a href="?cmd=orders&action=add&related_client_id={$client_id}" class="btn btn-primary btn-xs"
                       target="_blank"><i class="fa fa-plus"></i> {$lang.newdomain}</a>
                </div>
            </div>
            <form method="post" action="?cmd=domains" id="form_domains">
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"></th>
                        <th><a href="?cmd=domains&action=clientdomains&id={$client_id}"
                               class="sortorder" data-orderby="id">{$lang.idhash}</a></th>
                        <th><a href="?cmd=domains&action=clientdomains&id={$client_id}"
                               class="sortorder" data-orderby="name">{$lang.Domain}</a></th>
                        <th><a href="?cmd=domains&action=clientdomains&id={$client_id}"
                               class="sortorder" data-orderby="period">{$lang.Period}</a></th>
                        <th><a href="?cmd=domains&action=clientdomains&id={$client_id}"
                               class="sortorder" data-orderby="module">{$lang.Registrar}</a></th>
                        <th><a href="?cmd=domains&action=clientdomains&id={$client_id}"
                               class="sortorder" data-orderby="status">{$lang.Status}</a></th>
                        {if $admindata.access.viewDomainsPrices}
                            <th><a href="?cmd=domains&action=clientdomains&id={$client_id}"
                                   class="sortorder" data-orderby="recurring_amount">{$lang.Amount}</a></th>
                        {/if}
                        <th><a href="?cmd=domains&action=clientdomains&id={$client_id}"
                               class="sortorder" data-orderby="expires">{$lang.Expires}</a></th>
                        <th width="20"></th>
                    </tr>
                    </tbody>
                    <tbody id="client-domains-updater">
                    {include file="ajax.domains.tpl" sorterpagination=1}
                    </tbody>
                </table>
            </form>
            <div id="confirm_ord_delete" hidden bootbox data-title="{$lang.deletedomain}"
                 data-btnclass="btn-danger" data-callback="clientlist_confirm_delete2">
                <form action="?cmd=domains&action=edit&make=delete" method="post">
                    <p><strong>{$lang.deletedomattempt}</strong></p>
                    <div class="radio">
                        <label>
                            <input type="radio" checked="checked" name="harddelete" value="true" class="cc_hard"/>
                            {$lang.deletedomhard}
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" name="harddelete" value="false"/>
                            {$lang.deletedomsoft}
                        </label>
                    </div>
                    <input type="hidden" name="id" value="{$details.id}"/>
                    {securitytoken}
                </form>
            </div>
            <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                <div class="col-sm-12">
                    <div class="text-left">
                        <form action="" method="post" class="pull-left domain_methods" style="">
                            {$lang.withselected}
                            <a class="menuitm menu-auto submiter renew confirm" name="renew"
                               onclick="return false" href="#" {if $enablequeue}queue='push'{/if}>
                                <span>{$lang.Renew}</span>
                            </a>
                            <a class="menuitm menu-auto submiter" {if $enablequeue}queue='push'{/if}
                               name="sync_quick" href="#"><span>{$lang.Synchronize}</span>
                            </a>
                            <a class="menuitm menu-auto" {if $enablequeue}queue='push'{/if}
                               name="delete" onclick="clientlist_confirm_delete_selected(); return false;" href="#">
                                <span style="color:#FF0000">{$lang.Delete}</span>
                            </a>
                            <input type="hidden" name="id" value="{$client_id}"/>
                            <input type="hidden" name="action" value="clientdomains"/>
                            <input type="hidden" name="cmd" value="domains"/>
                            {securitytoken}
                        </form>
                    </div>
                    {include file="_common/quicklists_pagination.tpl" name='domains'
                        url="?cmd=domains&action=clientdomains&id=`$client_id`"}
                </div>
            </div>
        </div>
    {literal}
        <script>
           $(function(){
               $('.pagination[data-name=client-domains]').pagination({
                   sorter_controls: '#client-domains .sortorder',
                   after_submit: bind_checks
               });

               $('[data-filter-modal=#domainsfilter]').filterModal({
                   name: 'client-domains',
                   sorter_link: '#client-domains-sorter',
                   updater: '#client-domains-updater',
                   after_submit: bind_checks
               });

               function bind_checks(){
                   var check_order = $('#client-domains .check');
                   $('#client-domains #checkall').off('change').on('change', function () {
                       check_order.prop('checked', this.checked);
                       check_order.closest('tr').toggleClass('checkedRow', this.checked);
                   });
                   check_order.on('change', function () {
                       $(this).closest('tr').toggleClass('checkedRow', this.checked);
                   });
               }

               bind_checks();

               $('#client-domains .submiter').off('click').on('click', function () {
                   update_domain(this);
               });

           })

            function clientlist_confirm_delete_selected() {
                if ($("#form_domains input[class=check]:checked").length < 1) {
                    alert('Nothing checked');
                } else {
                    $('#confirm_ord_delete').trigger('show');
                }
                return true;
            }

            function clientlist_confirm_delete2() {
                update_domain($('#client-domains a[name=delete]'),{
                    harddelete: $('.bootbox-body input.cc_hard').is(':checked'),
                    stack: 'push'
                })

                bootbox.hideAll()
                return false;
            }

            function update_domain(button, params) {
                button = $(button);

                var form = $('#form_domains').serializeForm();

                if (button.hasClass('confirm')) {
                    var conf = confirm({/literal}'{$lang.perform_action}'{literal});
                    if (conf === false) {
                        return false;
                    }
                }

                $('#client-domains-updater').addLoader();
                form = $.extend(form, {
                    layer: 'ajax',
                    stack: button.attr('queue') ? 'push' : '',
                }, $.isPlainObject(params) ? params : {})

                $.post('?cmd=domains&' + button.attr('name'), form, function (data) {
                    parse_response(data);
                    $('.pagination[data-name=client-domains]').pagination('reload');
                });

                return false;
            }

        </script>
    {/literal}
    {/if}
{elseif $action=='getadvanced'}
    <a href="?cmd=domains&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filerisactive}</a>
    <form class="searchform filterform" action="?cmd=domains" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">
        bindFreseter();
    </script>
{elseif $action=='extended'}
    {if $extendedinfo}
        <table cellpadding="2" width="100%">
            <tbody>
                {foreach from=$extendedinfo item=attribute}
                    {if $attribute.type!='text'}
                        <tr><td width="20%">{$attribute.description}:</td>
                            {if $attribute.type == 'select'}
                                <td><select name="ext[{$attribute.name}]">
                                        {foreach from=$attribute.option item=value}
                                            <option value="{$value.value}" {if $value.value == $attribute.default} selected="selected"{/if} >{$value.title}</option>
                                        {/foreach}
                                    </select></td>
                                {elseif $attribute.type == 'check'}
                                <td><input type="checkbox" name="ext[{$attribute.name}]" value="1" {if $attribute.default == '1'}checked="checked"{/if} /></td>
                                {else}
                                <td><input type="text" name="ext[{$attribute.name}]" size="20" value="{$attribute.default}"/></td>
                                {/if}

                        </tr>
                    {else}
                        <tr><td colspan="2">{$attribute.description}</td></tr>
                        {/if}
                    {/foreach}
                <tr><td colspan="2"><input type="submit" name="save_extended" value="{$lang.savechanges}" class="btn btn-sm btn-success" /></td></tr>
            </tbody>
        </table>
    {else}
        <strong>{$lang.noextendedinfo}</strong>
    {/if}

{elseif ($action=='preparecontacts' || $action=='regcommand' || $action=='callcustom') && $regcommand== "ContactInfo"}
    {literal}
        <script type="text/javascript">
            function pickcontact(type, elem) {
            $('.contactpicker.picked').removeClass('picked');
            $(elem).addClass('picked');
            $('.tblshown').hide().removeClass('tblshown');
            $('.CI_' + type).show().addClass('tblshown');
            }
            function context_submit(el) {
            ajax_update('?cmd=domains&action={/literal}{$action}{literal}&id=' + $('#domain_id').val() + '&command=' + $(el).attr('name'), $('#dom_forms').serialize(), '#man_content', true);
            return false;
            }
        </script>
    {/literal}

    <input type="hidden" name="regcommand" value="ContactInfo" />

    {if is_array($ContactInfo.registrant)}
        <div id="newshelf">
            <a href="#" onclick="pickcontact('registrant', this); return false" class="tchoice picked contactpicker">Registrant</a>
            <a href="#" onclick="pickcontact('admin', this); return false" class="tchoice contactpicker">Admin</a>
            <a href="#" onclick="pickcontact('tech', this); return false" class="tchoice contactpicker">Tech</a>
            <a href="#" onclick="pickcontact('billing', this); return false" class="tchoice contactpicker">Billing</a>
        </div>
    {/if}

    <table cellspacing="0" cellpadding="10" border="0" width="100%">
        {if is_array($ContactInfo.registrant)}
            {foreach from=$ContactInfo item=contact key=ctype name=lops}
                <tbody class="CI_{$ctype} {if $smarty.foreach.lops.first}tblshown{/if}" {if !$smarty.foreach.lops.first}style="display:none"{/if}>
                    <tr>
                        <td width="30%" valign="top">
                            <table cellpadding="2" width="100%">
                                {foreach from=$contact item=line key=name}
                                    <tr>
                                        <td align="right" width="120">{if $name == 'firstname'}{$lang.Name}{elseif $lang[$name]}{$lang.$name}{elseif $regfields[$name]}{$regfields[$name].name}{else}{$name|capitalize}{/if}</td>
                                        <td>
                                            {if $name === 'phonenumber' || $name == 'phone'}
                                                <input type="text" size="30" value="{$line|escape}" name="updateContactInfo[{$ctype}][{$name}]" {if $line == "disabled"}disabled="disabled" {/if} id="field_domain_{$ctype}_{$name}" data-initial-country="{$contact.country|default:$default_country}"/>
                                                <script >initPhoneNumberField($('#field_domain_{$ctype}_{$name}'));</script>
                                            {else}
                                                <input type="text" size="30" value="{$line|escape}" name="updateContactInfo[{$ctype}][{$name}]" {if $line == "disabled"}disabled="disabled" {/if}/>
                                            {/if}
                                        </td>
                                    </tr>
                                {/foreach}
                            </table>    
                        </td>
                    </tr>
                </tbody>
            {/foreach}
        {else}
            <tbody>
                <tr>
                    <td width="30%" valign="top">
                        <table cellpadding="2" width="100%">
                            {foreach from=$ContactInfo item=line key=name}
                                <tr>
                                    <td align="right" width="120">{if $name == 'firstname'}{$lang.Name}{elseif $lang[$name]}{$lang.$name}{elseif $regfields[$name]}{$regfields[$name].name}{else}{$name|capitalize}{/if}</td>
                                    <td>
                                        {if $name === 'phonenumber' || $name == 'phone'}
                                            <input type="text" size="30" value="{$line|escape}" name="updateContactInfo[{$name}]" {if $line == "disabled"}disabled="disabled" {/if} id="field_domain_{$name}" data-initial-country="{$contact.country|default:$default_country}"/>
                                            <script >initPhoneNumberField($('#field_domain_{$name}'));</script>
                                        {else}
                                            <input type="text" size="30" value="{$line|escape}" name="updateContactInfo[{$name}]" {if $line == "disabled"}disabled="disabled" {/if}/>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        </table>    
                    </td>
                </tr>
            </tbody>
            {if $ContactInfo.extended}
                <tbody>
                    <tr>
                        <td colspan="2">
                            <table cellpadding="2" width="100%">
                                <tbody>
                                    <tr><td width="100" ><strong>{$lang.extendedinfo}:</strong></td></tr>
                                    {foreach from=$ContactInfo.extended item=attribute}
                                        <tr><td>{$attribute.description}:</td>
                                            {if $attribute.input}
                                                <td>
                                                    <input type="text" name="updateContactInfo[extended][{$attribute.name}]" size="20" value="{$attribute.default}"/>
                                                </td>
                                            {else}
                                                <td>
                                                    <select name="updateContactInfo[extended][{$attribute.name}]">
                                                        {foreach from=$attribute.option item=value}
                                                            <option value="{$value.value}" {if $value.value == $attribute.default} selected="selected"{/if} >{$value.title}</option>
                                                        {/foreach}
                                                    </select>
                                                </td>
                                            {/if}
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            {/if}
        {/if}
    </table>
    <input type="submit" name="updateContactInfo" value="{$lang.savechanges}" {if $action=='preparecontacts'}onclick="return context_submit(this);"{else}onclick="return ext_submit(this);"{/if} class="btn btn-sm btn-success" />
{elseif ($action=='regcommand' || $action=='callcustom') && $regcommand=="DNSmanagement"}
    {if $DNSmanagement.redirect}
        <div style="text-align: center; padding: 20px;">
            {if $DNSmanagement.url}{$lang.Click} <a href="{$DNSmanagement.url}" target="_blank">{$lang.here}</a> {$lang.tomanage}
            {else}{$lang.erroroccured}: {$DNSmanagement.error} {/if}
        </div>
    {else}
        {literal}
            <script type="text/javascript">
                function priority_input(that){
                var prioin = $(that).parents('tr').first().find('.priorityin');
                $(that).val() == 'MX' || $(that).val() == 'SRV' ? prioin.prop('disabled', false).removeAttr('disabled') : prioin.prop('disabled', true).attr('disabled', 'disabled');
                }
            </script>
        {/literal}
        <input type="hidden" name="regcommand" value="DNSmanagement" />


        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike">
            {foreach from=$DNSmanagement.hosts key=number item=host name=frea}
                {if $host.ttl}{assign var=ttl value=true}{/if}
            {/foreach}
            <tr>
                <th>{$lang.host_name}</th>
                <th>{$lang.priority}</th>
                {if $ttl}
                    <th style="width:70px">{$lang.ttl|default:"TTL"}</th>
                {/if}
                <th>{$lang.recordtype}</strong></th>
                <th>{$lang.recordaddress}</th>
            </tr>

            {foreach from=$DNSmanagement.hosts key=number item=host}
                {if $host.ttl}{assign var=ttl value=true}{/if}
                <tr>
                    <td><input type="text" size="15" value="{$host.hostname}" name="updateDNSmanagement[HostName{$number}]"/></td>
                    <td>
                        <input type="text" size="3" class="priorityin" {if $host.recordtype != 'MX' && $host.recordtype != 'SRV'}disabled="disabled"{/if} value="{$host.priority}" name="updateDNSmanagement[Priority{$number}]"/>
                    </td>
                    {if $ttl}
                        <td><input type="text" style="display: block;width: 70px" value="{$host.ttl|escape}" name="updateDNSmanagement[TTL{$number}]"/></td>
                    {/if}
                    <td>
                        <select name="updateDNSmanagement[RecordType{$number}]" onchange="priority_input(this)">
                            {foreach from=$DNSmanagement.records item=record}
                                <option {if $host.recordtype == $record}selected="selected"{/if}>{$record}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td>
                        <input type="text" size="15" value="{$host.address|escape}" name="updateDNSmanagement[Address{$number}]"/>
                    </td>
                </tr>
            {/foreach}
            <tr>
                <th colspan="{if $ttl}5{else}4{/if}">
                    <strong>{$lang.addnewline}</strong>
                </th>
            </tr>
            <tr>
                <td><input type="text" size="15" value="" name="updateDNSmanagement[newHostName]"/></td>
                <td>
                    <input type="text" class="priorityin" {if $DNSmanagement.records[0] != 'MX' && $DNSmanagement.records[0] != 'SRV'}disabled="disabled"{/if} size="3" name="updateDNSmanagement[newPriority]"/>
                </td>
                {if $ttl}
                    <td><input type="text" class="styled"  style="width: 70px;" name="updateDNSmanagement[newTTL]"/></td>
                {/if}
                <td>
                    <select  name="updateDNSmanagement[newRecordType]" onchange="priority_input(this)">
                        {foreach from=$DNSmanagement.records item=record}
                            <option>{$record}</option>
                        {/foreach}
                    </select>
                </td>
                <td><input type="text" size="15" name="updateDNSmanagement[newAddress]"/></td>
            </tr>
        </table>
        <div class="blu"> <input type="submit" name="updateDNSmanagement" value="{$lang.savechanges}" onclick="return ext_submit(this);" class="btn btn-sm btn-success" /></div>
        {/if}
    {elseif ($action=='regcommand' || $action=='callcustom') && $regcommand== "EmailForwarding"}
        {if $EmailForwarding.redirect}
        <div style="text-align: center; padding: 20px;">
            {if $EmailForwarding.url}{$lang.Click} <a href="{$EmailForwarding.url}" target="_blank">{$lang.here}</a> {$lang.tomanage}
            {else}{$lang.erroroccured}: {$EmailForwarding.error} {/if}
        </div>
    {else}

        <input type="hidden" name="regcommand" value="EmailForwarding" />

        <table cellspacing="0" cellpadding="10" border="0" width="100%" class="table glike">
            <tr>
                <th>{$lang.Prefix}:</td><th>{$lang.forwardto}:</th>
            </tr>
            {foreach from=$EmailForwarding key=number item=Forwarding}
                <tr>
                    <td><input type="text" size="15" value="{$Forwarding.address}" name="updateEmailForwarding[ForwardAddress{$number}]"/> @ {$details.name} &raquo;&raquo;</td>
                    <td><input type="text" size="30" value="{$Forwarding.forwardto}" name="updateEmailForwarding[ForwardTo{$number}]"/></td>
                </tr>
            {/foreach}
            <tr>
                <td><input type="text" size="15" value="" name="updateEmailForwarding[newForwardAddress]"/> @ {$details.name} &raquo;&raquo;</td>
                <td><input type="text" size="30" value="" name="updateEmailForwarding[newForwardTo]"/></td>
            </tr>
        </table>

        <div class="blu">
            <input type="submit" name="updateEmailForwarding" value="{$lang.savechanges}" onclick="return ext_submit(this);" class="btn btn-sm btn-success" />
        </div>
    {/if}
{elseif ($action=='regcommand' || $action=='callcustom') && $regcommand=="DomainForwarding"}
    <input type="hidden" name="regcommand" value="DomainForwarding" />
    <table cellspacing="0" cellpadding="3" border="0" width="100%">
        <tr><td>{$lang.Destination}:</td><td><select name="updateDomainForwarding[destination_prefix]"><option>http://</option><option>https://</option></select><input type="text" size="30" value="" name="updateDomainForwarding[destination]"/></td></tr>
        <tr><td>{$lang.urlmasking}:</td><td><input type="checkbox" value="1" name="updateDomainForwarding[urlmasking]" /></td></tr>
        <tr><td>{$lang.subdomainfwd}:</td><td><input type="checkbox" value="1" name="updateDomainForwarding[subdomainfwd]" /></td></tr>
    </table>
    <div><input type="submit" name="updateDomainForwarding" value="{$lang.savechanges}" onclick="return ext_submit(this);" class="btn btn-sm btn-success" /></div>

{elseif $action=='regcommand' && $regcommand== "EppCode"}
    {if $EppCode}
        {$EppCode}
    {/if}

{elseif ($action=='regcommand' || $action=='callcustom') && $regcommand== "RegisterNameServers"}
    {if $getRegisterNameServers}
        <input type="hidden" name="regcommand" value="RegisterNameServers" />
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike hover">
            <tr><th width="40%">{$lang.Hostname}</th><th width="25%">{$lang.IPaddress}</th><th width="25%"></th><th width="10%"></th></tr>
                    {if $RegisterNameServers}
                        {foreach from=$RegisterNameServers item=ips key=name}
                            {foreach from=$ips item=ip name=ip_list}
                        <tr height="30">
                            <td {if !$smarty.foreach.ip_list.last}style="border-bottom: 0px"{/if}>{if $smarty.foreach.ip_list.iteration == "1"}{$name}.{$details.name}{/if}<input name="modifyNameServer[NameServer]" value="{$name}" type="hidden" /><input name="deleteNameServer[NameServer]" value="{$name}" type="hidden" /></td>
                            <td {if !$smarty.foreach.ip_list.last}style="border-bottom: 0px"{/if}><input type="hidden" value="{$ip}"  name="deleteNameServer[NameServerDeleteIP]" /><input type="hidden" value="{$ip}"  name="modifyNameServer[NameServerOldIP]" /><input value="{$ip}" name="modifyNameServer[NameServerNewIP]" style="display: none;" class="ip_edit" size="15" /><span class="ip_notedit">{$ip}</span></td>
                            <td  style="{if !$smarty.foreach.ip_list.last}border-bottom: 0px;{/if} text-align: center"><input type="submit" value="{$lang.Save}" class="ip_edit" style="display: none;" onclick="update_regns(this); return false" /> <input type="submit" onclick="$('.ip_edit').hide(); $('.ip_notedit').show(); return false;" value="{$lang.Cancel}" class="ip_edit" style="display: none;"/><a href="" onclick="show_nsedit(this); return false;" class="ip_notedit">{$lang.Edit}</a></td>
                            <td {if !$smarty.foreach.ip_list.last}style="border-bottom: 0px"{/if}><a href="" onclick="if (confirm('{$lang.deleteregnsconfirm}')) del_regns(this); return false;" class="editbtn">{$lang.Delete}</a></td>
                        </tr>
                    {/foreach}
                {/foreach}
            {else}
                <tr><td colspan="4" style="text-align: center">{$lang.no_regservers}</td></tr>
                {/if}
            <tr><th colspan="4" style="text-align: center"><a href="" onclick="if ($('.add_regns').hasClass('shown'))$('.add_regns').removeClass('shown').hide(); else $('.add_regns').addClass('shown').show(); return false;">{$lang.registeranameserver}</a></th></tr>
            <tr class="add_regns" style="display:none"><td colspan="1" style="text-align: right">
                    <input type="hidden" name="management[RegisterNameServers]" value="RegisterNameServers" />
                    {$lang.Nameserver}: </td><td colspan="3"><input type="text" name="registerNameServer[NameServer]"/>.{$details.name}&nbsp;</td></tr>
            <tr class="add_regns" style="display:none"><td colspan="1" style="text-align: right">{$lang.IPaddress}: </td><td colspan="3"><input type="text" name="registerNameServer[NameServerIP]"/></td></tr>
            <tr class="add_regns" style="display:none"><td colspan="4" style="text-align: center"><input type="submit" name="registerNameServer" value="{$lang.addns}" onclick="return ext_submit(this);"/> <input type="submit" name="" value="{$lang.Cancel}" onclick="$('.add_regns').removeClass('shown').hide(); return false;"/></td></tr>

        </table>
        <script type="text/javascript">
            {literal}
                function show_nsedit(elem) {
                $('.ip_edit').hide();
                $('.ip_notedit').show();
                $(elem).parent().parent().find('.ip_edit').show();
                $(elem).parent().parent().find('.ip_notedit').hide();
                }
                function update_regns(el) {
                var params = 'regcommand=RegisterNameServers';
                $(el).parent().parent().find('input').each(function() {
                params += '&' + $(this).attr('name') + '=' + $(this).val();
                });
                ajax_update('?cmd=domains&action=callcustom&id=' + $('#domain_id').val() + '&command=modifyNameServer', params, '#man_content', true);
                return false;
                }
                function del_regns(el) {
                var params = 'regcommand=RegisterNameServers';
                $(el).parent().parent().find('input').each(function() {
                params += '&' + $(this).attr('name') + '=' + $(this).val();
                });
                ajax_update('?cmd=domains&action=callcustom&id=' + $('#domain_id').val() + '&command=deleteNameServer', params, '#man_content', true);
                return false;
                }

            {/literal}
        </script>
    {else}
        <input type="hidden" name="regcommand" value="RegisterNameServers" />


        <fieldset style="border:solid 1px #2E70D2;">
            <legend>{$lang.registeranameserver}:</legend>
            <input type="hidden" name="management[RegisterNameServers]" value="RegisterNameServers" />
            {$lang.Nameserver}: <input type="text" name="registerNameServer[NameServer]"/>.{$details.name}&nbsp; <br />
            {$lang.IPaddress}: <input type="text" name="registerNameServer[NameServerIP]"/><br />
            <input type="submit" name="registerNameServer" value="{$lang.addns}" onclick="return ext_submit(this);" class="btn btn-sm btn-success" />
        </fieldset>
        <br />


        <fieldset style="border:solid 1px #2E70D2;">
            <legend>{$lang.modifyans}:</legend>
            {$lang.Nameserver}: <input type="text" name="modifyNameServer[NameServer]"/>.{$details.name}<br />
            {$lang.currentip}: <input type="text" name="modifyNameServer[NameServerOldIP]"/> <br />
            {$lang.newip}: <input type="text" name="modifyNameServer[NameServerNewIP]"/><br />
            <input type="submit" name="modifyNameServer" value="{$lang.savechanges}" onclick="return ext_submit(this);" class="btn btn-sm btn-info" />
        </fieldset>
        <br />

        <fieldset style="border:solid 1px #2E70D2;">
            <legend>{$lang.deleteans}:</legend>
            {$lang.Nameserver}: <input type="text" size="15" name="deleteNameServer[NameServer]"/>.{$details.name}&nbsp;&nbsp;<input type="submit" name="deleteNameServer" value="{$lang.Delete}" onclick="return ext_submit(this);" class="btn btn-sm btn-danger" />
        </fieldset>
    {/if}
{/if}
