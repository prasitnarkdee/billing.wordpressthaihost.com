
<script type="text/javascript" src="{$template_dir}js/ticketdepts_sla.js?v={$hb_version}"></script>

<div class="panel panel-default">
    <div class="panel-heading"><strong>SLA Policies</strong></div>
    <div class="panel-body">
            <div class="slas">
                <table class="table" width="100%">
                    <thead>
                    <tr>
                        <th width="30%"><strong>Policy Name</strong></th>
                        <th width="30%" style=""><strong>Level</strong></th>
                        <th width="20%" style=""><strong>Trigger</strong></th>
                        <th width="20%"></th>
                    </tr>
                    </thead>
                    <tbody id="sla-list-body"></tbody>
                </table>
            </div>
        </div>
    <div class="panel-footer">
        <a href="" class="btn btn-sm btn-info add-sla" >
            <i class="fa fa-plus-square"></i>
            Add SLA policy
        </a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-heading"><strong>Report to manager</strong></div>
    <div class="panel-body">
        <table class="table" width="100%">
            <thead>
            <tr>
                <th width="20%"><strong>Allow clients to report:</strong></th>
                <th width="5%"><strong>Enabled</strong></th>
                <th><strong>Execute macro after report</strong></th>

            </tr>
            </thead>
            <tbody class="">

            <tr >
                <td  >Single replies</td>
                <td>
                    <input type="checkbox" name="reportreply" {if $submit.options & 131072}checked="checked"{/if} value="1"/>
                </td>
                <td>
                    <select name="macro_reportreply" class="form-control input-sm " style="max-width:300px">
                        <option value="0"> --</option>
                        {foreach from=$macros item=macro}
                            <option {if $submit.macro_reportreply == $macro.id}selected="selected"{/if}
                                    value="{$macro.id}">{$macro.catname|escape} - {$macro.name|escape}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            <tr >
                <td  >Entire threads</td>
                <td>
                    <input type="checkbox" name="reportticket" {if $submit.options & 262144}checked="checked"{/if} value="1"/>
                </td>
                <td>
                    <select name="macro_reportticket" class="form-control input-sm " style="max-width:300px">
                        <option value="0"> --</option>
                        {foreach from=$macros item=macro}
                            <option {if $submit.macro_reportticket == $macro.id}selected="selected"{/if}
                                    value="{$macro.id}">{$macro.catname|escape} - {$macro.name|escape}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            </tbody>
        </table>
</div>
</div>

<div class="panel panel-default">
    {assign var="week" value=','|explode:"monday,tuesday,wednesday,thursday,friday,saturday,sunday"}
    <div class="panel-heading"><strong>{$lang.business_hours}</strong></div>
    <div class="panel-body">
        <table class="table" width="100%">
            <thead>
            <tr>
                <th width="15%"><strong>{$lang.day_of_week}</strong></th>
                <th width="5%" class="text-right"><strong>{$lang.From}</strong></th>
                <th><strong>{$lang.To}</strong></th>
            </tr>
            </thead>
            <tbody class="">
            {foreach from=$week item=day}
                <tr >
                    <td  >{$lang[$day]}</td>
                    <td class="text-right">
                        <input type="text" name="business[{$day}][from]" value="{if $business[$day].from}{$business[$day].from|date_format:"%H:%M"}{else}00:00{/if}"
                               class="timepicker inp" placeholder="" style="width:45px" autocomplete="off">
                    </td>
                    <td>
                        <input type="text" name="business[{$day}][to]" value="{if $business[$day].to}{$business[$day].to|date_format:"%H:%M"}{else}00:00{/if}"
                               class="timepicker inp" placeholder="" style="width:45px" autocomplete="off">
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>

