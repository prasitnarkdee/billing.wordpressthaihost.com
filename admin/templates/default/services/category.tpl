<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="{if $action=='default'}active{/if} picked">
                <a href="?cmd=services"><span class="ico money">{$lang.orpages}</span></a>
            </li>
            <li class="{if $action=='category' || $action=='editcategory'}active{/if} picked">
                <a href="?cmd=services&action=category&id={$category.id}">
                    <span class="ico money">{$category.name}</span>
                </a>
            </li>
            {if $category.contains === 'categories'}
                <li class="{if $action=='product'}active{/if} last">
                    <a href="?cmd=services&action=product&id=new_category&parent_id={$category.id}">
                        <span class="ico formn">{$lang.addnewsubcategory}</span>
                    </a>
                </li>
            {else}
                <li class="{if $action=='product'}active{/if} last">
                    <a href="?cmd=services&action=product&id=new&cat_id={$category.id}">
                        <span class="ico formn">{$lang.addnewproduct}</span>
                    </a>
                </li>
            {/if}
        </ul>
    </div>
    <div class="list-2" style="min-height: 15px;">
        {if $action=='category' || $action=='editcategory'}
            <div class="subm1 haveitems">
                <ul>
                    <li>
                        <a href="?cmd=services&action=editcategory&id={$category.id}" onclick="return HBServices.editcat();">{$lang.editthisorpage}</a>
                    </li>
                    {if $category.visible==0}
                        <li>
                            <a href="?cmd=services&action=toggle&state=visible&id={$category.id}&security_token={$security_token}&redirect=cat">Show Category</a>
                        </li>
                    {elseif $category.visible==-1}
                        <li>
                            <a href="?cmd=services&action=toggle&state=visible&id={$category.id}&security_token={$security_token}&redirect=cat">Restore Category</a>
                        </li>
                    {else}
                        <li>
                            <a href="?cmd=services&action=toggle&state=hide&id={$category.id}&security_token={$security_token}&redirect=cat">Hide Category</a>
                        </li>
                        <li>
                            <a href="?cmd=services&action=toggle&state=archive&id={$category.id}&security_token={$security_token}&redirect=cat">Archive Category</a>
                        </li>
                    {/if}
                    <li>
                        <a href="#archived" onclick="return HBServices.showArcived(), false">
                            {if $category.contains !== 'categories'}
                                Show Archived Products
                            {else}
                                Show Archived Sub-categories
                            {/if}
                            <span id="count_archived"></span>
                        </a>
                    </li>

                </ul>
            </div>
        {/if}
    </div>
</div>
<div class="nicerblu">
    <div id="cinfo1" {if $action!='editcategory'}style="display:none"{/if}>
        {include file="services/category_add_edit.tpl"}
    </div>
    <span class="tag-filter-container"></span>
    <a class="tag-filter-reset none btn btn-xs btn-primary" href="#">Show all</a>
</div>

{if $category.contains === 'categories'}
    {include file="services/subcategories.tpl"}
{else}
    {if $products}
        <form id="serializeit">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tbody>
                <tr>
                    <th width="20"></th>
                    <th>{$lang.Name}</th>
                    {if $category.ptype != 'DomainsType'}
                        <th width="130">{$lang.Accounts}</th>
                        <th width="100">{$lang.stockcontrol}</th>
                    {else}
                        <th width="130">{$lang.Domains}</th>
                    {/if}
                    <th width="180"></th>
                    <th width="150">&nbsp;</th>
                </tr>
                </tbody>
            </table>
            <ul id="grab-sorter" style="width:100%">
                {include file='services/ajax.category.tpl'}
            </ul>
            <div class="blu">
                {if $category.contains === 'categories'}
                    <a class="btn btn-success btn-sm" href="?cmd=services&action=category&id=new_category&cat_id={$category.id}">{$lang.addnewcategory}</a>
                {else}
                    <a class="btn btn-success btn-sm" href="?cmd=services&action=product&id=new&cat_id={$category.id}">{$lang.addnewproduct}</a>
                    <a class="btn btn-default btn-sm import-product">Import product</a>
                    <a class="btn btn-default btn-sm bulk-update" href="?cmd=services&action=bulkupdate&cat_id={$category.id}">Bulk update</a>
                {/if}
                {*}<a class="btn btn-default btn-sm" href="?cmd=services&action=updateprices&cat_id={$category.id}">Bulk update</a>
                <a class="btn btn-default btn-sm" href="?cmd=services&action=updatetags&cat_id={$category.id}">Bulk tags update</a>{*}
            </div>

            {securitytoken}
        </form>
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                {if $category.contains === 'categories'}
                    <h1>{$lang.orpage_blank_cats}</h1>
                {else}
                    <h1>{$lang.orpage_blank2}</h1>
                {/if}
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            {if $category.contains === 'categories'}
                                <a class="btn btn-success" href="?cmd=services&action=addcategory&parent_id={$category.id}">{$lang.addnewcategory}</a>
                            {else}
                                <a class="btn btn-success" href="?cmd=services&action=product&id=new&cat_id={$category.id}" >{$lang.addnewproduct}</a>
                                <a class="btn btn-default import-product">Import product</a>
                            {/if}
                        </td>
                        <td></td>
                    </tr>
                </table>
                <div class="clear"></div>
            </div>
        </div>
    {/if}

    <div id="import-product" hidden bootbox data-title="Import product" data-btnclass="btn-primary">
        <form action="?cmd=services&action=productimport&category_id={$category.id}" method="post" enctype="multipart/form-data">
            <p>Select a file with product configuration that you want to import.</p>
            <input type="file" name="import" value="{$client.id}"/>
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="hide" value="1" checked />
                    Import as hidden product
                </label>
            </div>
            {securitytoken}
        </form>
    </div>
{/if}