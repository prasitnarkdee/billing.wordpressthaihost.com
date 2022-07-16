{if $action=='show' || ($action=='default' && $showall)}{* fix pages loaded by pjax *}
<script src="{$template_dir}js/iframeResizer.min.js"></script>
{literal}
    <script language="javascript" type="text/javascript">
        function resizeIframe(obj, content) {
            const OFFSET = 30;

            if (content) {
                obj.contentWindow.document.write(content)
                obj.style.height = (obj.contentWindow.document.body.scrollHeight + OFFSET)  + 'px';
            } else {
                obj.contentWindow.document.write('<body style="padding: 0; margin-left: 0"><em style="color:silver">Empty message</em></body>')
                obj.style.height = '30px'
            }
            //fix for big images without preset height
            $('img', obj.contentWindow.document).on('load', function () {
                obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
            })
        }
    </script>
{/literal}
{/if}

{if $action=='clientemails'}
    {if $sorterpagination}
        {foreach from=$emails item=email}
            <tr>
                <td><a href="?cmd=emails&action=show&id={$email.id}">{$email.subject}</a></td>
                <td>
                    {foreach from=$email.emails item=addr name=emlo}
                        <span>{$addr}</span>{if !$smarty.foreach.emlo.last},{/if}
                    {/foreach}
                </td>
                <td>{$email.date}</td>
                <td>
                    {if $email.status}
                        <span class="Successfull">Sent</span>
                    {else}
                        <span class="Failure">Failed</span>
                    {/if}
                </td>
                <td>
                    {if $email.resend}
                        <a href="javascript:void(0)" onclick="resend({$email.id}, '{$email.flag}')"
                           class="editbtn">{$lang.resend}</a>
                    {/if}
                </td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="5">{$lang.nothingtodisplay}</td>
            </tr>
        {/foreach}
    {else}
        <div class="quicklist_logs clientlist" id="client-emails">
            {include file='_common/quicklists_logs.tpl' active='emails' client_id=$client_id}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                <tr>
                    <th><a href="?cmd=emails&action=clientemails&id={$client_id}" class="sortorder"
                           data-orderby="subject">{$lang.Subject}</a></th>
                    <th><a href="?cmd=emails&action=clientemails&id={$client_id}" class="sortorder"
                           data-orderby="lastname">Sent to</a></th>
                    <th><a href="?cmd=emails&action=clientemails&id={$client_id}" class="sortorder"
                           data-orderby="date">{$lang.Date}</a></th>
                    <th width="70"></th>
                    <th width="50"></th>
                </tr>
                </tbody>
                <tbody id="client-emails-updater">
                {include file="ajax.emails.tpl" sorterpagination=1}
                </tbody>
            </table>
            {include file="_common/quicklists_pagination.tpl" name='emails'
            url="?cmd=emails&action=clientemails&id=`$client_id`"}

            {literal}
                <script>
                    $(function () {
                        $('.pagination[data-name=client-emails]').pagination({
                            sorter_controls: '#client-emails .sortorder',
                        });

                        $('[data-filter-modal=#emailslist]').filterModal({
                            name: 'client-emails',
                            sorter_link: '#client-emails-sorter',
                            updater: '#client-emails-updater',
                        });
                    });

                    function resend(mail_id, flag = 'email') {
                        var url = '?cmd=emails&action=resend';
                        if (flag !== 'email')
                            url += '_' + flag;
                        $.post(url, {
                            selected: mail_id
                        }, function (data) {
                            var resp = parse_response(data);

                        });
                    }
                </script>
            {/literal}
        </div>
    {/if}
{elseif $action=='getadvanced'}

    <a href="?cmd=emails&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=emails" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>

    <script type="text/javascript">bindFreseter();</script>

