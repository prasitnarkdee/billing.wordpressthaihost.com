<div class="form-horizontal" style="max-width: 95%">
    <div class="form-group">
        <div class="col-sm-10">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="config[password]" value="1" {if $widget.config.password}checked{/if}> <b>Hide Password</b>
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-10">
            <div class="checkbox">
                <label>
                    <input type="checkbox"  name="config[rootpassword]" value="1" {if $widget.config.rootpassword}checked{/if}> <b>Hide Root Password</b>
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-12">
            <label >Additional fields </label>
            <input type="text" class="form-control" name="config[additionalforms]" value="{$widget.config.additionalforms}" id="additionalforms"/>
            <p class="help-block">Comma-separated list of variable names of form items which should appear on login details page in client portal</p>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-12">
            <label >HTML replacement </label>
            <textarea  class="form-control" name="config[htmloverride]"  id="htmloverride">{$widget.config.htmloverride|escape}</textarea>
            <p class="help-block">Code used here will be rendered in login details function in client portal (replacing default layout). <br>Smarty syntax allowed, available variables (arrays):<br>
                <code>{literal}{$account}{/literal}</code> - account details, i.e.: <code>{literal}{$account.username}, {$account.id}{/literal}</code><br>
                <code>{literal}{$forms}{/literal}</code> - related forms values, i.e.: <code>{literal}{$form.<strong>variable</strong>.value}{/literal}</code> - value of form with variable: variable,<br>
                <code>{literal}{$server}{/literal}</code> - related app details, i.e.: <code>{literal}{$server.ip}, {$server.name}{/literal}</code></p>
        </div>
    </div>
</div>