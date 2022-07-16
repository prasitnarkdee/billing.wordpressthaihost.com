{if $modulesetup_id && ($action === 'setup' || $action === 'enable')}
    {include file=$formtpl}
{elseif $action === 'verify'}
    {include file=$formtpl}
{elseif $action === 'disable'}
    <h3>{$lang.mfa}</h3>
    <form action="?cmd=mfa&action=disable" method="POST">
        {securitytoken}
        <div class="wbox">
            <div class="wbox_header">{$lang.mfa_deactivate}</div>
            <div class="wbox_content">
                <div class="alert alert-info">{$lang.mfa_deactivate_info}</div>
                <div class="form-label-group">
                    <input type="password" id="password" name="password" autocomplete="current-password" class="form-control" placeholder="{$lang.password}" required>
                    <label class="form-label-placeholder" for="password">{$lang.password}</label>
                </div>
                <button type="submit" name="make" value="submit" class="btn btn-primary">{$lang.submit}</button>
            </div>
        </div>
    </form>
{elseif $action === 'default'}
    <h3>{$lang.mfa}</h3>
    <div class="clearfix">
        {if $isenabled}
            <div class="alert alert-success" role="alert">{$lang.mfa_configured_yes}</div>
        {else}
            <div class="alert alert-danger" role="alert">{$lang.mfa_configured_no}</div>
        {/if}
        <hr>
        <p>{$lang.mfa_configure_info}</p>
        {foreach from=$mfamodules item=modd}
            <div class="wbox wbox_content">
                <b>{$modd.name}</b>
                {if $isenabled && $moduleactivated_id === $modd.id}
                    <a href="?cmd=mfa&action=disable" class="btn btn-danger pull-right">{$lang.mfa_deactivate}</a>
                {elseif $isenabled}
                    <a href="#" class="btn btn-primary disabled pull-right" onclick="return false;">{$lang.mfa_activate}</a>
                {else}
                    <a href="?cmd=mfa&action=setup&id={$modd.id}" class="btn btn-primary pull-right">{$lang.mfa_activate}</a>
                {/if}
                <div class="clearfix"></div>
            </div>
        {/foreach}
    </div>
{/if}