{elseif $action=='show'}
    <script type="text/javascript">
        {literal}
            function resend(mail_id, flag = 'email') {
                var url = '?cmd=emails&action=resend';
                if (flag !== 'email')
                    url += '_' + flag;
                $.post(url, {
                    selected: mail_id
                }, function (data) {
                    var resp = parse_response(data);

                });
            }
        {/literal}
    </script>
    <div class="blu">
        <a href="?cmd=emails" data-pjax>
            <strong>&laquo; {$lang.backtoallemails}</strong>
        </a>
        {if $email.flag != 'email' && $email.client_id == 0}
            -
        {else}
            <input type="submit" name="resend" value="{$lang.Resend}" onclick="resend({$email.id}, '{$email.flag}')" style="font-weight: bold; margin-left: 5px" class="btn btn-primary btn-sm" />
        {/if}
    </div>
    <table cellpadding="4" style="width: 100%; background: rgb(224, 236, 255);">
        <tr>
            <td><b>To</b></td>
            <td>
                {if $email.emails}
                    {foreach from=$email.emails item=addr name=emlo}
                        {if $addr.id}
                            <a href="?cmd=clients&action=show&id={$addr.id}">{$addr.firstname} {$addr.lastname} &lt;{$addr.email}&gt;</a>{if !$smarty.foreach.emlo.last},{/if}
                        {else}
                            <span>{$addr.email}</span>{if !$smarty.foreach.emlo.last},{/if}
                        {/if}
                    {/foreach}
                {else}
                    {$email|@profilelink:true}
                {/if}
            </td>
            <td><b>Date</b></td>
            <td>{$email.date|dateformat:$date_format}</td>
        </tr>
        <tr>
            <td><b>{$lang.Subject}</b></td>
            <td>{$email.subject}</td>
            <td><b>Status</b></td>
            <td>{if $email.status}<span class="Successfull">Sent</span>{else}<span class="Failure">Failed</span>{/if}</td>
        </tr>
        <tr>
            <td><b>Attachments</b></td>
            <td>
                {foreach from=$email.metadata.Attachments item=attachment}
                    {$attachment}
                    <br>
                {foreachelse}
                    -
                {/foreach}
            </td>
            <td><b>Related item</b></td>
            <td>
                {$email.rel_type|@ucfirst}
                {if $email.rel_type=='client'}<a href="?cmd=clients&action=show&id={$email.rel_id}"> #{$email.rel_id}</a>
                {elseif $email.rel_type=='account'}<a href="?cmd=accounts&action=edit&id={$email.rel_id}"> #{$email.rel_id}</a>
                {elseif $email.rel_type=='order'}<a href="?cmd=orders&action=edit&id={$email.rel_id}"> #{$email.rel_id}</a>
                {elseif $email.rel_type=='domain'}<a href="?cmd=domains&action=edit&id={$email.rel_id}"> #{$email.rel_id}</a>
                {elseif $email.rel_type=='invoice'}<a href="?cmd=invoices&action=edit&id={$email.rel_id}"> #{$email.rel_id}</a>
                {elseif $email.rel_type=='estimate'}<a href="?cmd=estimates&action=edit&id={$email.rel_id}"> #{$email.rel_id}</a>
                {elseif $email.rel_type=='ticket'}<a href="?cmd=tickets&action=view&num={$email.rel_id}"> #{$email.rel_id}</a>
                {elseif $email.rel_type && $email.rel_id} #{$email.rel_id}
                {/if}
            </td>
        </tr>
    </table>
    <div class="lighterblue" style="padding:15px 10px 0">
        {if $email.error}
            <div class="panel panel-danger et-preview">
                <div class="panel-heading">
                    <h3 class="panel-title">Error message</h3>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active">
                            {$email.error}
                        </div>
                    </div>
                </div>
            </div>
        {/if}
        <iframe style="width: 100%;height:auto" frameborder="0" scrolling="no"
                onload="resizeIframe(this, {$email.message|@json_encode|escape})"></iframe>
    </div>




