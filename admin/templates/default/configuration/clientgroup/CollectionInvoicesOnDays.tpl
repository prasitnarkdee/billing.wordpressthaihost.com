<div class="option-line">
    <input type="radio" name="settings[CollectionInvoicesOnDays]" value="off"
           {if $configuration.CollectionInvoicesOnDays!='on'}checked{/if}/>
    <strong>{$lang.no}</strong>, Do not move manually issued invoices to Collections status <br>
    <input type="radio" name="settings[CollectionInvoicesOnDays]" value="on"
           {if $configuration.CollectionInvoicesOnDays=='on'}checked{/if}/>
    <strong>{$lang.yes}</strong>, Automatically move manually issued invoices to Collections status
    <input type="text" size="3"
           value="{$configuration.CollectionInvoicesOnDaysValue|escape}"
           name="settings[CollectionInvoicesOnDaysValue]"/>
    days after due date.
</div>
