<div class="row light-labels">
    <div class="col-lg-8">
        {include file="clients/fields.tpl" class='form-plaintext-live'}
    </div>

    <div class="col-lg-4">
        <div class="box box-primary">
            <div class="panel-body">
               <div class="row">
                   <div class="col-md-6">
                       <div class="form-group">
                           <label>{$lang.clacctype}</label>
                           <div class="form-plaintext form-plaintext-live">
                               {if $client.company!='1'}{$lang.Private}{else}{$lang.Company}{/if}
                           </div>
                       </div>
                   </div>
                   <div class="col-md-6">
                       <div class="form-group">
                           <label>
                               {$lang.Status}:
                               <div class="vtip_description" style="font-size:inherit">
                                   <div>
                                       {foreach from=$client_status key=status item=dscr}
                                           <div><b>{$lang[$status]}</b> - {$dscr}</div>
                                       {/foreach}
                                   </div>
                               </div>
                           </label>
                           <div class="form-plaintext form-plaintext-live ">
                               <span class="{$client.status}">{$lang[$client.status]}</span>
                           </div>
                       </div>
                   </div>

                   {if !$parent.id}
                       {if count($currencies)>1}
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>{$lang.currency}:</label>
                                   <div class="form-plaintext form-plaintext-live ">
                                       {foreach from=$currencies item=curre}
                                           {if $client.currency_id==$curre.id}{if $curre.code}{$curre.code}{else}{$curre.iso}{/if}{/if}
                                       {/foreach}
                                   </div>
                               </div>
                           </div>
                       {/if}
                       {if $groups}
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>Group:</label>
                                   <div class="form-plaintext form-plaintext-live " style="color:{$client.group_color}">
                                       {$client.group_name}
                                   </div>
                               </div>
                           </div>
                       {/if}
                       <div class="col-md-6">
                           <div class="form-group">
                               <label>{$lang.defaultlanguage}:</label>
                               <div class="form-plaintext form-plaintext-live ">
                                   {$client.language}
                               </div>
                           </div>
                       </div>
                       <div class="col-md-6">
                           <div class="form-group">
                               <label>
                                   Billing contact:
                                   <i class="vtip_description" style="font-size:inherit"
                                      title="Used for credit card / gateway payments"></i>
                               </label>
                               <div class="form-plaintext form-plaintext-live ">
                                   {if !$client.billing_contact_id}Default{else}#{$client.billing_contact.id} {$client.billing_contact.firstname} {$client.billing_contact.lastname} {/if}
                               </div>
                           </div>
                       </div>
                   {/if}

                   <div class="col-md-6">
                       <div class="form-group">
                           <label>{$lang.password}:</label>
                           <div class="form-plaintext form-plaintext-live  ">
                               ****
                           </div>
                       </div>
                   </div>

                   <div class="col-md-6">
                       <div class="form-group">
                           <label>{$lang.mfa}:</label>
                           <div class="form-plaintext form-plaintext-live  ">
                               {if $client.mfamodule}
                                   <span class="text-success">{$clientmfamodule.modname}</span>
                               {else}
                                   <span class="text-danger">Not activated</span>
                               {/if}
                           </div>
                       </div>
                   </div>

               </div>
            </div>
        </div>
    </div>
</div>