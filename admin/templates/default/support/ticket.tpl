<script type="text/javascript" src="{$template_dir}js/photoswipe/photoswipe.min.js"></script>
<script type="text/javascript" src="{$template_dir}js/photoswipe/photoswipe-ui-default.min.js"></script>
<script type="text/javascript" src="{$template_dir}js/hbfiles.js"></script>
<link rel="stylesheet" type="text/css" href="{$template_dir}js/photoswipe/photoswipe.min.css">
<link rel="stylesheet" type="text/css" href="{$template_dir}js/photoswipe/default-skin.min.css">

<input type="hidden" id="ticket_number" name="ticket_number" value="{$ticket.ticket_number}" />
<input type="hidden" id="ticket_id" name="ticket_id" value="{$ticket.id}" />
<div class="blu">
    <div class="menubar">
        {include file="support/ticket_actions.tpl"}
    </div>
</div>
<div id="ticket_log"></div>
<div class="lighterblue" id="ticket_editdetails" style="display:none">
    <form action="?cmd={$cmd}&action={$action}&num={$ticket.ticket_number}" method="post" id="ticket_editform"></form>
</div>
<input type="hidden" id="order_replies" value="{if $order_replies === 'newest'}:first{else}:last{/if}">
<div id="ticketbody" {if $ticket.priority=='1'}class="prior_Medium"{elseif $ticket.priority=='2'}class="prior_High"{elseif $ticket.priority=='3'}class="prior_Critical"{/if}>
    <h1 {if $ticket.priority=='1'}class="prior_Medium"{elseif $ticket.priority=='2'}class="prior_High"{elseif $ticket.priority=='3'}class="prior_Critical"{/if}>#{$ticket.ticket_number} - {$ticket.subject|wordwrap:100:"\n":true|strip_tags|ticketlink}
        <span {if $ticket.status_color && $ticket.status_color != '000000'}style="color:#{$ticket.status_color}"{/if} class="{$ticket.status}" id="ticket_status">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if}</span>
    </h1>

    {literal}

        <script type="text/javascript">
            $(function () {
                $('#tagsCont').hbtags({colors: true})
                    .on('tags.add', function (e, tag, hbtags) {
                        if(!hbtags.ready)
                            return;

                        $.post('?cmd=tickets&action=addtag', {
                            tag: tag,
                            id: $('#ticket_number').val()
                        }, function (data) {
                            if (data.tags == undefined || data.tags.length < 1) {
                                var codes = eval('(' + data.substr(data.indexOf('<!-- ')+4, data.indexOf('-->')-4) + ')');
                                if (codes.ERROR.length > 0) {
                                    $('#tagsCont').children().each(function () {
                                        if ($(this).children('a').first().text() === tag) {
                                            $(this).hide();
                                            hbtags.tags.splice($.inArray(tag, hbtags.tags), 1);
                                        }
                                    });
                                    parse_response(data);
                                    return;
                                }
                            }

                            ticket.updateTags(data.tags)
                        });
                    })
                    .on('tags.color', function (e, tag, color) {
                        $.post('?cmd=tickets&action=colortag', {
                            tag: tag,
                            color: color,
                            id: $('#ticket_number').val()
                        }, function (data) {
                            ticket.updateTags(data.tags)
                        });
                    })
                    .on('tags.rem', function (e, tag) {
                        $.post('?cmd=tickets&action=removetag', {
                            tag: tag,
                            id: $('#ticket_number').val()
                        }, function (data) {
                            if (typeof data != 'undefined' && typeof data.reloadwhole != 'undefined' && data.reloadwhole == true) {
                                ajax_update('?cmd=tickets&action=view&list=all&num=' + $('#ticket_number').val(), {}, '#bodycont');
                            } else if (typeof data != 'undefined') {
                                ticket.updateTags(data.tags);
                                if (data.tickettags !== undefined) {
                                    insertTags(data.tickettags);
                                }
                            }
                        });
                    });


                $('#tagsBox').on('tag.update', function (ev, tags) {
                    $('#tagsCont').data('hbtags').suggestions = tags.map(function (x) {
                        return x.tag;
                    })
                });

                $(document).off('click', '#tagsCont span a:first-child').on('click', '#tagsCont span a:first-child', function () {
                    window.open('?cmd=tickets&filter[tag]=' + $(this).text());
                });
            })

            function remove_attachment(id, reply, self) {
                var q = confirm('{/literal}{$lang.delete_attachment_q}{literal}');
                if (!q)
                    return false;
                $.post('?cmd=tickets&action=delete_attachment', {
                    number: $('#ticket_number').val(),
                    attach_id: id,
                    reply_id: reply
                }, function (response) {
                    var data = parse_response(response);
                    if (data) {
                        var codes = eval('(' + response.substr(response.indexOf('<!-- ') + 4, response.indexOf('-->') - 4) + ')');
                        if (codes.ERROR.length > 0)
                            data = false;
                    }
                    if (data) {
                        var well = $(self).parents('.well');
                        $('.ticket_attachment[data-id="'+id+'"][data-reply-id="'+reply+'"]').remove();
                        if (well.length === 1) {
                            if ($(well[0]).children().length === 0) {
                                $(well[0]).hide();
                            }
                        }
                    }
                })
            }
        </script>
    {/literal}

    <div id="tagsCont" class="tag-form tag-form-main" data-tags="{$tags|@json_encode|escape}" data-tags_colors="{$tags_colors|@json_encode|escape}"></div>

    {if $ticket.client_id!='0'}
        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.ticketmessage}</a>
            {include file="_common/quicklists.tpl" _client=$client.id _parent=$client.parent_id}
            <div class="clear"></div>
        </div>
    {else}
        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.ticketmessage}</a>

            <span class="left" style="padding-top:5px;padding-left:5px;">
                <strong>{$ticket.orgname}</strong>
    </span>
            {if !($ticket.flags & 8)}<div>
                <span class="left" style="padding-top:5px;padding-left:5px;">
                    <form action="?cmd=newclient" method="post" target="_blank">
                        <a href="#" onclick="$(this).parent().submit();
                                return false;">Register as new client</a>
                        <input type="hidden" name="email" value="{$ticket.email}" />
                        <input type="hidden" name="firstname" value="{$ticket.name|regex_replace:"/^([^ ]+)\s.+$/":'$1'|escape}" />
                        <input type="hidden" name="lastname" value="{$ticket.name|regex_replace:"/^[^ ]+\s?/":'$1'|escape}" />
                        <input type="hidden" name="ticket_id" value="{$ticket.id}" />
                    </form>
                </span>
            </div>{/if}
            <div class="clear"></div>
        </div>
    {/if}
    <div class="ticketmsg {if $ticket.type!='Admin'}ticketmain{/if}"  id="client_tab">
        <div class="slide" style="display:block">


            <div class="left ticketinfoblock">
                {if $ticket.client_id!='0'  && $ticket.type!='Admin'}
                    <a href="?cmd=clients&action=show&id={$ticket.client_id}" target="_blank">
                    {/if}
                    <strong {if $ticket.type=='Admin'}class="adminmsg"{else}class="clientmsg reply_{$ticket.type}"{/if}>{$ticket.name}</strong>
                    {if $ticket.client_id!='0'  && $ticket.type!='Admin'}
                    </a>
                {/if}
                {if $ticket.client_id!='0' && $ticket.type=='Client'}<label class="label label-success-invert">{$lang.client}</label>
                {elseif $ticket.type=='Admin'}<label class="label label-info-invert">{$lang.staff}</label>
                {/if}
                {if $ticket.type!='Admin' && $ticket.from}
                    <div class="ticketinfo msg-source">{$ticket.from}</div>
                {/if}
                <span class="ticketinfo">
                {$lang.opened} {$ticket.date|dateformat:$date_format}

                    {if $ticket.type == 'Client'} using client area, logged in
                    {elseif $ticket.type == 'Unregistered'} from client area, not logged in
                    {elseif $ticket.metadata.source}
                        via {$ticket.metadata.source.name}
                    {elseif $ticket.type != 'Admin'} via Email
                    {/if}
                    &nbsp;&nbsp;&nbsp;
                 </span>

                <span class="ticket-encrypted-message" style="color: #ea8813; {if $ticket.flags & 1024}display:inline-block;{else}display:none;{/if}">{$lang.messageencryptedinfo}</span>

            </div>

            <div class="tdetails auto-height" style="float: right; border-left: 1px solid #bbb; background: #f7f7f7; padding: 5px; margin: -5px -10px -5px 15px; max-width: 350px">
                {if !$forbidAccess.editTicket}
                    <a href="#" class="fs11 right btn btn-sm btn-default" data-toggle="modal" data-target="#editTicketModal">Edit details</a>

                    <div class="modal fade" id="editTicketModal" tabindex="-1" role="dialog" aria-labelledby="editTicketModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editTicketModalLabel">Edit ticket details</h4>
                                </div>
                                <div class="modal-body">

                                    <div class="form-group">
                                        <label class="control-label">{$lang.subject|capitalize}</label>
                                        <input type="text" name="subject" value="{$ticket.subject|escape}" class="form-control"/>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label">{$lang.department}</label>
                                                <select class="form-control" name="deptid">
                                                    {foreach from=$departments item=dept}
                                                        <option value="{$dept.id}" {if $ticket.dept_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label">{$lang.request_type}</label>
                                                <select class="form-control" name="request_type">
                                                    <option value="General" {if $ticket.request_type=='General'}selected="selected"{/if}>{$lang.General}</option>
                                                    <option value="Incident" {if $ticket.request_type=='Incident'}selected="selected"{/if}>{$lang.Incident}</option>
                                                    <option value="Problem" {if $ticket.request_type=='Problem'}selected="selected"{/if}>{$lang.Problem}</option>
                                                    <option value="Question" {if $ticket.request_type=='Question'}selected="selected"{/if}>{$lang.Question}</option>
                                                    <option value="Task" {if $ticket.request_type=='Task'}selected="selected"{/if}>{$lang.Task}</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label">{$lang.submitter}</label>
                                                <input type="text" name="name" value="{$ticket.name|escape}" class="form-control"/>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            {if !$ticket.share || $ticket.share=='master'}
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        {if $ticket.metadata.source}
                                                            Source
                                                        {else}
                                                            {$lang.emaill|capitalize}
                                                        {/if}
                                                    </label>
                                                    <input type="text" name="email" value="{$ticket.email}" autocomplete="off" class="form-control"/>
                                                </div>
                                            {else}
                                                <div class="form-group">
                                                    <label class="control-label">{$lang.author_uuid}</label>
                                                    <input type="text" name="email" value="{$ticket.email}" autocomplete="off" class="form-control"/>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">{$lang.asignedclient}/contact</label><br>
                                        <select name="owner_id"  class="form-control" load="clients" data-contacts="1" style="width:568px" default="{$ticket.client_id}">
                                            <option value="0">{$lang.notreg}</option>
                                            {if $ticket.client_id}
                                                <option value="{$ticket.client_id}" selected>
                                                    #{$ticket.client_id} {$client.firstname} {$client.lastname}
                                                </option>
                                            {/if}
                                        </select>
                                    </div>

                                    <div class="notifiedselect">
                                        {include file="support/ajax.notifiedselect.tpl"}
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Assigned to staff</label>
                                        <select name="owner" class="form-control">
                                            <option value="0">{$lang.none}</option>
                                            {foreach from=$staff_members item=stfmbr}
                                                <option {if $stfmbr.id==$ticket.owner_id}selected="selected"{/if} value="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</option>
                                            {/foreach}
                                        </select>
                                    </div>

                                    {literal}
                                        <script>
                                            $(function () {
                                                $('select[name="owner_id"]').on('change', function () {
                                                    var tid = '{/literal}{$ticket.id}{literal}';
                                                    var val = $(this).val();
                                                    ajax_update('?cmd=tickets&action=loadnotifiers&ticket_id=' + tid + '&client_id=' + val, {}, '.notifiedselect');
                                                }).trigger('change');
                                            });
                                        </script>
                                    {/literal}
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary editTicketSave">Save changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                <table border="0" width="100%">
                    <tr>
                        <td align="right" class="light" width="120px">{$lang.department}:</td>
                        <td align="left">
                            <strong id="ticket_dept">{$ticket.deptname}</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="light">{$lang.submitter}</td>
                        <td align="left">
                            <span>{$ticket.name|escape}</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="light">{$lang.asignedclient}</td>
                        <td align="left">
                            <span>
                                {if $ticket.client_id}{$client|@profilelink}
                                {else}{$lang.notreg}
                                {/if}
                            </span>
                        </td>
                    </tr>
                    {if !$ticket.share || $ticket.share=='master'}
                        <tr>
                            <td align="right"  class="light">
                                {if $ticket.metadata.source}
                                    Source
                                {else}
                                    {$lang.emaill|capitalize}
                                {/if}
                            </td>
                            <td align="left">
                                <div class="fold-text">
                                    {if $ticket.metadata.source}
                                        {$ticket.email}
                                    {else}
                                    <a href="mailto:{$ticket.email}">{$ticket.email}</a>
                                    {/if}
                                </div>
                            </td>
                        </tr>
                    {else}
                        <tr>
                            <td align="right"  class="light">{$lang.author_uuid}</td>
                            <td align="left">
                                <div class="fold-text">{$ticket.email}</div>
                            </td>
                        </tr>
                    {/if}
                    <tr style="display:none" class="sh_row force">
                        <td align="right" class="light">{$lang.subject|capitalize}</td>
                        <td align="left">
                            <div class="fold-text">{$ticket.subject|escape}</div>
                        </td>
                    </tr>

                    <tr  class="sh_row force">
                        <td align="right" class="light">{$lang.request_type}</td>
                        <td align="left">
                            <div class="fold-text">{$lang[$ticket.request_type]}</div>
                        </td>
                    </tr>
                    <tr {if !$ticket.cc}style="display:none"{/if} class="sh_row">
                        <td align="right" class="light">CC</td>
                        <td align="left">
                            <div class="fold-text">{if $ticket.cc}{$ticket.cc}{else}{$lang.none}{/if}</div>
                        </td>
                    </tr>
                    <tr {if !$ticket.bcc}style="display:none"{/if} class="sh_row">
                        <td align="right" class="light">BCC</td>
                        <td align="left">
                            <div class="fold-text">{if $ticket.bcc}{$ticket.bcc}{else}{$lang.none}{/if}</div>
                        </td>
                    </tr>
                    <tr {if !$ticket.owner_id}style="display:none"{/if} class="sh_row">
                        <td align="right" class="light">Assigned to</td>
                        <td align="left">
                            <span>
                                {if $ticket.owner_id}
                                    {foreach from=$staff_members item=stfmbr}
                                        {if $stfmbr.id==$ticket.owner_id}
                                            {$stfmbr.firstname} {$stfmbr.lastname}{break}
                                        {/if}
                                    {/foreach}
                                {else}
                                    {$lang.none}
                                {/if}
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="light">{$lang.IPaddress}</td>
                        <td align="left">
                            {if $ticket.senderip}{$ticket.senderip}
                            {else}{$lang.none}
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td align="right"  class="light">{$lang.lastreply|capitalize}</td>
                        <td align="left">
                            {$ticket.lastreply|dateformat:$date_format}
                        </td>
                    </tr>
                </table>
            </div>
            <script type="text/javascript">{literal}$(function () {
                    if ($('.auto-height').height() < $('#client_tab').height())
                        $('.auto-height').css('min-height', $('#client_tab').height() + 'px');
                });
                $('.fold-text').click(function () {
                    $(this).toggleClass('show')
                }){/literal}
            </script>

            <a href="#reply" class="scroller pull-right btn btn-sm btn-default btn-tickets"><i class="fa fa-reply" aria-hidden="true"></i></a>
            {if !$forbidAccess.editTicketMsg || (!$forbidAccess.editOwnMesg && $admindata.id == $ticket.creator_id)}
                    <a href="#" class="editor  pull-right btn btn-sm btn-default btn-tickets"><i class="fa fa-pencil" aria-hidden="true"></i></a>&nbsp;&nbsp;&nbsp;
            {/if}
                <a href="{$ticket.id}" class="quoter  pull-right btn btn-sm btn-default btn-tickets"><i class="fa fa-quote-right" aria-hidden="true"></i></a>&nbsp;&nbsp;&nbsp;

            {if !$forbidAccess.encryptTicketMsg && !($ticket.flags & 1024)}
                <a href="#"
                   class="encryptmessage pull-right btn btn-sm btn-default btn-tickets" title="Encrypt message">
                    <i class="fa fa-lock" aria-hidden="true"></i>
                </a>
            {/if}

            <a href="#" class="quoter2  pull-right btn btn-sm btn-default btn-tickets"><i class="fa fa-quote-left" aria-hidden="true"></i> {$lang.Quoteselected}</a>

            <div style="clear:left"></div>
            <div id="msgbody"> {$ticket.body|blockquote|httptohref|regex_replace:"/^\S\n]+\n/":"<br>"|nl2br} </div>
            {if $ticket.editby != ''}<div class="editbytext fs11" style="color:#555; font-style: italic">{$lang.lastedited} {$ticket.editby} at {$ticket.lastedit|dateformat:$date_format}</div>{/if}
            <div id="editbody{$reply.id}" style="overflow:hidden; display:none; margin: 9px 0 0">
                <textarea style="width:100%"></textarea>
                <div style="padding:5px 0">
                    <a href="{$reply.id}" class="menuitm editorsubmit"><span>{$lang.savechanges}</span></a> {$lang.Or}
                    <a onclick="$('#msgbody{$reply.id}').show().siblings('.editbytext:first').show();
                                $('#editbody{$reply.id}').hide();
                                return false" href="#" class="menuitm"><span>{$lang.Cancel}</span></a>
                </div>
            </div>
            {if !empty($attachments[0])}
                <div class="well well-sm" >
                    <div class="hbfiles" >
                        {foreach from=$attachments[0] item=file}
                            <div data-type="{$file.type}"
                                 data-id="{$file.id}"
                                 data-reply-id="{$reply.id}"
                                 data-thumbnail-url="?action=download&id={$file.id}&inline=1&thumbnail=1"
                                 data-preview-url="?action=download&id={$file.id}&inline=1"
                                 data-download-url="?action=download&id={$file.id}"
                                 data-title="{$file.org_filename}"
                                 class="hbfile ticket_attachment"
                            >
                                <div class="hbfile-control">
                                    <a href="?action=download&id={$file.id}" class="hbfile-control-icon hbfile-download"><i class="fa fa-download"></i></a>
                                    <a onclick="remove_attachment('{$file.id}', '{$reply.id}');" class="hbfile-control-icon hbfile-remove"><i class="fa fa-trash"></i></a>
                                </div>
                                <div class="hbfile-placeholder-box">
                                    <img src="{$template_dir}img/ajax-loading2.gif" class="hbfile-placeholder" title="{$file.org_filename}" alt="{$file.org_filename}"/>
                                </div>
                                <div class="hbfile-title" title="{$file.org_filename}">{$file.org_filename}</div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/if}

            <div style="clear:both"></div>
        </div>
        {include file="_common/quicklists.tpl" _placeholder=true}
    </div>

    {if $ticket.flags & 128}
        <div class="alert alert-warning">
            <span><b>This ticket is pending supervisor review</b> </span>
            <br>
            <br>
            <a class="btn btn-sm btn-default" href="?cmd=tickets&action=markreviewed&list=all&id={$ticket.ticket_number}">Mark as reviewed</a>
            <span>or change status</span>
            <a class="setStatus menuitm menu-auto" href="#" id="shd1" onclick="return false;" >
                <span class="morbtn">{$lang.Setstatus}</span>
            </a>
            <ul id="shd1_m"  class="ddmenu">
                {foreach from=$statuses item=sstatus}
                    <li class="act_{$sstatus.status|lower} {if $ticket.status==$sstatus.status}disabled{/if}"><a href="status|{$sstatus.status}">{$lang[$sstatus.status]}</a></li>
                {/foreach}
            </ul>
        </div>
    {/if}

    {adminwidget module="tickets" section="body"}

    {if $childrens}
        <div class="ticketrelation" style="background: #f3f5f6">
            <strong>Ticket relationship:</strong>
            <ul class="list-unstyled">
                <li>
                    {if $parent.id != $ticket.id}<a href="?cmd=tickets&action=view&list=all&num={$parent.ticket_number}" target="_blank">{else}<strong>{/if}
                        #{$parent.ticket_number} - {$parent.subject}
                    {if $parent.id != $ticket.id}</a>{else}</strong>{/if}
                    <ul>
                      {foreach from=$childrens item=child}
                          <li>
                              {if $child.id != $ticket.id}<a href="?cmd=tickets&action=view&list=all&num={$child.ticket_number}" target="_blank">{else}<strong>{/if}
                                  #{$child.ticket_number} - {$child.subject}
                              {if $child.id != $ticket.id}</a>{else}</strong>{/if}
                          </li>
                      {/foreach}
                    </ul>
                </li>
            </ul>
        </div>
    {/if}
    {if $replies && !empty($replies) }
        {foreach from=$replies item=reply}

            {if $reply.status!='Draft'}
                <div class="ticketmsg {if $reply.flags & 2}tpinned{/if}" id="reply_{$reply.id}" style="{if $reply.flags & 1 || $reply.flags & 4}background: #fff1f1;{elseif $reply.flags & 2}background: #f7fcff{/if}">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td class="msgavatar">
                                <img src="https://www.gravatar.com/avatar/{$reply.gravatar}?s=32&d=mm"
                                     class="img-rounded">

                            </td>
                            <td class="msgwrapper"  data-status="{$reply.status}">
                                <div class="left ticketinfoblock">
                                    {if $reply.type!='Admin' && $reply.replier_id}
                                        <a href="?cmd=clients&action=show&id={$reply.replier_id}" target="_blank">
                                    {/if}
                                        <strong {if $reply.type=='Admin'}class="adminmsg" {else}class="clientmsg"{/if}>{$reply.name}</strong>
                                    {if $reply.type!='Admin' && $reply.replier_id}
                                        </a>
                                    {/if}

                                    {if $reply.type=='Admin'}
                                        <label class="label label-info-invert">{$lang.staff}</label>
                                    {elseif $reply.type=='System'}
                                        <label class="label label-info-invert">system</label>
                                    {elseif $reply.replier_id!='0'}
                                        <label class="label label-success-invert">{$lang.client}</label>
                                    {/if}

                                    {if $reply.status == 'Scheduled'}
                                        <label class="label label-warning-invert">{$lang.Scheduled}</label>
                                    {/if}

                                    <span class="ticketinfo">
                                        {$reply.date|dateformat:$date_format}
                                        {if $reply.flags & 1 || $reply.flags & 4}
                                            <span style="color: #ff0001;">
                                                {if $reply.flags & 4}<b>{$lang.ticket_reported}</b>{/if}
                                                {if $reply.flags & 1}<b>{$lang.reply_reported}</b>{/if}
                                            </span>
                                        {/if}
                                        <span style="display: none;">
                                            {if $reply.type == 'Client'} using client area, logged in
                                            {elseif $reply.type == 'Unregistered'} from client area, not logged in
                                            {elseif $reply.type != 'Admin'} via Email
                                            {/if}
                                        </span>
                                        &nbsp;&nbsp;&nbsp;
                                    </span>

                                    <span class="reply-encrypted-message" style="color: #ea8813; {if $reply.flags & 16}display:inline-block;{else}display:none;{/if}">{$lang.replyencryptedinfo}</span>

                                    <div class="ticketinfo msg-source">
                                        {if $reply.type!='Admin' && $reply.from}
                                            {$reply.from}
                                        {/if}&nbsp;
                                    </div>
                                </div>

                                {if !$forbidAccess.editTicketMsg || (!$forbidAccess.editOwnMesg && $reply.type=='Admin' && $admindata.id == $reply.replier_id)}
                                    <a href="{$reply.id}" class="deletereply pull-right btn btn-sm btn-default btn-tickets" title="Delete reply">
                                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                                    </a>
                                    <a href="{$reply.id}" class="editor pull-right btn btn-sm btn-default btn-tickets" type="reply" title="Edit reply">
                                        <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </a>
                                {/if}
                                {if $reply.status != 'Scheduled'}
                                    <a href="{$reply.id}" class="pinned {if $reply.flags & 2}pinned-active{/if} pull-right btn btn-sm btn-default btn-tickets" title="Pin reply">
                                        <i class="fa fa-thumb-tack" aria-hidden="true"></i>
                                    </a>
                                    <a href="{$reply.id}" class="quoter pull-right btn btn-sm btn-default btn-tickets" type="reply" title="Quote all reply">
                                        <i class="fa fa-quote-right" aria-hidden="true"></i>
                                    </a>
                                    <a href="?cmd=tickets&action=newfromreply&reply_id={$reply.id}&security_token={$security_token}"
                                       class="pull-right btn btn-sm btn-default btn-tickets" title="New ticket from reply"
                                       onclick="return confirm('Please confirm opening new internal ticket using this reply?')">
                                        <i class="fa fa-copy" aria-hidden="true"></i></a>

                                    {if !$forbidAccess.encryptTicketMsg && !($reply.flags & 16)}
                                        <a href="{$reply.id}"
                                           class="encryptreply pull-right btn btn-sm btn-default btn-tickets" title="Encrypt reply">
                                            <i class="fa fa-lock" aria-hidden="true"></i>
                                        </a>
                                    {/if}

                                    <a href="#" class="quoter2  pull-right btn btn-sm btn-default btn-tickets" title="Quote selected"><i
                                                class="fa fa-quote-left" aria-hidden="true"></i> {$lang.Quoteselected}</a>

                                {/if}

                                <span class="pull-right btn btn-sm btn-tickets">id: {$reply.id}</span>
                                <div class="clear"></div>
                                <div id="msgbody{$reply.id}" style="word-break: break-word; {if $reply.status == 'Scheduled'}opacity: 0.7;{/if}"> {$reply.body|blockquote|httptohref|regex_replace:"/[^\S\n]+\n/":"<br>"|nl2br}</div>
                                {if $reply.editby != ''}
                                    <div class="editbytext fs11"
                                         style="color:#555; font-style: italic">{$lang.lastedited} {$reply.editby}
                                    at {$reply.lastedit|dateformat:$date_format}</div>
                                {/if}
                                <div id="editbody{$reply.id}" style="overflow:hidden; display:none; margin: 9px 0 0">
                                    <textarea style="width:100%"></textarea>
                                    <div style="padding:5px 0">
                                        <a href="{$reply.id}"
                                           class="menuitm editorsubmit"><span>{$lang.savechanges}</span></a> {$lang.Or}
                                        <a onclick="$('#msgbody{$reply.id}').show().siblings('.editbytext').show();
                                                $('#editbody{$reply.id}').hide();
                                                return false" href="#" class="menuitm"><span>{$lang.Cancel}</span></a>
                                    </div>
                                </div>
                                {if !empty($attachments[$reply.id])}
                                    <hr>
                                    <div class="well well-sm">
                                        <div class="hbfiles">
                                            {foreach from=$attachments[$reply.id] item=file}
                                                <div data-type="{$file.type}"
                                                     data-id="{$file.id}"
                                                     data-reply-id="{$reply.id}"
                                                     data-thumbnail-url="?action=download&id={$file.id}&inline=1&thumbnail=1"
                                                     data-preview-url="?action=download&id={$file.id}&inline=1"
                                                     data-download-url="?action=download&id={$file.id}"
                                                     data-title="{$file.org_filename}"
                                                     class="hbfile ticket_attachment"
                                                >

                                                    <div class="hbfile-control">
                                                        <a href="?action=download&id={$file.id}" class="hbfile-control-icon hbfile-download"><i class="fa fa-download"></i></a>
                                                        <a onclick="remove_attachment('{$file.id}', '{$reply.id}');" class="hbfile-control-icon hbfile-remove"><i class="fa fa-trash"></i></a>
                                                    </div>
                                                    <div class="hbfile-placeholder-box">
                                                        <img src="{$template_dir}img/ajax-loading2.gif" class="hbfile-placeholder" title="{$file.org_filename}" alt="{$file.org_filename}"/>
                                                    </div>
                                                    <div class="hbfile-title" title="{$file.org_filename}">{$file.org_filename}</div>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                {/if}
                            </td>
                        </tr>
                    </table>

                </div>
            {/if}
        {/foreach}
    {/if}


    <div class="ticket-panel-btn">
        <a class="btn btn-default btn-sm {if $ticket.flags & 1}active{/if}" id="LeaveNotes" href="#LeaveNotes" >{$lang.LeaveNotes}</a>
        {if $enableFeatures.supportext}
            <a class="btn btn-default btn-sm {if $ticket.flags & 2}active{/if}" id="timeTracking" href="#timeTracking" >Time tracking</a>
        {/if}
        {if $ticket.client_id && 'acl:addInvoices'|checkcondition}
        <a class="btn btn-default btn-sm" id="QueuedInvoiceItems" href="#QueuedInvoiceItems" >Queued invoice items</a>
        {/if}
        {if 'acl:viewTicketTimers'|checkcondition}
            <a class="btn btn-default btn-sm {if $timers}active{/if}" id="ticketTimers" href="#ticketTimers" >Ticket timers</a>
        {/if}
        {include file='support/ajax.makeinternal.tpl' isinternal=$isinternal ajax=true btnclass='btn-sm'}

        {adminwidget module="tickets" section="panelbtn"}

    </div>

    {if $sla_details}

        <div class="alert alert-danger" role="alert">
            This ticket breached department SLA Policy: <strong>{$sla_details.name}</strong> {if $ticket.start_date!='0000-00-00 00:00:00'}on: {$ticket.start_date|dateformat:$date_format}{/if}
        </div>
    {/if}

    <div class="panel panel-warning" style="{if !($ticket.flags & 1)}display:none;{/if}" id="ticketnotebox" >
        <div class="panel-heading">
            Notes
            <a title="Notes are only visible to Administrators and Staff Members assigned to this department. Clients do not see what you write here." class="vtip_description" style="padding-left:16px">&nbsp;</a>
        </div>
        <div class="panel-body">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                <tbody id="ticketnotes">
                    <tr class="odd">
                        <td></td>
                        <td> Loading... <img src="{$template_dir}img/ajax-loading2.gif"> </td>
                    </tr>
                </tbody>
            </table>
            <div class="admin-note-new">
                <div class="admin-note-input">
                    <textarea rows="4" id="ticketnotesarea" name="notes" class="notes_field notes_changed"></textarea>
                    <div class="admin-note-attach"></div>
                </div>
                <div id="notes_submit" class="notes_submit admin-note-submit">
                    <input value="{$lang.LeaveNotes}" type="button" id="ticketnotessave">
                </div>
                <a href="#" class="editbtn" id="ticketnotesfile">Attach file</a>
            </div>
            <script src="{$template_dir}js/fileupload/init.fileupload.js?v={$hb_version}"></script>
        </div>
    </div>

    {if $enableFeatures.supportext}
        <div class="panel panel-default" style="{if !($ticket.flags & 2)}display:none;{/if}" id="ticketbils" >

            <div class="panel-heading">
                Time tracking
                <a title="You can add bills for support service here. New items are added as drafts - staff members with billing privilages can generate invoices from them." class="vtip_description" style="padding-left:10px">&nbsp;</a>
            </div>
            <div class="panel-body">
                Loading...
                <img src="{$template_dir}img/ajax-loading2.gif">
                {if $ticket.flags & 2}
                    <script type="text/javascript">{literal}$(function () {
                                    ticket.getBilling();
                                }){/literal}
                    </script>
                {/if}
            </div>
        </div>
    {/if}

    {if 'acl:viewTicketTimers'|checkcondition}
        <div class="panel panel-default" {if !$timers}style="display:none;"{/if} id="ticketTimersBox" >
            <div class="panel-heading">Ticket timers</div>
            <div class="panel-body">
                Loading...
                <img src="{$template_dir}img/ajax-loading2.gif">
                {if $timers}
                    <script type="text/javascript">
                        {literal}
                        $(function () {
                            ticket.getTimers();
                        });
                        {/literal}
                    </script>
                {/if}
            </div>
        </div>
    {/if}

    {if 'acl:viewInvoices'|checkcondition}
        <div class="panel panel-default" {if !$queuedinvoiceitems}style="display:none;"{/if} id="QueuedInvoiceItemsBox" >
            <div class="panel-heading">
                Queued Invoice Items
                <a title="Following items will be billed after closing this ticket" class="vtip_description" style="padding-left:10px">&nbsp;</a>
            </div>
            <div class="panel-body" id="itemqueue">
                Loading...
                <img src="{$template_dir}img/ajax-loading2.gif">
                {if $queuedinvoiceitems}
                    <script type="text/javascript">
                        {literal}
                        $(function () {
                            ticket.getQueuedInvoiceItems();
                        });
                        {/literal}
                    </script>
                {/if}
            </div>
        </div>
    {/if}

    {if 'acl:viewInvoices'|checkcondition}
        <div class="panel panel-default" style="display: none;" id="ticketInvoicesBox">
            <div class="panel-heading">Invoices related to this thread</div>
            <div class="panel-body">
                Loading...
                <img src="{$template_dir}img/ajax-loading2.gif">
                <script type="text/javascript">
                    {literal}
                    $(function () {
                        ticket.getInvoices();
                    });
                    {/literal}
                </script>
            </div>
        </div>
    {/if}

    {adminwidget module="tickets" section="widget"}
