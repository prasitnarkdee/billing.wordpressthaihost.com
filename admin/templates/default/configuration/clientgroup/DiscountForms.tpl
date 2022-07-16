<div class="checkbox" style="margin-top: 0">
    <label>
        <input type="checkbox"
               value="1" id="DiscountFormsToggle"
               {if $groupx.settings_enabled.DiscountForms}checked{/if}/>
        Discount form component
    </label>
    <span class="vtip_description">
        <div>
            When this option is enabled product price <strong><u>will not</u></strong> be
            discounted. Discount will only apply to price from selected form components.
            When disabled discount is calculated from product price and all forms that allow it.
        </div>
    </span>
</div>
<select multiple="multiple" name="settings[DiscountForms][]" class="form-control" data-chosen
        data-placeholder="Select applicable form variables" id="DiscountForms">
    {foreach from=$formvars item=variable}
        <option value="{$variable}"
                {if in_array($variable, $configuration.DiscountForms)}selected{/if}>
            {$variable}
        </option>
    {/foreach}
</select>
<div class="help-block">
    <small>Select variables used in forms that you want to discount.</small>
</div>

