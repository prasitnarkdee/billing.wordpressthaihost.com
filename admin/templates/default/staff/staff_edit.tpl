<form name="" action="" method="post" style="padding: 10px">
    <input name="make" value="{$action}" type="hidden"/>

    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>{if $action!='myaccount'}{$lang.generalsettings}{else}My account{/if}</strong>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="form-group col-md-6">
                    <label>{$lang.firstname}</label>
                    <input type="text" name="firstname" value="{$details.firstname}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.lastname}</label>
                    <input type="text" name="lastname" value="{$details.lastname}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.Email}</label>
                    <input type="text" name="email" value="{$details.email}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.Username}</label>
                    <input type="text" name="username" value="{$details.username}" class="form-control"/>
                </div>
                <div class="form-group col-md-6">
                    <label>{$lang.Password}</label>
                    <input type="password" name="password" value="{$details.repeatpass}" class="form-control"/>

                </div>
                <div class="form-group col-md-6">
                    <label>{$lang.repeatpass}</label>
                    <input type="password" name="password2" value="{$details.repeatpass}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.mfa}</label>
                    <div>
                        {if $action==='myaccount'}
                            {if $mfaenabled && $mfamodule.active}
                                <span style="color: green" role="alert">
                                    Multi-factor authentication is configured successfully.
                                    Module: <b>{if $mfamodule}{$mfamodule.modname}{else}Unknown{/if}</b>
                                </span>
                            {elseif $mfaenabled}
                                <span style="color: #d0970e">
                                    Multi-factor authentication is configured incorrectly! See why:
                                </span>
                            {else}
                                <span style="color: red" role="alert">Multi-factor authentication is not configured yet!</span>
                            {/if}
                        {else}
                            {if $details.mfamodule && $details.mfamodulename}
                                {if $details.id === $admindata.id}
                                    <span style="color: green" role="alert">
                                        Multi-factor authentication is configured.
                                        Module: <b>{$details.mfamodulename|default:"Unknown"}</b>
                                    </span>
                                {else}
                                    <input name="mfamodule" type="hidden" value="0"/>
                                    <div class="checkbox">
                                        <label>
                                            <input name="mfamodule" type="checkbox" value="{$details.mfamodule}" {if $details.mfamodule} checked="checked "{/if} />
                                            Active (<b>{$details.mfamodulename|default:"Unknown"}</b>)
                                        </label>
                                    </div>
                                {/if}
                            {else}
                                <span style="color: red" role="alert">Multi-factor authentication is not configured!</span>
                            {/if}
                        {/if}

                        {if $action==='myaccount' || $details.id === $admindata.id}
                            <a href="?cmd=mfa">Configure</a>
                        {/if}
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>{$lang.Signature}</label>
                {if !$details.signature}<a href="#" onclick="$(this).hide();
                    $('#signature').show();
                    return false;"><strong>{$lang.signatureadd}</strong></a>
                {/if}
                <textarea name="signature" id="signature" class="form-control"
                          style="{if !$details.signature};display:none;{/if}">{$details.signature}</textarea>

            </div>

            {if $fields}
                {foreach from=$fields key=f item=fv}
                    {if $fv.type=='input' || $fv.type=='encrypted'}
                        <div class="form-group">
                            <label>{$fv.name}</label>
                            <input type="text" name="{$f}" value="{$details[$f]}" class="form-control"/>
                        </div>
                    {elseif $fv.type=='checkbox'}
                        <div class="checkbox">
                            <label>
                                <input name="{$f}" type="checkbox"
                                       value="1" {if $details[$f]=='1'} checked="checked "{/if} />
                                {$fv.name}
                            </label>
                        </div>
                    {elseif $fv.type=='select'}
                        <div class="form-group">
                            <label>{$fv.name}</label>
                            <select name="{$f}" class="form-control">
                                {foreach from=$fv.default item=i}
                                    <option value="{$i}" {if $details[$f]==$i}selected="selected"{/if}>{$i|lang}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}
                {/foreach}
            {/if}

            {if $action!='myaccount'}
                {if $teams}
                    <div class="form-group">
                        <label>Assigned Team</label>
                        <input name="teams[]" value="-1" type="hidden"/>
                        <select name="teams[]" multiple class="form-control group-assign">
                            {foreach from=$teams item=team}
                                <option value="{$team.id}"
                                        {if in_array($team.id, $details.teams)}selected{/if}>{$team.name}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
                {if $details.id}
                    <div class="form-group">
                        <label>{$lang.Status}</label>
                        <div style="font-size: 1.2em">
                            <label>
                                <input type="radio" name="status" value="Active"
                                       {if $details.status == 'Active'}checked{/if} hidden="">
                                <span class="label-livemode label label-success-invert"
                                      data-value="Active">Active</span>
                            </label>
                            <label>
                                <input type="radio" name="status" value="Inactive"
                                       {if $details.status == 'Inactive'}checked{/if} hidden="">
                                <span class="label-livemode label label-default-invert"
                                      data-value="Inactive">Inactive</span>
                            </label>
                        </div>
                    </div>
                {/if}
            {/if}

            {if $action==='myaccount'}
                <hr>

                <div class="form-group">
                    <label>Client-related tabs</label>
                    <span class="vtip_description"
                          title="Select list of tabs related to customer which should appear across your admin UI">
                    </span>
                    <div class="">
                        {foreach from=$clienttabs item=tab key=tabkey}
                            <label class="checkbox-inline">
                                <input type="hidden" name="ui_config[clienttabs_visible][{$tabkey}]" value="0" />
                                <input name="ui_config[clienttabs_visible][{$tabkey}]" type="checkbox"
                                       {if $details.ui_config.clienttabs_visible[$tabkey]}checked{/if}
                                       value="1">
                                {$tab.name|parsetag}
                            </label>
                        {/foreach}
                    </div>
                </div>

                <div class="form-group">
                    <label>Default search areas</label>
                    <span class="vtip_description"
                          title="Select smart-search areas that are by default enabled for you"></span>

                    <div class="">
                        {foreach from=$search_on item=cat}
                            <label class="checkbox-inline">
                                <input type="hidden" name="ui_config[search_on][{$cat}]" value="0" />
                                <input name="ui_config[search_on][{$cat}]" type="checkbox"
                                       {if $details.ui_config.search_on[$cat]}checked{/if}
                                       value="1">
                                {$cat}
                            </label>
                        {/foreach}
                    </div>
                </div>
            {/if}
        </div>
        <div class="panel-footer">
            <button type="submit" value="1" name="save" class="btn btn-primary">{$lang.savechanges}</button>
            <span class="orspace">{$lang.Or}
                <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
        </div>
    </div>

    <div class="staff-options">
        {if $action!='myaccount'}
            {include file="staff/acl.tpl"}
            {include file="staff/notify.tpl"}
        {/if}

    </div>


    {securitytoken}
</form>