</div>
<div id="recentreplies"></div>
<form id="reply-form" action="?cmd=tickets&action=view&num={$ticket.ticket_number}&list={$currentlist}"
      method="post" enctype="multipart/form-data"
      data-url="?cmd=tickets&action=handleupload">
    <div class="container-fluid" id="replytable" {if $ticket.status=='Closed'}style="display:none"{/if}>
        <div class="row ticket-reply-row">
            <div class="col-md-8">

                <div id="alreadyreply">
                    {if $drafts}
                        {foreach from=$drafts item=reply}
                            <div class="alert {if $reply.stored <= $smarty.now}alert-default{else}alert-warning{/if}" style="{if $reply.stored <= $smarty.now}background-color: #eee; {/if} padding: 8px; margin-bottom: 8px;">
                                <p class="adminr_{$reply.replier_id}" style="float: left; margin-top: 3px;">
                                    <strong>{$reply.name}</strong>
                                    {if $reply.stored <= $smarty.now}{$lang.storedreplyat}{else}{$lang.startedreplyat}{/if} {$reply.date|dateformat:$date_format}
                                </p>
                                <p style="float: right; margin-top: 0;">
                                    <a href="#showDraft" class="btn btn-sm btn-primary" data-draft="{$reply.id}" data-draft-by="{$reply.name}">{$lang.Preview}</a>
                                    {if $reply.flags & 8 && $lock_ticket_reply}
                                        {if 'acl:removeTicketReplyLock'|checkcondition}
                                            <button type="button" class="btn btn-sm btn-primary remove-lock" data-id="{$reply.id}">{$lang.remove_lock}</button>
                                        {/if}
                                        {if !$draftreply.body}
                                            {if 'acl:replyToTicketsWithReplyLock'|checkcondition}
                                                <button type="button"  class="btn btn-sm btn-primary without-removing" data-id="{$reply.id}">{$lang.reply_without_removing_lock}</button>
                                            {/if}
                                        {else}
                                            <input type="hidden" name="lock" value="{$reply.md5}">
                                        {/if}
                                    {/if}
                                </p>
                                <div style="clear: both;"></div>
                            </div>
                            {if $reply.flags & 8 && $lock_ticket_reply && !$draftreply.body}<script>$(function () {ldelim}$('#replyarea').prop('disabled', true){rdelim});</script>{/if}
                        {/foreach}
                    {/if}
                </div>

                <div class="alert alert-warning" id="justadded" style="display:none">
                    {$lang.newreplyjust}  &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="#" rel="{$ticket.viewtime}" id="showlatestreply"><strong>{$lang.updateticket}</strong></a>&nbsp;&nbsp;
                    <a href="#" onclick="$('#justadded').hide();
                                return false;">{$lang.Hide}</a>
                </div>


                <input type="hidden" name="make" value="addreply" />

                <div class="ticket-reply-input">
                    <div>
                        <div style="float: left;">
                            <label>{$lang.Reply}</label>
                        </div>
                        {if $lock_ticket_reply && !$isset_draft}
                            <div style="float: right; margin-bottom: 3px;">
                                <a href="#" class="btn btn-sm btn-primary" onclick="$(this).hide(); return ticket.savedraft();">Lock reply for others</a>
                            </div>
                        {/if}
                        <div style="clear:both;"></div>
                    </div>
                    <a name="reply"></a>
                    <textarea rows="14" id="replyarea" name="body">{if $draftreply}{$draftreply.body}{/if}</textarea>
                </div>
                <input name="save_draft" type="hidden" value="0">
                <div id="draftinfo">
                    <span class="draftdate" {if $draftreply}style="display:inline"{/if}>
                        {if $draftreply}
                            {$lang.draftsavedat} {$draftreply.date|dateformat:$date_format}
                        {/if}
                    </span>
                    <span class="controls"  {if $draftreply }style="display:inline"{/if}>
                        <a href="#" onclick="return ticket.savedraft()">{$lang.savedraft|capitalize}</a>
                        <a href="#" onclick="return ticket.removedraft()">{$lang.removedraft|capitalize}</a>
                    </span>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="col-12 col-md-6">
                        <div class="form-group">
                            <div class="btn btn-success btn-sm fileinput-button">
                                {$lang.addattachment}
                                <input type="file" name="asyncattachment[]" multiple/>
                            </div>&nbsp;&nbsp;
                            ({$lang.$extensionact} {$extensions})
                        </div>
                    </div>

                    {if !$forbidAccess.encryptTicketMsg}
                    <div class="col-12 col-md-6 text-md-right">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="encrypt" value="1" id="encryptReplyCheckbox">
                            <label class="form-check-label" for="encryptReplyCheckbox">{$lang.encryptreply}</label>
                        </div>
                    </div>
                    {/if}

                </div>

                <ul id="attachments" class="files"></ul>

                <input type="hidden" id="backredirect" name="brc" value="{$backredirect}" />
                {securitytoken}

            </div>
            <div class="col-md-4" >
                {adminwidget module="tickets" section="reply"}
            </div>
        </div>
        <div class="row">
            <div class="col-lg-1 col-md-2 col-sm-3 ticket-submit-col">
                <button name="justsend" type="submit" value="{$lang.Send}" id="ticketsubmitter"
                        class="btn btn-lg btn-success ">{$lang.Send}</button>
            </div>
            <div class="col-lg-11 col-md-10 col-sm-9  ticket-widgets" >
                <div class="well"  id="ticketwidgetarea">
                    <div class="ticket-widget-form col-xs-12 col-sm-5  col-md-4 col-lg-3">
                        <div class="input-group">
                            <span class="input-group-addon">{$lang.Setstatus}</span>
                            <select class="form-control" name="status_change" >
                                {foreach from=$statuses item=status}
                                    <option value="{$status.status}" {if $status.status=='Answered'}selected="selected"{/if} >{$lang[$status.status]}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="ticket-widget-btn t-w-modal" id="addasarticle">
                        <a class="btn btn-default" href="#addAsArticle"
                           data-content="Enter new name for this article" data-callback="ticket.savemacro">{$lang.askbarticle}</a>
                        <input type="hidden" name="send_save_name2" value=""/>
                    </div>

                    {if !$forbidAccess.manageMacros}
                        <div class="ticket-widget-btn t-w-modal" id="manageMacros">
                            <a class="btn btn-default" href="#asMacros"
                               data-content="Enter new name for this macro" data-callback="ticket.savemacro">{$lang.asmacro}</a>
                            <input type="hidden" name="send_save_name" value=""/>
                        </div>
                    {/if}

                    {adminwidget module="tickets" section="btn"}



                </div>
            </div>
        </div>
    </div>
</form>
<div class="blu">
    <div class="menubar">
        {include file="support/ticket_actions.tpl" bottom=true}
    </div>
</div>
{if $ajax}
    <script type="text/javascript">bindEvents();
        bindTicketEvents();</script>
{/if}