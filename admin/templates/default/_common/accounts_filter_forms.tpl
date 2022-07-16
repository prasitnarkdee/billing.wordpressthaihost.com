{literal}
    <script>
        $('.form-control-chosen').chosenedge({width: '100%'});
    </script>
{/literal}

<button type="button" class="btn btn-info btn-block" data-toggle="modal" data-target="#accFilterForms">Select criteria</button>
<div class="modal fade" id="accFilterForms" tabindex="-1" role="dialog" aria-labelledby="accFilterFormsLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="accFilterFormsLabel">Search / Filter</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="form-group col-sm-6">
                        <label>Form name</label>
                        <select name="filter[form_name]" class="form-control form-control-chosen">
                            <option value="">-</option>
                            {foreach from=$components_names item=component}
                                <option value="{$component.name}" {if $currentfilter.form_name==$component.name} selected="selected" {/if}>{$component.name|lang}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group col-sm-6">
                        <label>Form variable</label>
                        <select name="filter[form_variable]" class="form-control form-control-chosen">
                            <option value="">-</option>
                            {foreach from=$components_variables item=component}
                                <option value="{$component.variable}" {if $currentfilter.form_variable==$component.variable} selected="selected" {/if}>{$component.variable} ({$component.name|lang})</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group col-sm-6">
                        <label>Value name</label>
                        <input type="text" value="{$currentfilter.value_name}" name="filter[value_name]" class="form-control">
                    </div>

                    <div class="form-group col-sm-6">
                        <label>Value variable</label>
                        <input type="text" value="{$currentfilter.value_variable}" name="filter[value_variable]" class="form-control">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">Close</button>
                <button name="filter_reload" value="1" class="btn btn-primary">Apply filter</button>
            </div>
        </div>
    </div>
</div>