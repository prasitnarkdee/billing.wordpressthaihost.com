<input type="radio"
       {if $configuration.EnableAutoRegisterDomain == 'off'}checked{/if}
       name="settings[EnableAutoRegisterDomain]" value="off"
       data-toggle=""
       id="register_off"/>
<label for="register_off"><b>{$lang.no}</b></label>

<input type="radio"
       {if $configuration.EnableAutoRegisterDomain == 'on'}checked{/if}
       name="settings[EnableAutoRegisterDomain]" value="on"
       data-toggle="#register_opt"
       id="register_on"/>

<label for="register_on"><b>{$lang.yes}</b></label>
<div class="p5" id="register_opt"
     style="{if $configuration.EnableAutoRegisterDomain != 'on'}display:none;{/if}">
    <input type="radio" value="1" name="settings[AutoRegisterDomainType]"
            {if $configuration.AutoRegisterDomainType == 1} checked{/if}>
    {$lang.whenorderplaced}
    <br>
    <input type="radio" value="0" name="settings[AutoRegisterDomainType]"
            {if $configuration.AutoRegisterDomainType == 0} checked{/if}>
    After receiving payment
</div>

