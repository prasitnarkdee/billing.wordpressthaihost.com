{literal}
    <style>
        .client-settings {
            columns: 2 200px;
        }

        .client-setting-row {
            display: flex;
            align-items: center;
            color: #777;
            break-inside: avoid;
        }
        .client-setting-row strong {
            color: #333;
        }

        .client-setting-row.text-center {
            justify-content: center;
        }

        .client-setting-row > div {
            width: 50%;
            margin: 3px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .client-setting-title {
            text-align: right;
            flex-shrink: 0;
        }

        .client-setting-edit select,
        .client-setting-edit input {
            max-width: 100%;
        }
    </style>
{/literal}
<div class="client-settings">
    {foreach from=$settings item=option}
        {if $option.selected && $option.allow_admin_edit}
            <div class="client-setting-row">
                <div class="client-setting-title">
                    {$option.title}:
                </div>
                <div class="client-setting-value ">
                    {if $option.type == 'checkbox'}
                        {foreach from=$option.items item=item}
                            <span style="margin-right: 5px" class="label {if $option.override==='client'}label-danger-invert{elseif $option.override==='group'}label-warning-invert{else}label-default-invert{/if}">
                                {$item.title|ucfirst}
                            </span>
                        {/foreach}
                    {else}
                        <span class="label {if $option.override==='client'}label-danger-invert{elseif $option.override==='group'}label-warning-invert{else}label-default-invert{/if}">
                            {$option.selected.title|ucfirst}
                            {if $option.name == 'taxrateoverride' && $option.override} {$client.taxrate}%{/if}
                        </span>
                        {if $option.selected.description}
                            <a class="vtip_description" title="{$option.selected.description|escape|ucfirst}"></a>
                        {/if}
                    {/if}
                </div>
            </div>
        {/if}
    {/foreach}
</div>

