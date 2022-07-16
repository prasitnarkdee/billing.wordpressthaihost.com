<div class="row">
    <div class="col-lg-8">
        {include file='clients/fields_edit.tpl'}
    </div>

    <div class="col-lg-4">
        <div class="box box-primary">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.clacctype}</label>
                        <select name="type" class="form-control" onchange="{literal}if ($(this).val() == 'Private') {
                                                                $('.iscomp').hide();
                                                                $('.ispr').show();
                                                            } else {
                                                                $('.ispr').hide();
                                                                $('.iscomp').show();
                                                            }{/literal}">
                            <option value="Private" {if $client.company!='1'}selected="selected"{/if}>{$lang.Private}</option>
                            <option value="Company" {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                        </select>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.Status}:
                            <div class="vtip_description" style="font-size:inherit">
                                <div>
                                    {foreach from=$client_status key=status item=dscr}
                                        <div><b>{$lang[$status]}</b> - {$dscr}</div>
                                    {/foreach}
                                </div>
                            </div>
                        </label>
                        <select name="status" id="status" class="form-control">
                            {foreach from=$client_status key=status item=dscr}
                                <option value="{$status}"
                                        {if $client.status==$status}selected="selected"{/if}>{$lang[$status]}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>



                {if !$parent.id}
                    {if count($currencies)>1}
                        <div class="col-md-6">

                            <div class="form-group">
                                <label>{$lang.currency}:</label>
                                <select name="currency_id" id="currency_id" class="form-control">
                                    {foreach from=$currencies item=curre}
                                        <option value="{$curre.id}"
                                                {if $client.currency_id==$curre.id}selected="selected"{/if}>{if $curre.code}{$curre.code}{else}{$curre.iso}{/if}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    {/if}
                    {if $groups}
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Group:</label>
                                <select name="group_id" id="group_id" class="form-control">
                                    <option value="0">{$lang.none}</option>
                                    {foreach from=$groups item=group}
                                        <option value="{$group.id}" style="color:{$group.color}"
                                                {if $client.group_id==$group.id}selected="selected"{/if}>{$group.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    {/if}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{$lang.defaultlanguage}:</label>
                            <select name="language" id="language" class="form-control">
                                {foreach from=$client_languages key=k item=v}
                                    <option {if $v==$client.language} selected="selected"{/if}>{$v}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Billing contact: <i class="vtip_description" style="font-size:inherit"
                                                       title="Used for credit card / gateway payments"></i></label>

                            <select name="billing_contact_id" id="billing_contact_id" class="form-control">
                                <option value="0" {if !$client.billing_contact_id}selected{/if}>Default (this profile)</option>
                                {foreach from=$contacts item=v}
                                    <option {if $v.id==$client.billing_contact_id} selected="selected"{/if} value="{$v.id}">
                                        #{$v.id} {$v.firstname} {$v.lastname}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                {/if}

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.newpass}:</label>
                        <input name="password" type="password" autocomplete="off" class="form-control"/>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.repeatpass}:</label>
                        <input name="password2" type="password" autocomplete="off" class="form-control"/>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="form-group">
                        <label>{$lang.mfa}:</label>
                        <div>
                            {if $client.mfamodule}
                                <input type="hidden" name="mfamodule" value="0">
                                <input type="checkbox" name="mfamodule" value="{$client.mfamodule}" checked="checked">
                                <span>Active</span>
                            {else}
                                <span>Not activated</span>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>