{literal}
<script id="slas-form-options" type="text/x-handlebars-template">
    {{#each options}}
    <option {{#each data}}data-{{@key}}="{{this}}"{{/each}}
    value="{{value}}" {{#if selected}}selected{{/if}}>
    {{name}}
    </option>
    {{/each}}
</script>

<script id="slas-row-template" type="text/x-handlebars-template">
    {{#each sla}}
    <tr class="metric-row" data-index="{{@key}}">
        <td style="vertical-align:top;" class="slas-row-name">
            <label>{{name}}</label>
        </td>
        <td style="vertical-align: top;">
            <label>{{level}}</label>
        </td>
        <td style="vertical-align: top;">
            <label>{{trigger_name}}</label>
        </td>
        <td style="vertical-align: top; text-align: right;">
            <a href="#" type="button" class="btn btn-primary btn-sm edit">
                <i class="fa fa-pencil"></i> {/literal}{$lang.Edit}{literal}
            </a>
            <a class="btn btn-danger btn-sm remove" href="?cmd=ticketdepts&action=delete_sla&id={{id}}"
               onclick="return confirm('Are you sure you want to remove SLA Policy?');">
                <i class="fa fa-trash"></i> {/literal}{$lang.Remove}{literal}
            </a>
        </td>
    </tr>
    {{else}}
     <tr class="slas_body_empty_row">
        <td colspan="4">
            <span>There are no SLA Policies set for this department</span>
        </td>
    </tr>
    {{/each}}
</script>
<script  id="sla-modal" type="text/x-handlebars-template">
    <form action="?cmd=ticketdepts&action={{action}}" method="post">
        <input type="hidden" name="id" value="{{#if sla.id}}{{sla.id}}{{else}}new{{/if}}">
        <input type="hidden" name="sla[dept_id]" value="{{#if sla.dept_id}}{{sla.dept_id}}{{else}}{{dept_id}}{{/if}}">

        <div class="form-group">
            <label>Policy Name
                <span class="vtip_description" title="For admin/logging purposes only"></span>
            </label>
            <input class="form-control" type="text" value="{{sla.name}}" name="sla[name]"/>
        </div>
        <div class="form-group">
            <label>Level
                <span class="vtip_description" title="Higher level is more severe.
                If ticket breaches certain level only SLA policy above this level applies"></span>
            </label>
            <select name="sla[level]" class="form-control metric_choose">
                {{#each levels}}
                    <option {{#if selected}}selected {{/if}} >{{value}}</option>
                {{/each}}
            </select>
        </div>
        <div class="form-group">
            <label>Trigger <span class="vtip_description" title="Event type breaching this policy"></span></label>
            <select name="sla[trigger]" class="sla_trigger form-control metric_choose" >
                {{#each triggers}}
                    <option data-trigger="{{value}}" value="{{value}}" {{#if selected}}selected{{/if}}>
                        {{name}}
                    </option>
                {{/each}}
            </select>
        </div>
        <div class="form-group">
            <label>Trigger Value
                <span class="vtip_description" title="Policy breaches when triggering value is higher or equal">
                </span>
            </label>
            <input name="sla[trigger_value]" type="number" class="form-control"
                   min="0" value="{{#if sla.trigger_value}}{{sla.trigger_value}}{{else}}0{{/if}}">
            <span class="input-group-addon"
                  style="width:0px; padding-left:0px; padding-right:0px; border:none;"></span>
            <select name="sla[trigger_unit]" class="form-control metric_choose sla_trigger_unit">
                {{#each triggers}}
                    {{#each units}}
                        <option data-trigger="{{../value}}"  {{#if selected}}selected{{/if}}
                            {{#if hidden}}hidden{{/if}} value="{{value}}">{{name}}
                        </option>
                    {{/each}}
                {{/each}}
            </select>
        </div>
        <div class="form-group">
            <label>Tags
                <span class="vtip_description" title="You can use &quot;and&quot;, &quot;or&quot;, &quot;not&quot; keywords when filtering with tags, default is &quot;and&quot;, example: <br> &bullet;&nbsp;tag1 tag2 or tag3 &raquo; (tag1 and tag2) or tag3<br><br>You can use the <b>untagged</b> tag for tickets that have no tags"></span></label>
            <input type="text" name="sla[tags]" value="{{sla.tags}}" class="form-control" >
        </div>
        <div class="form-group" style="margin-bottom: 0;">
            <label>De-escalate
                <span class="vtip_description" title="If this option is checked, Escalation will be removed after the staff member replies"></span></label><br>
            <input type="checkbox" name="sla[de_escalate]" value="1"
                   {{#if sla.de_escalate}}checked{{/if}} class=" input-sm">
        </div>
        <div class="form-group">
            <label>Macro
                <span class="vtip_description" title="Executed on ticket when it breaches this SLA policy">
                </span>
            </label>
            <select name="sla[macro_id]" class="form-control choose">
                <option value="0">---</option>
                {{#each macros}}
                    <option value="{{value}}" {{#if selected}}selected{{/if}}>{{name}}</option>
                {{/each}}
            </select>
        </div>
        <div class="form-group">
            <label>Statuses <span class="vtip_description" title="Only tickets with selected statuses will be checked"></span></label><br>
            <select name="sla[trigger_status][]" multiple class="form-control sla-chosen">
                {{#each statuses}}
                    <option value="{{status}}" {{#if selected}}selected{{/if}}>{{status}}</option>
                {{/each}}
            </select>
        </div>
        <div class="form-group">
            <label>Business hours </label><br>
            <select name="sla[business_hours]" class="form-control">
                {{#each business_hours}}
                <option value="{{value}}" {{#if selected}}selected{{/if}}>{{name}}</option>
                {{/each}}
             </select>
        </div>
        <div class="form-group">
            <label>Override staff notification <span class="vtip_description" title="If there are any staff members set then they will get a <code>Ticket: Escalated</code> notification"></span></label><br>
            <select name="sla[override_staff][]" multiple class="form-control sla-chosen">
                {{#each admins}}
                    <option value="{{id}}" {{#if selected}}selected{{/if}}>{{username}}</option>
                {{/each}}
            </select>
        </div>
    </div>
    {/literal}{securitytoken}{literal}
</form>

</script>
{/literal}
<script>
    initSLAsOptions(
        {$slas|@json_encode},
        {$statuses|@json_encode},
        {$triggers|@json_encode},
        {$macros|@json_encode},
        {$tags|@json_encode},
        {$admins|@json_encode}
    );
</script>

<link media="all" rel="stylesheet" href="{$template_dir}js/timepicker/jquery.timepicker.css" />
<script type="text/javascript" src="{$template_dir}js/timepicker/jquery.timepicker.min.js?v={$hb_version}" ></script>