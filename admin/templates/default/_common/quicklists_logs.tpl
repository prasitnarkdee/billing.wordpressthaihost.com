{if !$ajax}
<div style="padding: 5px 10px">
    <h1>
        <a href="?cmd=clients&action=show&id={$client.id}">
            #{$client.id} - {$client|@client}</a> -
        {if $active == 'emails'} {$lang.Emails}
        {elseif $active == 'portal_notifications'} Portal Notifications
        {else} Client Activity
        {/if}
    </h1>
</div>
{/if}
<div class="clientlist-nav clearfix">
    <div class="col-sm-12">
        <div class="row">
            <div class="pull-right">
                {if $active == 'emails'}
                    {include file='ajax.filterquicktool.tpl'
                        client_id=$client_id loadid='emailslist'
                        href="?cmd=emails&action=getadvanced"}
                    <a href="?cmd=sendmessage&type=clients&selected={$client_id}"
                       class="btn btn-primary btn-xs" target="_blank">
                        <i class="fa fa-envelope-o"></i> {$lang.SendEmail}
                    </a>
                {elseif $active == 'portal_notifications'}
                    {include file='ajax.filterquicktool.tpl'
                        client_id=$client_id loadid='portal_notifications'
                        href="?cmd=portal_notifications&action=getadvanced"}
                    <a href="?cmd=sendmessage&action=asnotification&type=clients&selected={$client_id}"
                       class="btn btn-primary btn-xs" target="_blank">
                        <i class="fa fa-envelope-o"></i> {$lang.SendNotification}
                    </a>
                {elseif $active == 'clientactivity'}
                    {include file='ajax.filterquicktool.tpl'
                        client_id=$client_id loadid='clientactivity'
                        href="?cmd=clientactivity&action=getadvanced"}
                {/if}
            </div>
            <ul class="nav nav-tabs">
                <li {if $active == 'emails'} class="active" {/if}>
                    <a class="quick-list-subitem"
                       href="?cmd=emails&action=clientemails&id={$client_id}">
                        Emails Sent
                    </a>
                </li>
                {if 'config:EnablePortalNotifications:on'|checkcondition}
                    <li {if $active == 'portal_notifications'} class="active" {/if}>
                        <a class="quick-list-subitem"
                           href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}" >
                            Notifications
                        </a>
                    </li>
                {/if}
                <li {if $active == 'clientactivity'} class="active" {/if}>
                    <a class="quick-list-subitem"
                       href="?cmd=clientactivity&action=cactivity&id={$client_id}">
                        Activity
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
{if $ajax}
{literal}
    <script type="text/javascript">
       $(function(){
           $('.quick-list-subitem').off('click').on('click', function(e){
               e.preventDefault();

               var box = $('.quicklist_logs');
               box.addLoader();
               $.post(this.getAttribute('href'), {}, function (result) {
                   box.replaceWith(parse_response(result));
                   //bindSubItems();
               });

               return false;
           })
       })
    </script>
{/literal}
{/if}
