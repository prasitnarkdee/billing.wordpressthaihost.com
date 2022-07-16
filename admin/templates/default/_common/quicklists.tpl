{if $_placeholder}
    {adminwidget module="any" section="quicklist" wrapper="adminwidgets/wrap_quicklist.tpl" placeholder=true}
    {foreach from=$adminquicklists item=list}
        <div class="slide">Loading</div>
    {/foreach}
{else}
    {if $_parent}{assign value=$_parent var=_client_link}
    {else}{assign value=$_client var=_client_link}
    {/if}

    <span class="left" style="padding-top:5px;padding-left:5px;">
        {$_client_link|@client:"<strong>%name%</strong> (%contactname%)"}       &nbsp;&nbsp;
    </span>
    {if $_client_link}
        <div id="clientnav-wrapper">
            {adminwidget module="any" section="quicklist" wrapper="adminwidgets/wrap_quicklist.tpl"}
            {foreach from=$adminquicklists item=list}
                <a class="nav_el  left" href="{$list.url}&client={$_client_link}" onclick="return false">{$list.name}</a>
            {/foreach}
            <a class="nav_el direct left" href="?cmd=clients&action=show&id={$_client}">{$lang.Profile}</a>
        </div>
    {/if}
{/if}