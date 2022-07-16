{if $showlog}
    <div class="right"><strong><a href="javascript:void(0)" onclick="$('#ticket_log').hide();">{$lang.Hide}</a></strong></div>
    <div class="clear"></div>
    <table border="0" width="100%" class="tlog">
        {foreach from=$showlog item=log}
            <tr>
                <td class="light" align="right" width="140">{$log.date|dateformat:$date_format}</td>
                <td>{$log.action}</td>
            </tr>
        {/foreach}
    </table>
{/if}
{if $quote}
    {$quote}
{elseif $draftdate}
    {$lang.draftsavedat}{$draftdate|dateformat:$date_format}
{/if}
{if $action=='menubutton' && $make=='poll'}
    {include file="support/poll.tpl"}
{elseif $action=='view' && $ticket}
    {include file="support/ticket.tpl"}
{elseif $action=='new'}
    {include file="support/create.tpl"}
{elseif $action=='clientfilter'}
    {include file="support/ajax.clientfilter.tpl"}
{elseif $action=='default'}
    {include file="support/list.tpl"}
{elseif $action=='ticketinvoices'}
    {include file="support/ajax.ticketinvoices.tpl"}
{elseif $action=='queuedinvoiceitems'}
    {include file='ajax.itemqueue.tpl' place='support' items=$items account=false currency=$client_currency_details}
{elseif $action=='menubutton' && $make=='getrecent'}
    {if $reply}
        <div class="ticketmsg{if $reply.type!='Admin'} ticketmain{/if}" id="reply_{$reply.id}"><input type="hidden" name="viewtime" class="viewtime" value="{$reply.viewtime}"/>
            <div class="left">
                {if $reply.type!='Admin' && $ticket.client_id}
                    <a href="?cmd=clients&action=show&id={$ticket.client_id}" target="_blank">
                    {/if}
                    <strong {if $reply.type=='Admin'}class="adminmsg"{else}class="clientmsg reply_{$reply.type}"{/if}>
                        {$reply.name}</strong>
                        {if $reply.type!='Admin' && $ticket.client_id}
                    </a>
                {/if}
                {if $reply.type=='Admin'}
                    {$lang.staff}
                {elseif $reply.replier_id!='0'}
                    {$lang.client}
                {/if}, {$lang.wrote}
            </div>

            <div class="right">{$lang.replied} {$reply.date|dateformat:$date_format}&nbsp;&nbsp;&nbsp;</div>
            <div class="clear"></div>
            <p> {$reply.body|httptohref|nl2br} </p>
        </div>
    {/if}
{elseif $action=='menubutton' && $make=='editreply'}
    <p id="msgbody{$reply.id}">{$reply.newbody|httptohref|regex_replace:"/[^\S\n]+\n/":"<br>"|nl2br}</p>
    <div class="editbytext fs11" style="color:#555; font-style: italic">{$lang.lastedited} {$reply.editby} at {$reply.lastedit|dateformat:$date_format}</div>
    <script>
        var body = $('#msgbody{$reply.id}'),
            status = body.parent().data('status');
        if (status === 'Scheduled')
            body.css('opacity', 0.7);
    </script>
{elseif $action=='menubutton' && $make=='loadnotes'}
    {if $adminnotes}
        {foreach from=$adminnotes item=entry name=adminnt}
            <tr class="admin-note {if $smarty.foreach.adminnt.index%2!=0}odd{/if}">
                <td class="first">{$entry.date|dateformat:$date_format}</td>
                {assign var='admincolor' value=$entry.color%17}
                <td>
                    <small class="right" ><a href="#{$entry.id}" class="ticketnotesremove">[{$lang.Remove}]</a></small>
                    <strong class="admincolor{$admincolor}" style="color:#{if $ucolors.$admincolor}{$ucolors.$admincolor}{else}000{/if}">{$entry.name}</strong>
                    <div class="admin-note-body">{$entry.note|escape:'html':'UTF-8'|httptohref:'html'}</div>
                    {if !empty($entry.attachments[0])}
                        <div class="admin-note-attach">
                            {foreach from=$entry.attachments item=attachment}
                                <div class="attachment"><a href="?cmd=root&action=download&type=downloads&id={$attachment.id}">{$attachment.name}</a></div>
                                {/foreach}
                        </div>
                    {/if}
                </td>
            </tr>
        {/foreach}
    {/if}
{elseif $action=='getclients'}
    {foreach from=$clients item=cl}
        <option {if $cl.id == $client_id}selected="selected"{/if} value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
    {/foreach}
{elseif $action=='clienttickets'}
    {if $sorterpagination}
        {foreach from=$tickets item=ticket}
            <tr>
                <td><input type="checkbox" class="check" value="{$ticket.id}" name="selected[]"></td>
                <td>{$ticket.date|dateformat:$date_format}</td>
                <td>{$ticket.deptname}</td>
                <td>
                    <a href="?cmd=tickets&action=view&list={$currentlist}&num={$ticket.ticket_number}"
                       class="{if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}"
                    >{$ticket.tsubject|wordwrap:80:"\n":true|escape}</a>

                </td>
                <td>
                    {if $ticket.flags & 1}
                        <strong class="fa fa-sticky-note-o right ticketflag" aria-hidden="true"
                                title="Ticket with admin notes"></strong>
                    {/if}
                    {if $ticket.flags & 2}
                        <strong class="fa fa-dollar right ticketflag" aria-hidden="true"
                                title="Ticket with additional support fees"></strong>
                    {/if}
                    {if $ticket.flags & 4}
                        <strong class="fa fa-pencil-square-o right ticketflag" aria-hidden="true"
                                title="Another staff member started to write a response to this ticket"></strong>
                    {/if}
                    {if $ticket.flags & 16}
                        <strong class="fa fa-lock right ticketflag" aria-hidden="true"
                                title="This ticket is internal"></strong>
                    {/if}
                    {if $ticket.flags & 512}
                        <strong class="fa fa-pencil-square right ticketflag" aria-hidden="true"
                                title="The reply to the ticket is locked"></strong>
                    {/if}
                    {if $ticket.parent_id}
                        <strong class="fa fa-code-fork right ticketflag" aria-hidden="true"
                                title="This ticket has a parent thread"></strong>
                    {/if}
                    {if $ticket.tags}
                        <div class="right inlineTags">
                            {foreach from=$ticket.tags item=tag name=tagloop}
                                {if $smarty.foreach.tagloop.index < 3}
                                    <span style="background-color:{$tag.color}">{$tag.tag}</span>
                                {/if}
                            {/foreach}
                        </div>
                    {/if}

                </td>
                <td>
                    <span {if $ticket.status_color && $ticket.status_color != '000000'}style="color:#{$ticket.status_color}"{/if}
                          class="{$ticket.status}">
                        {if $ticket.status == 'Open'}{$lang.Open}
                        {elseif $ticket.status == 'Answered'}{$lang.Answered}
                        {elseif $ticket.status == 'Closed'}{$lang.Closed}
                        {elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}
                        {elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}
                        {else}{$ticket.status}{/if}
                    </span>
                </td>
                <td class="border_{$ticket.priority}">{$ticket.lastreply}</td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="7"><strong>{$lang.nothingtodisplay}</strong></td>
            </tr>
        {/foreach}
    {else}
        <div id="client-tickets">
            <div class="blu clearfix">
                {if !$ajax}
                    <div class="blu">
                        <h1>
                            <a href="?cmd=clients&action=show&id={$client.id}">
                                #{$client.id} - {$client|@client}</a> - {$lang.Tickets}
                        </h1>
                    </div>
                {/if}
                <div class="pull-right">
                    {include file='ajax.filterquicktool.tpl' client_id=$client_id
                    loadid='ticketslist' href="?cmd=tickets&action=getadvanced"}
                    <a href="?cmd=tickets&action=new&client_id={$client_id}"
                       class="btn btn-primary btn-xs" target="_blank">
                        <i class="fa fa-plus"></i> {$lang.opennewticket}
                    </a>
                </div>
                <form action="" method="post" class="left">

                    {$lang.status}
                    <select id="client_ticket_status" name="status" >
                        <option value="" {if !$selected_status}selected{/if}>{$lang.All}</option>
                        {foreach from=$statuses item=status}
                            <option value="{$status}" {if $status==$selected_status}selected{/if}>
                                {$lang.$status}
                            </option>
                        {/foreach}
                    </select>
                    <input type="hidden" name="id" value="{$client_id}"/>
                    <input type="hidden" name="action" value="clienttickets"/>
                    <input type="hidden" name="cmd" value="tickets"/>
                    {securitytoken}
                </form>

                <div class="clear"></div>

            </div>

            <form method="post" action="?cmd=orders" id="form_tickets">
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                    <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"></th>
                        <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder"
                               data-orderby="date">{$lang.datesubmitted}</a></th>
                        <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder"
                               data-orderby="dept_id">{$lang.department}</a></th>
                        <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder"
                               data-orderby="subject">{$lang.Subject}</a></th>
                        <th class="tagnotes"></th>
                        <th><a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder"
                               data-orderby="status">{$lang.Status}</a>
                        </th>
                        <th class="lastelb">
                            <a href="?cmd=tickets&action=clienttickets&id={$client_id}" class="sortorder"
                               data-orderby="lastreply">{$lang.Lastreply}</a>
                        </th>
                    </tr>
                    </tbody>
                    <tbody id="client-tickets-updater">
                    {include file="ajax.tickets.tpl" sorterpagination=1}
                    </tbody>
                </table>
            </form>
            <div class="row" style="margin-top: 10px;margin-bottom: 10px;">
                <div class="col-sm-12">
                    <div class="text-left">
                        <form action="" method="post" class="pull-left ticket_methods">
                            {$lang.withselected}
                            <a class="submiter menuitm menu-auto" name="markclosed" href="#"><span>{$lang.Close}</span></a>
                            {if !$forbidAccess.removeTicket}
                                <a class="submiter menuitm confirm menu-auto"
                                   name="markdeleted" href="#"><span style="color:#FF0000">{$lang.Delete}</span></a>
                            {/if}

                            <input type="hidden" name="id" value="{$client_id}"/>
                            <input type="hidden" name="action" value="clienttickets"/>
                            <input type="hidden" name="cmd" value="tickets"/>
                            {securitytoken}
                        </form>
                    </div>
                    {include file="_common/quicklists_pagination.tpl" name='tickets'
                    url="?cmd=tickets&action=clienttickets&id=`$client_id`&status=`$status`"}
                </div>
            </div>
        </div>
        {literal}
        <script>
            $(function () {
                var pagination = $('.pagination[data-name=client-tickets]').pagination({
                    sorter_controls: '#client-tickets .sortorder',
                    before_submit:function(data){
                        data.status = $('#client_ticket_status').val()
                    },
                    after_submit: bind_checks
                });

                $('#client_ticket_status').on('change', function(){
                    pagination.pagination('loadPage', 0);
                })

                $('[data-filter-modal=#ticketslist]').filterModal({
                    name: 'client-tickets',
                    sorter_link: '#client-tickets-sorter',
                    updater: '#client-tickets-updater',
                    after_submit: bind_checks
                });

                function bind_checks() {
                    var check_order = $('#client-tickets .check');
                    $('#client-tickets #checkall').off('change').on('change', function () {
                        check_order.prop('checked', this.checked);
                        check_order.closest('tr').toggleClass('checkedRow', this.checked);
                    });
                    check_order.on('change', function () {
                        $(this).closest('tr').toggleClass('checkedRow', this.checked);
                    });
                }

                bind_checks();

                $('#client-tickets .submiter').off('click').on('click', function () {
                    update_ticket(this);
                });
              })

            function update_ticket(button, params) {
                button = $(button);

                var form = $('#form_tickets').serializeForm();

                if (button.hasClass('confirm')) {
                    var conf = confirm({/literal}{$lang.perform_action|@json_encode}{literal});
                    if (conf === false) {
                        return false;
                    }
                }

                $('#client-tickets-updater').addLoader();
                form = $.extend(form, {
                    layer: 'ajax',
                    stack: button.attr('queue') ? 'push' : '',
                }, $.isPlainObject(params) ? params : {})


                $.post('?cmd=tickets&' + button.attr('name'), form, function (data) {
                    //parse_response(data); //error
                    $('.pagination[data-name=client-tickets]').pagination('reload');
                });

                return false;
            }
        </script>
    {/literal}
    {/if}
{elseif $action=='getadvanced'}
    <div class="filter-actions">
        {if $tview}
            <a href="?cmd={$cmd}&tview={$tview.id}&resetfilter=1" {if $currentfilter}style="display:inline"{/if} class="freseter">{$lang.filterisactive}</a>
        {else}
            <a href="?cmd=ticketviews&action=fromfilter"  {if $currentfilter}style="display:inline"{/if} ><b>Create View</b></a>
            <a href="?cmd=tickets&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        {/if}
    </div>
    <form class="searchform filterform" action="?cmd=tickets" method="post" onsubmit="return filter(this)">
       {include file="_common/filters.tpl"}
        {securitytoken}
    </form>

    <script type="text/javascript">bindFreseter();</script>
{/if}
