<div class="option-line">
    <input type="radio" name="settings[CCChargeAuto]" value="off"
           {if $configuration.CCChargeAuto=='off'}checked{/if}
           data-toggle=""/>
    <strong>{$lang.no}, </strong> {$lang.CCChargeAuto_dscr1}
</div>
<div class="option-line">
    <input type="radio" name="settings[CCChargeAuto]" value="on"
           {if $configuration.CCChargeAuto=='on'}checked{/if}
           data-toggle=".chargefew"/>
    <strong>{$lang.yes}, </strong> {$lang.CCChargeAuto_dscr}
    <input type="text" size="3"
           value="{if $configuration.CCChargeAuto!='on'}0{else}{$configuration.CCDaysBeforeCharge|escape}{/if}"
           name="settings[CCDaysBeforeCharge]"/>
    {$lang.CCChargeAuto2}
</div>

<div class="chargefew"
     style="padding-left: 10px; margin-left: 5px; border-left: 1px solid #ddd">
    <div class="option-line">
        <input type="radio" name="settings[CCAttemptOnce]" value="on"
               {if $configuration.CCAttemptOnce=='on'}checked{/if}/> {$lang.CCAttemptOnce}
    </div>
    <div class="option-line">
        <input type="radio" name="settings[CCAttemptOnce]" value="off"
               {if $configuration.CCAttemptOnce=='off'}checked{/if}/> {$lang.CCAttemptOnce2}
        <input type="text" size="3" name="settings[CCRetryForDays]"
               value="{if $configuration.CCRetryForDays}{$configuration.CCRetryForDays|escape}{else}3{/if}"/>
        {$lang.days}
    </div>
</div>