{elseif $action=='default'}
    {if $emails}
        {if $showall}
            <script type="text/javascript">
                {literal}
                    function resend(mail_id, flag = 'email') {
                        var url = '?cmd=emails&action=resend';
                        if (flag !== 'email')
                            url += '_' + flag;
                        $.post(url, {
                            selected: mail_id
                        }, function (data) {
                            var resp = parse_response(data);

                        });
                    }
                {/literal}
            </script>
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">
                    <div class="left">
                        {$lang.withselected}
                        <input type="submit" name="resend" value="{$lang.Resend}"  class="btn btn-primary btn-sm" />
                    </div>
                    <div class="right"><div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <a href="?cmd=emails" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <th width="20"><input type="checkbox" id="checkall"/></th>
                            <th><a href="?cmd=emails&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                            <th><a href="?cmd=emails&orderby=rel_id|ASC"  class="sortorder">Related item</a></th>
                            <th width="300"><a href="?cmd=emails&orderby=lastname|ASC"  class="sortorder">Send to</a></th>
                            <th width="150"><a href="?cmd=emails&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th width="100">{$lang.Status}</th>
                            <th width="60">&nbsp;</th>
                        </tr>
                    </tbody>
                    <tbody id="updater">
                    {/if}
                    {foreach from=$emails item=email}
                        <tr>
                            <td><input type="checkbox" class="check" value="{$email.id}" name="selected[]"/></td>
                            <td class="subjectline"><div class="df1"><div class="df2"><div class="df3"><a href="?cmd=emails&action=show&id={$email.id}"  data-pjax>{if $email.subject == ''}<em>(empty subject)</em>{else}{$email.subject}{/if}</a></div></div></div></td>
                            <td>
                                {$email.rel_type|@ucfirst}
                                {if $email.rel_type=='client'}<a href="?cmd=clients&action=show&id={$email.rel_id}">ID: {$email.rel_id}</a>
                                {elseif $email.rel_type=='account'}<a href="?cmd=accounts&action=edit&id={$email.rel_id}">ID: {$email.rel_id}</a>
                                {elseif $email.rel_type=='order'}<a href="?cmd=orders&action=edit&id={$email.rel_id}">ID: {$email.rel_id}</a>
                                {elseif $email.rel_type=='domain'}<a href="?cmd=domains&action=edit&id={$email.rel_id}">ID: {$email.rel_id}</a>
                                {elseif $email.rel_type=='invoice'}<a href="?cmd=invoices&action=edit&id={$email.rel_id}">ID: {$email.rel_id}</a>
                                {elseif $email.rel_type=='estimate'}<a href="?cmd=estimates&action=edit&id={$email.rel_id}">ID: {$email.rel_id}</a>
                                {elseif $email.rel_type=='ticket'}<a href="?cmd=tickets&action=view&num={$email.rel_id}">ID: {$email.rel_id}</a>
                                {elseif $email.rel_type && $email.rel_id} ID {$email.rel_id}
                                {/if}
                            </td>
                            <td>
                                {if $email.client_id}
                                    {$email|@profilelink:false:true}
                                {else}
                                    <span title="{$email.emails[0]}">{$email.emails[0]|truncate:20:'..':true:true}</span>
                                {/if}
                                {if $email.addresscnt > 0}
                                    <small>and {$email.addresscnt} more..</small>
                                {/if}
                            </td>
                            <td>{$email.date|dateformat:$date_format}</td>
                            <td>{if $email.status}<span class="Successfull">Sent</span>{else}<span class="Failure">Failed</span>{/if}</td>
                            <td>
                                {if $email.resend}
                                    <a href="javascript:void(0)" onclick="resend({$email.id}, '{$email.flag}')" class="editbtn">{$lang.resend}</a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th></th>
                            <th colspan="5">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">
                    <div class="left">
                        {$lang.withselected}
                        <input type="submit" name="resend" value="{$lang.Resend}" class="btn btn-primary btn-sm"/>
                    </div>
                    <div class="right"><div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}</form>

        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="5"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}


{/if}
