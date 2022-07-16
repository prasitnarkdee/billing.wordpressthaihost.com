<div class="panel panel-default">
    <div class="panel-heading">
        <strong>{$lang.privileges}</strong>
    </div>
    <div class="panel-body" id="privileges">
        <div class="subhead">
            <strong>{$lang.premadepriv}</strong>
            <a href="#none" class="label label-default">{$lang.none}</a>
            <a href="#accounting" class="label label-default">{$lang.accounting}</a>
            <a href="#staff" class="label label-default">{$lang.Administrators}</a>
            <a href="#full" class="label label-default">{$lang.full_acces}</a>
        </div>
        {foreach from=$staff_privs item=privs key=group}
            {if empty($privs)}{continue}{/if}
            <div class="acl-group checkbox-group">
                <label class="legend">
                    <input type="checkbox"/>{$lang.$group}
                </label>
                <div class="fieldset">
                    {foreach from=$privs item=privopt key=priv name=loop}
                        {if is_array($privopt)}
                            {assign var=oldpriv value="`$privopt.type_id`:`$privopt.code`"}
                            {assign var=priv value="`$privopt.type_id`:`$privopt.type`:`$privopt.code`"}
                            {if isset($plugins[$privopt.type_id]) && $privopt.type == 'module'}
                                <label {if $details.teamAccess[$priv] || $details.teamAccess[$oldpriv]}data-team="{$details.teamAccess[$priv]|@json_encode|escape}"{/if} {if $risk_acl[$priv]}class="text-danger"{/if}>
                                    <input type="checkbox" name="access[]" value="{$priv}" class="checker"
                                           {if $details.teamAccess[$priv] || $details.teamAccess[$oldpriv]}disabled{/if}
                                            {if $details.access && ($priv|in_array:$details.access || $oldpriv|in_array:$details.access)}checked{/if}/>

                                    {$plugins[$privopt.type_id]}: {if $lang.$privopt.description}{$lang.$privopt.description}{else}{$privopt.description}{/if}
                                    {if $risk_acl[$priv] || $risk_acl[$oldpriv]} {assign var="risk2" value=$risk_acl.$priv}<i class="fa fa-exclamation-circle riskyacl " title="{$lang.$risk2}"></i>{/if}
                                </label>
                            {elseif $privopt.type != 'module'}
                                <label {if $details.teamAccess[$priv] || $details.teamAccess[$oldpriv]}data-team="{$details.teamAccess[$priv]|@json_encode|escape}"{/if} {if $risk_acl[$priv]}class="text-danger"{/if}>
                                    <input type="checkbox" name="access[]" value="{$priv}" class="checker"
                                           {if $details.teamAccess[$priv]}disabled{/if}
                                            {if $details.access && $priv|in_array:$details.access}checked{/if}/>

                                    {if $lang.$privopt.description}{$lang.$privopt.description}{else}{$privopt.description}{/if}
                                    {if $risk_acl[$priv]} {assign var="risk2" value=$risk_acl.$priv}<i class="fa fa-exclamation-circle riskyacl " title="{$lang.$risk2}"></i>{/if}
                                </label>
                            {else}
                                {if $details.access && ($priv|in_array:$details.access || $oldpriv|in_array:$details.access)}
                                    <input type="hidden" name="access[]" value="{$priv}"/>
                                {/if}
                            {/if}
                        {else}
                            <label {if $details.teamAccess[$privopt]}data-team="{$details.teamAccess[$privopt]|@json_encode|escape}"{/if} {if $risk_acl[$privopt]}class="text-danger"{/if}>
                                <input type="checkbox" name="access[]" value="{$privopt}" class="checker"
                                       {if $details.teamAccess[$privopt]}disabled{/if}
                                        {if $details.access && $privopt|in_array:$details.access}checked{/if}/>

                                {if $lang.$privopt}{$lang.$privopt}{else}{$privopt}{/if}
                                {if $risk_acl[$privopt]} {assign var="risk2" value=$risk_acl.$privopt}<i class="fa fa-exclamation-circle riskyacl " title="{$lang.$risk2}"></i>{/if}

                            </label>
                        {/if}

                    {/foreach}
                </div>
            </div>
        {/foreach}
    </div>
    <div class="panel-footer">
        <button type="submit" value="1" name="save"
                class="btn btn-primary">{$lang.savechanges}</button>
        <span
                class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
    </div>
</div>
