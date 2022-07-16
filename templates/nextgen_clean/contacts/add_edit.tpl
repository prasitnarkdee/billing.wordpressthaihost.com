{*

Add and/or edit contact

*}
<h2>
    {if $action=='add'} {$lang.addnewprofile}
    {elseif $action=='invite'} {$lang.user_invite}
    {elseif $action=='access'} {$lang.user_privileges}
    {else} {$lang.profiledetails}{/if}
</h2>
<div class="brcrm">
    <ul class="breadcrumb left">
        <li><a href="{$ca_url}profiles/"><strong>{$lang.profiles}</strong></a> <span class="divider">/</span></li>
        <li class="active">
            {if $action=='add'} {$lang.addnewprofile}
            {elseif $action=='invite'} {$lang.user_invite}
            {elseif $action=='access'} {$lang.user_privileges}
            {else} {$lang.profiledetails}{/if}
        </li>
    </ul>

    <a class="btn right btn-mini" href="{$ca_url}profiles/">
        <i class="icon-chevron-left"></i> {$lang.back}
    </a>

    <div class="clear"></div>
</div>

<form method="post" action="">
    <div class="p19">
        {if $action == 'invite' || $action == 'access'}
            <div class="row-fluid">
                <div class="form-group span6">
                    <label for="field_email">{$lang.email}</label>

                    <input type="email" value="{$submit.email}" name="email"
                           class="form-control" id="field_email" {if $action == 'access'}readonly{/if} />
                </div>
                <div class="form-group span6">
                    <label for="field_email">{$lang.name}
                        <a class="vtip_description" title="{$lang.user_invite_name_dscr}"></a>
                    </label>
                    <input type="text" value="{$submit.name}" name="name"
                           class="form-control" id="field_email" {if $action == 'access'}readonly{/if} />
                </div>
            </div>
            {if $action == 'access'&&  $submit.status === 'Active' || $submit.status === 'Closed'}
                <div class="form-group">
                    <label for="field_status">{$lang.status}</label>
                    <select name="status" class="form-control" id="field_status" >
                        <option value="Active">{$lang.Active}</option>
                        <option value="Closed" {if $submit.status === 'Closed'}selected{/if}>{$lang.Closed}</option>
                    </select>
                </div>
            {/if}
        {else}
            <input type="hidden" name="make" value="{if $action=='add'}addprofile{else}editprofile{/if}"/>
            <h3>{$lang.contactdetails} </h3>
            {include file="ajax.signup.tpl"}
        {/if}
    </div>
    <div class="form-actions">
        <input type="submit" value="{$lang.submit}" class="btn btn-success btn-large"/>
    </div>
    <div class="brcrm">
        {include file="../common/tpl/privileges.tpl"}
    </div>

    <div class="form-actions">
        <input type="submit" value="{$lang.submit}" class="btn btn-success btn-large"/>
    </div>

    {securitytoken}
</form>
