<input type="radio"
       {if $configuration.EnableAutoTermination == 'off'}checked{/if}
       name="settings[EnableAutoTermination]" value="off"
       data-toggle=""
       id="termination_off"/>
<label for="termination_off"><b>{$lang.no}</b></label>

<input type="radio"
       {if $configuration.EnableAutoTermination == 'on'}checked{/if}
       name="settings[EnableAutoTermination]" value="on"
       data-toggle="#termination_options"
       id="termination_on"/>
<label for="termination_on"><b>{$lang.yes}</b></label>

<div class="p5" id="termination_options"
     style="{if $configuration.EnableAutoTermination != 'on'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
    {$lang.new_EnableAutoTermination1}
    <input type="text" size="3"
           value="{$configuration.AutoTerminationPeriod|escape}"
           name="settings[AutoTerminationPeriod]"
           class="inp config_val"/>
    {$lang.new_EnableAutoTermination2}
</div>
