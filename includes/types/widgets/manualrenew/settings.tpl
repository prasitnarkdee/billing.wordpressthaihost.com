<form>
    <div class="checkbox">
        <label>
            <input style="margin-top: 6px;" type="checkbox" name="config[hide]" value="1" {if $widget.config.hide}checked{/if}>
            Don't allow manual renew before <input style="max-width: 60px;" type="number" name="config[before_duedate]" value="{$widget.config.before_duedate|default:0}"> days due date
        </label>
    </div>
</form>