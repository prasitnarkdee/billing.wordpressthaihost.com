<form>
    <div class="checkbox">
        <label>
            <input type="checkbox" name="config[allow]" value="1" {if $widget.config.allow}checked{/if}> Allow when the <strong>Generate invoices</strong> option is disabled
        </label>
    </div>
    <div class="form-group">
        <label style="text-decoration: none;">
            Generate invoice <input style="max-width: 60px;" type="number" name="config[days]" value="{$widget.config.days|default:0}"> days before the due date for product/service
        </label><a class="vtip_description" title="This option has the lowest priority"></a>
    </div>
</form>