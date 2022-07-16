<input type="radio"
       {if $configuration.EnableAutoSuspension == 'off'}checked{/if}
       name="settings[EnableAutoSuspension]" value="off"
       data-toggle="" id="suspend_off"/>
<label for="suspend_off"><b>{$lang.no}</b></label>

<input type="radio"
       {if $configuration.EnableAutoSuspension == 'on'}checked{/if}
       name="settings[EnableAutoSuspension]" value="on"
       data-toggle="#suspension_options" id="suspend_on"/>
<label for="suspend_on"><b>{$lang.yes}</b></label>

<div class="p5" id="suspension_options"
     style="{if $configuration.EnableAutoSuspension != 'on'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
    {$lang.new_EnableAutoSuspension1}
    <input type="text" size="3" value="{$configuration.AutoSuspensionPeriod|escape}"
           name="settings[AutoSuspensionPeriod]" class="inp config_val"/>
    {$lang.new_EnableAutoSuspension2}

</div>