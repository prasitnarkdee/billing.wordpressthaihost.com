<div class="modal fade" tabindex="-1" role="dialog" id="sla_edit_{if !$sla}new{else}{$sla.id}{/if}">
    <form action="?cmd=ticketdepts&action={if !$sla}add{else}edit{/if}_sla&id={if !$sla}new{else}{$sla.id}{/if}" method="post" data-slaid="{if !$sla}new{else}{$sla.id}{/if}">
        <input class="sla-form" type="hidden" name="form" value="?cmd=ticketdepts&action={if !$sla}add{else}edit{/if}_sla&id={if !$sla}new{else}{$sla.id}{/if}">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{$sla.name}</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Policy Name <span class="vtip_description" title="For admin/logging purposes only"></span></label>
                        <input class="form-control" type="text" value="{$sla.name}" name="sla[name]"/>
                    </div>
                    <div class="form-group">
                        <label>Level <span class="vtip_description" title="Higher level is more severe. If ticket breaches certain level only SLA policy above this level applies"></span></label>
                        <select name="sla[level]" class="form-control metric_choose">
                            {foreach from=$levels item=level}
                                <option {if $sla.level == $level}selected{/if}>{$level}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Trigger <span class="vtip_description" title="Event type breaching this policy"></span></label>
                        <select name="sla[trigger]" class="sla_trigger form-control metric_choose" >
                            {foreach from=$triggers item=trigger key=id}
                                <option data-trigger="{$id}" value="{$id}" {if $id == $sla.trigger}selected{/if}>{$trigger.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Trigger Value <span class="vtip_description" title="Policy breaches when  triggering value is higher or equal"></span></label>
                        <input name="sla[trigger_value]" type="number" class="form-control"
                               min="0" value="{if $sla.trigger_value}{$sla.trigger_value}{else}0{/if}">
                        <span class="input-group-addon" style="width:0px; padding-left:0px; padding-right:0px; border:none;"></span>
                        <select name="sla[trigger_unit]" class="form-control metric_choose sla_trigger_unit">
                            {foreach from=$triggers item=trigger key=id}
                                {foreach from=$trigger.units item=unit}
                                    <option data-trigger="{$id}" {if $unit == $sla.trigger_unit || !$sla.trigger_unit && $id == $sla.trigger}selected{/if}
                                            {if $id != $sla.trigger}hidden{/if}>{$unit}</option>
                                {/foreach}
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tags <span class="vtip_description" title="You can use &quot;and&quot;, &quot;or&quot;, &quot;not&quot; keywords when filtering with tags, default is &quot;and&quot;, example: <br> &bullet;&nbsp;tag1 tag2 or tag3 &raquo; (tag1 and tag2) or tag3<br><br>You can use the <b>untagged</b> tag for tickets that have no tags"></span></label>
                        <input type="text" name="sla[tags]" value="{$sla.tags}" class="form-control " >
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>De-escalate  <span class="vtip_description" title="If this option is checked, Escalation will be removed after the staff member replies"></span></label><br>
                        <input type="checkbox" name="sla[de_escalate]" value="1" {if $sla.de_escalate}checked{/if} class=" input-sm">
                    </div>
                    <div class="form-group">
                        <label>Macro <span class="vtip_description" title="Executed on ticket when it breaches this SLA policy"></span></label><br>
                        <select name="sla[macro_id]" class="form-control choose">
                            <option value="0" {if $sla.macro_id == $macro.id}selected{/if}>---</option>
                            {foreach from=$macros item=macro}
                                <option value="{$macro.id}" {if $sla.macro_id == $macro.id}selected{/if}>{$macro.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Statuses <span class="vtip_description" title="Only tickets with selected statuses will be checked"></span></label><br>
                        <select name="sla[trigger_status][]" multiple class="form-control sla-chosen">
                            {foreach from=$statuses item=status}
                                <option value="{$status.status}" {if in_array($status.status, $sla.trigger_status)}selected{/if}>{$status.status}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Business hours </label><br>
                        <select name="sla[business_hours]" class="form-control">
                            <option value="1" {if $sla.business_hours == 1}selected{/if}>Anytime</option>
                            <option value="2" {if $sla.business_hours == 2}selected{/if}>During business hours</option>
                            <option value="3" {if $sla.business_hours == 3}selected{/if}>Outside business hours</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Override staff notification <span class="vtip_description" title="If there are any staff members set then they will get a <code>Ticket: Escalated</code> notification"></span></label><br>
                        <select name="sla[override_staff][]" multiple class="form-control sla-chosen">
                            {foreach from=$admins item=admin}
                                <option value="{$admin.id}" {if in_array($admin.id, $sla.override_staff)}selected{/if}>{$admin.username}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <input type="hidden" name="sla[dept_id]" value="{if $sla.dept_id}{$sla.dept_id}{else}{$dept_id}{/if}">
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">{$lang.Close}</button>
                    <button type="button" onclick="submit_sla(this);" class="btn btn-primary">{$lang.savechanges}</button>
                </div>
            </div>
        </div>
        {securitytoken}
    </form>
</div>