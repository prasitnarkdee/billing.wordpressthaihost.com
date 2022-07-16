{foreach from=$fields key=gk item=group}
    <div class="box box-primary clientdetails-group">
        {if $group.id}
            <div class="box-header collapsed clientdetails-group-header" style="padding: 5px 15px;border-bottom: 1px solid #ddd;"
                 data-group-id="{$group.id}" href="#collapseGroupEdit-{$group.id}"
                 role="button" data-toggle="collapse"
                 aria-expanded="true" aria-controls="collapseGroupEdit-{$group.id}"
                 onclick="ClientDetailsGroups.toggleClientDetailsGroup(this)">
                <div style="display:flex;flex-direction:row;align-items:center;justify-content:space-between;">
                    <h2 style="margin: 5px 0">
                        {$group.name}
                        {if $group.description}
                            <span class="vtip_description" title="{$group.description}"></span>
                        {/if}
                    </h2>
                    <i class="fa fa-chevron-up arrow_icon" style="font-size: 16px"></i>
                </div>
            </div>
        {/if}
        <div class="{if $group.id}collapse in{/if} clientdetails-group-body"
             {if $group.id}id="collapseGroupEdit-{$group.id}"{/if}>
            <div class="panel-body">
                <div class="row">
                    {foreach from=$group.fields item=field key=k name=floop}
                        <div class="col-md-6">
                            {include file="clients/signup_input.tpl" fields=$group.fields}
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
{/foreach}