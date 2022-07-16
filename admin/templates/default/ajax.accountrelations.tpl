{if $action=='getclientservices'}
    <form method="post" action="?cmd=accountrelations&action=assign" id="submitform">
        <input type="hidden" name="item_id" value="{$item_id|escape}"/>
        <input type="hidden" name="item_type" value="{$item_type|escape}"/>
        <input type="hidden" name="client_id" value="{$client_id|escape}"/>

        <div class="form-group">
            <label>Client services</label>
            <select name="service_id" id="service_id_selector" class="form-control">
                {foreach from=$services item=service}
                    <option value="{$service.type}_{$service.id}">
                        {$lang[$service.type]}: #{$service.id}  {$service.product} {$service.domain}
                    </option>
                {/foreach}
            </select>
        </div>
    </form>
{literal}
    <script >

        function assignService() {
            $('.spinner', '#facebox').show();

            ajax_update('index.php?cmd=accountrelations&action=assign&x=' + Math.random(), $('#submitform').serializeObject(), function () {
                refresh_relations();
                $(document).trigger('close.facebox');
            });
        }

        $('#service_id_selector').chosenedge({width: '100%'});
    </script>
{/literal}


{else}

    <div class="panel" id="related-items-items">
        {if !$items}
            <em>There are no related services added yet</em>
        {else}
            <ul class="list-group" style="max-height:inherit;">
                <li class="list-group-item row no-gutter">
                    <div class="col-xs-1"><strong>Type</strong></div>
                    <div class="col-xs-1"><strong># ID</strong></div>
                    <div class="col-xs-3"><strong>{$lang.Domain}</strong></div>
                    <div class="col-xs-3"><strong>{$lang.Service}</strong></div>
                    <div class="col-xs-2"><strong>{$lang.price}</strong></div>
                    <div class="col-xs-1"><strong>{$lang.status}</strong></div>

                </li>
                {foreach from=$items item=f}
                    <li class="list-group-item row no-gutter">
                        <div class="col-xs-1">{$lang[$f.type]}</div>
                        <div class="col-xs-1">
                            <a href="?cmd={if $f.type=='Domain'}domains{else}accounts{/if}&action=edit&id={$f.id}"
                               target="_blank">{$f.id}</a>
                        </div>
                        <div class="col-xs-3">
                            <a href="?cmd={if $f.type=='Domain'}domains{else}accounts{/if}&action=edit&id={$f.id}"
                               target="_blank">{$f.domain}</a>
                        </div>
                        <div class="col-xs-3">{$f.product}</div>
                        {if $f.type=='Domain'}
                            {if $admindata.access.viewDomainsPrices}
                                <div class="col-xs-2">{$f.total|price:$client_currency}</div>
                            {else}
                                <div class="col-xs-2" style="padding-left: 12px;">-</div>
                            {/if}
                        {else}
                            {if $admindata.access.viewAccountsPrices}
                                <div class="col-xs-2">{$f.total|price:$client_currency}</div>
                            {else}
                                <div class="col-xs-2" style="padding-left: 12px;">-</div>
                            {/if}
                        {/if}
                        <div class="col-xs-1"><span class="{$f.status}">{$lang[$f.status]}</span></div>
                        <div class="col-xs-1 pull-right text-right">
                            <a href="?cmd=accountrelations&action=unassign&child_id={$f.id}&child_type={$f.type}&parent_id={$item_id}&parent_type={$item_type}"
                               title="{$lang.Delete}" class="item-delete" onclick="return unassignService(this);">
                                <i class="fa fa-times" style="color:red"></i>
                            </a>
                        </div>
                    </li>
                {/foreach}
            </ul>
        {/if}
    </div>
    <div class="service-task-list-actions">
        <!-- Single button -->
        <div class="btn-group">
            <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                    onclick="return assignNewService({$item_id},'{$item_type}',{$client_id})">
                Assign
            </button>
        </div>
    </div>
{literal}

    <script>
        function refresh_relations(){
            var url = {/literal}"?cmd=accountrelations&type={$item_type}&id={$item_id}"{literal};
            $.get(url, function(data){
                $('#related-items-items').html(
                    $(parse_response(data)).filter('#related-items-items').html()
                )
            });
        }

        function unassignService(el) {
            $('#related-items-items').addLoader();
            $.post($(el).attr('href'),function(){
                refresh_relations()
            });

            return false;
        }
        function assignNewService(item_id,item_type,client_id) {
            var dialog = bootbox.dialog({
                title: 'Select service to assign',
                message: '<div class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</div>',
                backdrop: true,
                onEscape: true,
                buttons: {
                    confirm: {
                        label: 'Assign this service',
                        className: 'btn-success',
                        callback: function(){
                            $('#related-items-items').addLoader();
                            $.post('?cmd=accountrelations&action=assign&', $('#submitform').serializeForm(), function () {
                                refresh_relations();
                            });
                        }
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-default'
                    }
                },
            })
            $.get("?cmd=accountrelations&action=getclientservices&item_id="
                + item_id + "&item_type=" + item_type +"&client_id="+client_id, function(data){
                $('.bootbox-body', dialog).html(parse_response(data));
            });

            return false;
        }
    </script>
{/literal}

{/if}