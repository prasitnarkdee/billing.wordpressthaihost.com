<input type="radio"
       {if $configuration.SendPaymentReminderEmails == 'off'}checked{/if}
       name="settings[SendPaymentReminderEmails]" value="off"
       data-toggle="" id="reminder_off"/>
<label for="reminder_off"><b>{$lang.no}</b></label>
<input type="radio"
       {if $configuration.SendPaymentReminderEmails == 'on'}checked{/if}
       name="settings[SendPaymentReminderEmails]"
       data-toggle="#reminder_options" id="reminder_on"/>
<label for="reminder_on"><b>{$lang.yes}</b></label>

<div class="p5" id="reminder_options"
     style="{if $configuration.SendPaymentReminderEmails == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">

    <div class="option-line">
        {$lang.InvoiceUnpaidReminder}
        <input type="checkbox" value="1"
               {if $configuration.InvoiceUnpaidReminder>0}checked{/if}
               onclick='check_i(this);if(!$(this).is(":checked"))$("#settings_InvoiceUnpaidReminder").val(0);'/>
        <input type="number" step="1" min="0" style="width: 50px;" id="settings_InvoiceUnpaidReminder"
               class="config_val  inp" {if $configuration.InvoiceUnpaidReminder<=0} value="0" disabled{else}value="{$configuration.InvoiceUnpaidReminder|escape}"{/if}
               name="settings[InvoiceUnpaidReminder]"/>
        {$lang.InvoiceUnpaidReminder2}
    </div>

    <div class="option-line">
        {$lang.1OverdueReminder}
        <span>
            <input type="hidden" name="settings[1OverdueReminder]" value="0" />
            <input type="checkbox" value="1"
                   {if $configuration.1OverdueReminder>0}checked{/if}
                   onclick='check_i(this);if(!$(this).is(":checked"))$("#settings_1OverdueReminder").val(0);'/>
            <input type="number" step="1" min="0" style="width: 50px;" class="config_val  inp" id="settings_1OverdueReminder"
                    {if $configuration.1OverdueReminder<=0} value="0" disabled
                    {else} value="{$configuration.1OverdueReminder|escape}"{/if}
                   name="settings[1OverdueReminder]"/>
        </span>

        <span>
            <input type="hidden" name="settings[2OverdueReminder]" value="0" />
            <input type="checkbox" value="1"
                   {if $configuration.2OverdueReminder>0}checked{/if}
                   onclick='check_i(this);if(!$(this).is(":checked"))$("#settings_2OverdueReminder").val(0);'/>
            <input type="number" step="1" min="0" style="width: 50px;" id="settings_2OverdueReminder"
                   class="config_val inp"
                   {if $configuration.2OverdueReminder<=0}value="0" disabled
                    {else} value="{$configuration.2OverdueReminder|escape}"{/if}
                   name="settings[2OverdueReminder]"/>
        </span>

        <span>
            <input type="hidden" name="settings[3OverdueReminder]" value="0" />
            <input type="checkbox" value="1"
                   {if $configuration.3OverdueReminder>0}checked{/if}
                   onclick='check_i(this);if(!$(this).is(":checked"))$("#settings_3OverdueReminder").val(0);'/>
            <input type="number" step="1" min="0" style="width: 50px;" id="settings_3OverdueReminder"
                   class="config_val  inp"
                    {if $configuration.3OverdueReminder<=0} value="0" disabled
                    {else} value="{$configuration.3OverdueReminder|escape}"{/if}
                   name="settings[3OverdueReminder]"/>
            {$lang.1OverdueReminder2}
        </span>
    </div>

</div>
