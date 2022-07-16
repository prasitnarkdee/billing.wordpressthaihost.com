{foreach from=$products item=prod name=prods}
    <li class="{if $prod.visible=='0'}ishidden{/if} {if $prod.visible==-1}archived{/if} entry" id="entry{$prod.id}" data-tags="{foreach from=$prod.tags item=tag}{$tag},{/foreach}">
        <div>
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tr  class="havecontrols">
                    <td width="20" class="name">
                        {if $priceup}
                            <input type="checkbox" name="product[{$prod.id}]" value="{$prod.id}" class="product_check"/>
                        {else}
                            <input type="hidden" name="sort[]" value="{$prod.id}" />
                            <div class="controls">
                                <a class="sorter-handle" >{$lang.move}</a>
                            </div>
                        {/if}
                    </td>
                    <td >
                        <a href="?cmd=services&action=product&id={$prod.id}">
                            {if $prod.visible==1}{$prod.name}
                            {else}<em class="ishidden">{$prod.name} </em>
                            {/if}
                        </a> 
                        {if $prod.visible=='0'}
                            <em class="ishidden fs11">{$lang.hidden}</em>
                        {elseif $prod.visible==-1}
                            <em class="ishidden archived fs11">Archived</em>
                        {elseif $prod.visible==-2}
                            <em class="adminonly fs11">Admin-only</em>

                        {/if}
                        <div class="right inlineTags">
                            {foreach from=$prod.tags item=tag}
                                <span>{$tag}</span>
                            {/foreach}
                        </div>
                    </td>
                    <td width="130" align="center" class="server-acc-stats">
                        {if $category.ptype == 'DomainsType' && $prod.stats.total}
                            <a title="Pending" target="_blank" href="?cmd=domains&filter[tld_id]={$prod.id}&filter[status]=Pending&resetfilter=1">
                                <span class="Pending">{$prod.stats.pending}</span>
                            </a> /
                            <a target="_blank" title="Registered" href="?cmd=domains&filter[tld_id]={$prod.id}&filter[status][]=Active&resetfilter=1">
                                <span class="Active">{$prod.stats.provisioned}</span>
                            </a> /
                            <a target="_blank" title="Pending Registration / Pending Transfer" href="?cmd=domains&filter[tld_id]={$prod.id}&filter[status][]=Pending Transfer&filter[status][]=Pending Registration&resetfilter=1">
                                <span class="Pending-Registration">{$prod.stats.suspended}</span>
                            </a> /
                            <a target="_blank" title="Cancelled" href="?cmd=domains&filter[tld_id]={$prod.id}&filter[status][]=Cancelled&filter[status][]=Fraud&resetfilter=1">
                                <span class="Cancelled">{$prod.stats.cancelled}</span>
                            </a> /
                            <a target="_blank" title="Expired" href="?cmd=domains&filter[tld_id]={$prod.id}&filter[status][]=Expired&filter[status][]=Terminated&resetfilter=1">
                                <span class="Expired">{$prod.stats.terminated}</span>
                            </a>
                        {elseif $prod.stats.total}
                            <a title="Pending" target="_blank" href="?cmd=accounts&filter[product_id]={$prod.id}&filter[status]=Pending&resetfilter=1" >
                                <span class="Pending">{$prod.stats.pending}</span>
                            </a> /
                            <a target="_blank" title="Active" href="?cmd=accounts&filter[product_id]={$prod.id}&filter[status][]=Active&resetfilter=1" >
                                <span class="Active">{$prod.stats.provisioned}</span>
                            </a> /
                            <a target="_blank" title="Suspended" href="?cmd=accounts&filter[product_id]={$prod.id}&filter[status][]=Suspended&resetfilter=1" >
                                <span class="Suspended">{$prod.stats.suspended}</span>
                            </a> /
                            <a target="_blank" title="Cancelled" href="?cmd=accounts&filter[product_id]={$prod.id}&filter[status][]=Cancelled&filter[status][]=Fraud&resetfilter=1" >
                                <span class="Cancelled">{$prod.stats.cancelled}</span>
                            </a> /
                            <a target="_blank" title="Terminated" href="?cmd=accounts&filter[product_id]={$prod.id}&filter[status][]=Terminated&resetfilter=1" >
                                <span class="Terminated">{$prod.stats.terminated}</span>
                            </a>
                        {else}
                            0
                        {/if}


                    </td>
                    {if $category.ptype != 'DomainsType'}
                        <td width="90" class="server-acc-stats">
                            {if $prod.hasStock}
                                {$lang.stock}
                                {if $prod.stockStatus === 'Good'}
                                    <span title="Number of used accounts" class="Active"> {$prod.qty}</span>
                                {elseif $prod.stockStatus === 'Low'}
                                    <span class="fa fa-warning Suspended"
                                       title="Number of available items is below {$prod.stockLow}"></span>
                                    <span title="Number of used accounts"
                                          class="Suspended"> {$prod.qty}</span>
                                {else}
                                    <span class="fa fa-warning Pending" title="Product is Out of Stock"></span>
                                    <span title="Number of used accounts" class="Pending"> {$prod.qty}</span>
                                {/if}
                                / <span title="Total available accounts">{$prod.stock}</span>
                            {else}
                                <span class="smaller">-</span>
                            {/if}
                        </td>
                    {/if}

                    <td style="width: 180px; text-align: right">
                        {if $prod.visible=='0'}
                            <a href="?cmd=services&action=toggle&state=visible&id={$prod.id}&cat={$category.id}&security_token={$security_token}" 
                               class="menuitm menu-auto ajax" style="min-width: 30px; text-align: center">{$lang.Show}</a>
                        {elseif $prod.visible=='-1'}
                            <a href="?cmd=services&action=toggle&state=visible&id={$prod.id}&cat={$category.id}&security_token={$security_token}" 
                               class="menuitm menu-auto ajax" style="min-width: 30px; text-align: center">Restore</a>

                        {elseif $prod.visible=='-2'}
                            <a href="?cmd=services&action=toggle&state=visible&id={$prod.id}&cat={$category.id}&security_token={$security_token}"
                               class="menuitm menu-auto ajax" style="min-width: 30px; text-align: center">Restore</a>
                        {else}
                            <a href="?cmd=services&action=toggle&state=archive&id={$prod.id}&cat={$category.id}&security_token={$security_token}" 
                               class="menuitm menu-auto ajax" >Archive</a>

                            {if $category.ptype != 'DomainsType'}<a href="?cmd=services&action=toggle&state=adminonly&id={$prod.id}&cat={$category.id}&security_token={$security_token}"
                               class="menuitm menu-auto ajax" >Admin-only</a>
                            {/if}

                            <a href="?cmd=services&action=toggle&state=hide&id={$prod.id}&cat={$category.id}&security_token={$security_token}" 
                               class="menuitm menu-auto ajax" >{$lang.Hide}</a>
                        {/if}
                    </td>

                    <td style="width: 150px; text-align: right">
                        <a class="menuitm menu-auto" href="?cmd=services&action=product&id={$prod.id}" class="editbtn"><span style="color: red">{$lang.Edit}</span></a>
                        <a class="menuitm menu-auto" href="?cmd=services&amp;make=duplicate&id={$prod.id}&security_token={$security_token}">{$lang.Duplicate}</a>                           
                        <a class="menuitm menu-auto ajax" href="?cmd=services&make=deleteproduct&id={$prod.id}&cat_id={$category.id}&security_token={$security_token}" 
                           onclick="return confirm('{$lang.deleteproductconfirm}');"><span class="delsth"></span></a> 
                    </td>
                </tr>
            </table>
        </div>
    </li>
{/foreach}