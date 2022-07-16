<div class="option-line">
    <table class="invtemplate" cellspacing="0" cellpadding="3">
        {foreach from=$invtemplates item=tpl}
            <tr style="border: 1px solid #cccccc;">
                <td>
                    <input type="radio" name="settings[InvoiceTemplate]"
                           value="{$tpl.id}"
                           {if $configuration.InvoiceTemplate == $tpl.id}checked="checked"{/if}
                           id="seo_{$tpl.id}" style="vertical-align: bottom;"/>
                    <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                </td>
                <td>
                    <div>
                        <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
                           class="fs11">Preview</a>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
        {/foreach}
    </table>
</div>
