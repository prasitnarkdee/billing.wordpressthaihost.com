{include file="clientarea/top_nav.tpl" nav_type="billing"}

<section class="bordered-section article">
    {if $contracts_toaccept}
        <div class="d-flex flex-row justify-content-between align-items-center">
            <h2 class="mt-2 mb-3">{$lang.mycontractstoconfirm}</h2>
            <a href="{$ca_url}contracts/all/&accept=1&security_token={$security_token}" class="btn btn-sm btn-success ml-3" >{$lang.acceptallcontracts}</a>
        </div>
        <table class="table table-bordered table-striped ">
            <thead>
            <tr>
                <th width="60">ID</th>
                <th width="130">{$lang.date}</th>
                <th>{$lang.name}</th>
                <th width="100">{$lang.status}</th>
                <th width="70px"></th>
            </tr>
            </thead>
            <tbody>
            {include file='ajax.contracts.tpl' contracts=$contracts_toaccept accepted=false}
            </tbody>
        </table>
    {/if}

    <h2 class="mt-5 mb-3">{$lang.allcontracts}</h2>
    <a href="{$ca_url}contracts/all/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <input type="hidden" value="{$totalpages}" name="totalpages" id="totalpages">
    <table class="table table-bordered table-striped ">
        <thead>
        <tr>
            <th width="60"><a href="?cmd=contracts&action=all&orderby=number|ASC" class="sortorder">ID</a></th>
            <th width="130"><a href="?cmd=contracts&action=all&orderby=created_at|ASC" class="sortorder">{$lang.date}</a></th>
            <th><a href="?cmd=contracts&action=all&orderby=template_id|ASC" class="sortorder">{$lang.name}</a></th>
            <th><a href="?cmd=contracts&action=all&orderby=accepted_at|ASC" class="sortorder">  {$lang.contracts_accepted_date}</a></th>
            <th><a href="?cmd=contracts&action=all&orderby=accepted_by|ASC" class="sortorder">{$lang.contracts_accepted_by}</a></th>
            <th width="100"><a href="?cmd=contracts&action=all&orderby=status|ASC" class="sortorder">{$lang.status}</a></th>
            <th width="70px"></th>
        </tr>
        </thead>
        <tbody id="updater">
        {include file='ajax.contracts.tpl'}
        </tbody>
    </table>
    <div class="clear"></div>
    <div class="right p19 pt0">
        <div class="pagelabel left ">{$lang.page}</div>
        <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
            {section name=foo loop=$totalpages}
                <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
            {/section}
        </div>
        <input type="hidden" id="currentpage" value="0" />
    </div>
    <div class="clear"></div>



    <h2 class="mt-5 mb-3">{$lang.allagreements}</h2>
    <table class="table table-bordered table-striped ">
        <thead>
        <tr>
            <th>{$lang.name}</th>
            <th>{$lang.date}</th>
            <th width="70px"></th>
        </tr>
        </thead>
        <tbody>
            {foreach from=$agreements item=ct}
                <tr>
                    <td>{$ct.template_name}</td>
                    <td>{$ct.date|dateformat:$date_format}</td>
                    <td width="80">
                        <a target="_blank" href="?cmd=contracts&action=pdf_agreement&hash={$ct.hash}">{$lang.download}</a>
                    </td>
                </tr>
            {foreachelse}
                <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
            {/foreach}
        </tbody>
    </table>
</section>