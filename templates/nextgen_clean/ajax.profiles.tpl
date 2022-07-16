{if $action=='preview'}
    {$profile.firstname} {$profile.lastname}<br />
    {if $profile.companyname!=''}{$profile.companyname}<br />{/if}
    {if $profile.address1!=''}{$profile.address1}<br />{/if}
    {if $profile.address2!=''}{$profile.address2}<br />{/if}
    {if $profile.city!=''}{$profile.city}, {/if}
    {if $profile.state!=''}{$profile.state}, {/if}
    {if $profile.postcode!=''}{$profile.postcode}<br />{/if}
    {if $profile.country2!=''}{$profile.country2}<br />{/if}
    {$profile.email}<br />
{else}
    {foreach from=$profiles item=p name=ff}
        <tr class="{if $smarty.foreach.ff.index%2==0}even{/if}">
            <td align="center">{$p.email}</td>
            <td>{$p|@client}</td>
            <td>{$p.status}</td>
            <td align="center">
                {if !$p.lastlogin || $p.lastlogin === '0000-00-00 00:00:00'}-
                {else}{$p.lastlogin|dateformat:$date_format}{/if}
            </td>
            <td>
                <div class="btn-group">
                    <a href="{$ca_url}profiles/{$p.edit_url}/" class="btn dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-cog"></i> <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="{$ca_url}profiles/{$p.edit_url}/">{$lang.editcontact}</a></li>
                        {if $p.parent_id == $login.id}
                        <li><a href="{$ca_url}profiles/loginascontact/{$p.id}/">{$lang.loginascontact}</a></li>
                        {/if}
                        <li>
                            <a href="{$ca_url}profiles/delete/{$p.id}&security_token={$security_token}"
                               onclick="return confirm('{$lang.areyousuredelete}');" style="color:red">
                                {$lang.delete}
                            </a>
                        </li>
                    </ul>
                </div>
            </td>
        </tr>
    {/foreach}
{/if}