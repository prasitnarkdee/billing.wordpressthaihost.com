<input type="radio" {if $configuration.LateFeeType == '0'}checked{/if}
       name="settings[LateFeeType_sw]" value="0"
       data-toggle=""
       id="latefee_off"/>
<label for="latefee_off"><b>{$lang.no}</b></label>

<input type="radio" {if $configuration.LateFeeType != '0'}checked{/if}
       name="settings[LateFeeType_sw]" value="1"
       data-toggle="#latefee_options"
       id="latefee_on"/>
<label for="latefee_on"><b>{$lang.yes}</b></label>

<div class="p5" id="latefee_options"
     style="{if $configuration.LateFeeType == '0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
    {$lang.new_LateFeeType_on1}
    <input size="1" class="inp config_val"
           value="{$configuration.LateFeeValue|escape}"
           name="settings[LateFeeValue]"/>

    <select class="inp config_val" name="settings[LateFeeType]">
        <option {if $configuration.LateFeeType=='1'}selected{/if}
                value="1">%
        </option>
        <option {if $configuration.LateFeeType=='2'}selected
                {/if}value="2">{if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</option>
    </select>
    {$lang.new_LateFeeType_on2}
</div>

