<div class="option-line">
    <input type="hidden" value="1" name="settings[AdvancedDueDate]"/>
    {$lang.InvoiceExpectDays}
    <input type="text" size="3" class="inp"
           value="{$configuration.InvoiceExpectDays|escape}"
           name="settings[InvoiceExpectDays]"/> {$lang.InvoiceUnpaidReminder2}
</div>
<div class="option-line">
    {$lang.InitialDueDays}
    <input type="text" size="3" class="inp"
           value="{$configuration.InitialDueDays|escape}"
           name="settings[InitialDueDays]"/> {$lang.InitialDueDays2}
</div>
<p class="due-date">
    <span class="move-due-date">Move due date</span>
    <span class="set-due-date">Set minimum </span>
    <input type="text" size="3" class="inp"
           name="settings[MoveDueDays]"
           value="{$configuration.MoveDueDays|escape}"/>
    <span class="move-due-date">days into future for recurring invoices.</span>
    <span class="set-due-date">days for recurring invoices due date.</span>
</p>

