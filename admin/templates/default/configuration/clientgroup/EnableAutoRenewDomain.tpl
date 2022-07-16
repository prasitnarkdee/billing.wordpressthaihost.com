<input type="radio"
       {if $configuration.EnableAutoRenewDomain == 'off'}checked{/if}
       name="settings[EnableAutoRenewDomain]" value="off"
       data-toggle=""
       id="renew_off_dom"/>
<label for="renew_off_dom"><b>{$lang.no}</b></label>

<input type="radio"
       {if $configuration.EnableAutoRenewDomain == 'on'}checked{/if}
       name="settings[EnableAutoRenewDomain]" value="on"
       data-toggle="#renewal_options"
       id="renew_on_dom"/>
<label for="renew_on_dom"><b>{$lang.yes}</b></label>

<div class="p5" id="renewal_options"
     style="{if $configuration.EnableAutoRenewDomain != 'on'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
    <input type="radio" value="on" name="settings[RenewOnOrder]"
            {if $configuration.RenewOnOrder == 'on'} checked{/if}>
    When renwal order is placed
    <br>
    <input type="radio" value="" name="settings[RenewOnOrder]"
            {if $configuration.RenewOnOrder != 'on'} checked{/if}>
    After receiving payment
    <div class="clear"></div>
</div>
