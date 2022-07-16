<div class="radio">
    <label for="igen_off">
        <input type="radio" {if $configuration.RenewInvoice == 0}checked{/if}
               name="settings[RenewInvoice]" value="0" data-toggle=""
               id="igen_off"/>
        <b>{$lang.no}</b>,
        do not generate renewal invoices for services automatically.
    </label>
</div>
<div class="radio">
    <label for="igen_on">
        <input type="radio" {if $configuration.RenewInvoice == 1}checked{/if}
               name="settings[RenewInvoice]" value="1"
               data-toggle="#RenewInvoiceOn,.due-date,.move-due-date"
               id="igen_on"/>
        <b>{$lang.yes}</b>, generate invoices relative to service due date.
    </label>
</div>
<div class="radio">
    <label for="igen_on">
        <input type="radio" {if $configuration.RenewInvoice == 2}checked{/if}
               name="settings[RenewInvoice]" value="2"
               data-toggle="#RenewInvoiceOn2,.due-date,.set-due-date"
               id="igen_on_2"/>
        <b>{$lang.yes}</b>, generate invoices on specific day.
    </label>
</div>

<div class="p5" id="RenewInvoiceOn">
    <span class="prorata">{$lang.InvoiceGeneration}</span>
    <input type="number" size="3" value="{$configuration.InvoiceGeneration|escape}"
           name="settings[InvoiceGeneration]" class="inp"/>
    {$lang.InvoiceGeneration2}.
</div>
<div class="p5" id="RenewInvoiceOn2">
    <div class="option-line">
        Generate invoices on
        <select name="settings[InvoiceGenerationDay]">
            {section start="1" loop=31 name=days}
                <option {if $configuration.InvoiceGenerationDay == $smarty.section.days.index}selected{/if}
                >{$smarty.section.days.index}
                </option>
            {/section}
            <option value="31"
                    {if $configuration.InvoiceGenerationDay == 31}selected{/if}
            >Last
            </option>
        </select>
        day of the month.
    </div>
</div>
