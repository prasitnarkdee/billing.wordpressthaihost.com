<input type="radio"
       {if $configuration.EnableAutoTransferDomain == 'off'}checked{/if}
       name="settings[EnableAutoTransferDomain]" value="off"
       data-toggle=""
       id="transfer_off"/><label for="transfer_off"><b>{$lang.no}</b></label>
<input type="radio"
       {if $configuration.EnableAutoTransferDomain == 'on'}checked{/if}
       name="settings[EnableAutoTransferDomain]" value="on"
       data-toggle="#transfer_options"
       id="transfer_on"/><label for="transfer_on"><b>{$lang.yes}</b></label>

<div class="p5" id="transfer_options"
     style="{if $configuration.EnableAutoTransferDomain != 'on'}display:none;{/if}">
    <input type="radio" value="1" name="settings[AutoTransferDomainType]"
            {if $configuration.AutoTransferDomainType == 1} checked{/if}>
    {$lang.whenorderplaced}
    <br>
    <input type="radio" value="0" name="settings[AutoTransferDomainType]"
            {if $configuration.AutoTransferDomainType == 0} checked{/if}>
    After receiving payment
    <div class="clear"></div>
</div>

