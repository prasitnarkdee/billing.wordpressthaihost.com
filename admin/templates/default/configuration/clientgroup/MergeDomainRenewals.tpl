<div class="option-line">
    <input name="settings[MergeDomainRenewals]" type="hidden" value="off"/>
    <input name="settings[MergeDomainRenewals]" type="checkbox" value="on" class="inp"
           {if $configuration.MergeDomainRenewals=='on'}checked{/if} />
    {$lang.MergeDomainRenewals}
</div>
<div class="option-line">
    <input name="settings[MergeMonthlyServiceRenewals]" type="hidden" value="off"/>
    <input name="settings[MergeMonthlyServiceRenewals]" type="checkbox" value="on" class="inp"
           {if $configuration.MergeMonthlyServiceRenewals=='on'}checked{/if} />
    {$lang.MergeMonthlyServiceRenewals}
</div>
<div class="option-line">
    <input name="settings[MergeAnnualServiceRenewals]" type="hidden" value="off"/>
    <input name="settings[MergeAnnualServiceRenewals]" type="checkbox" value="on" class="inp"
           {if $configuration.MergeAnnualServiceRenewals=='on'}checked{/if} />
    {$lang.MergeAnnualServiceRenewals}
</div>
