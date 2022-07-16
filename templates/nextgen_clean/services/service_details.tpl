{include file="services/service_upgrades.tpl"}




{if $custom_template}
	{include file=$custom_template}
{elseif $widget.replacetpl}
{include file=$widget.replacetpl}

{else}


<div class="header-title">
            {if $service.domain!=''}{$service.domain}{/if}
            <h2>{$service.name}</h2>
            <a href="{$ca_url}clientarea/services/{$service.slug}/" class="btn btn-mini backbtn"><i class="icon-chevron-left"></i></a>
        </div>
<div class="row flex-container bordered-section">
 
    <div class="span3 left-content flex-box-1">
        
        {include file='services/service_sidemenu.tpl'}
    </div>


    <div class="span9 right-content flex-box-1">

        

        <div class="brcrm">
            <ul class="breadcrumb left">
                <li><a href="{$ca_url}clientarea/"><strong>{$lang.clientarea}</strong></a> <span class="divider">/</span></li>
                <li><a href="{$ca_url}clientarea/services/{$service.slug}/"><strong>{$service.catname}</strong></a> <span class="divider">/</span></li>

                {if $widget} <li><a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/"><strong>{$service.name}</strong></a>  <span class="divider">/</span></li>
                <li class="active">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</li>{else}
                <li class="active">{$service.name}</li>{/if}
            </ul>


            <div class="clear"></div>
        </div>



        {if $widget.appendtpl }
        <div class="p19">
            {include file=$widget.appendtpl}
        </div>
        {else}
      
        {include file='services/service_billing2.tpl'}

          {if $custom_clientarea}
             {include file=$custom_clientarea}
        {/if}

        {if $service.isvpstpl  }

        {include file="services/services.vps.tpl"}

	  {elseif $service.isvps && !$service.isvpstpl}
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table table-striped fullscreen">

            {if $service.bw_limit!='0'}
            <tr class="even">
                <td align="right">{$lang.bandwidth}</td>
                <td>{$service.bw_limit} {$lang.gb}</td>
            </tr>
            {/if} {if $service.disk_limit!='0'}
            <tr>
                <td align="right">{$lang.disk_limit}</td>
                <td>{$service.disk_limit} {$lang.gb}</td>
            </tr>
            {/if}
            {if $service.guaranteed_ram!='0'}
            <tr class="even">
                <td align="right">{$lang.memory}</td>
                <td>{$service.guaranteed_ram} {$lang.mb}</td>
            </tr>   {/if}
            {if $service.burstable_ram!='0'}
            <tr>
                <td align="right">{$lang.burstable_ram}</td>
                <td>{$service.burstable_ram}  {$lang.mb}</td>
            </tr>   {/if}

            {if $ipam_ips}
                {foreach from=$ipam_ips.servers item=serv}
                    <tr>
                        <td width="30%" valign="top"><strong>{$lang.ips}</strong></td>
                        <td width="70%">
                            <table style="width: 100%;">
                                <tr>
                                    <td><b>{$lang.ip_subnet}:</b></td>
                                    <td>{$serv.subnet}</td>
                                </tr>
                                <tr>
                                    <td><b>{$lang.ip_gateway}:</b> </td>
                                    <td>{$serv.gateway}</td>
                                </tr>
                                <tr>
                                    <td><b>{$lang.main_ip}:</b></td>
                                    <td>{if $serv.main_ip}{$serv.main_ip}{else}{$ipam_ips.main_ip}{/if}</td>
                                </tr>
                                <tr>
                                    <td><b>{$lang.additionalip}:</b></td>
                                    <td>{foreach from=$serv.ips_ranges item=ip}{$ip}<br />{/foreach}</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                {/foreach}
            {else}
                <tr>
                    <td><strong>{$lang.ipadd}</strong></td>
                    <td>{if $service.vpsip}{$service.vpsip}{else}{$service.ip}{/if}</td>
                </tr>
                {if $service.additional_ip}
                    <tr>
                        <td valign="top" ><strong>{$lang.additionalip}</strong></td>
                        <td>{foreach from=$service.additional_ip item=ip}{$ip}<br />{/foreach}</td>
                    </tr>
                {/if}
            {/if}
        </table>
        {/if}


        {include file='services/service_forms.tpl'}






	{if $addons || $haveaddons}
        <div class="p19">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#">{$lang.accaddons|capitalize}</a></li>
            </ul>


            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table table-striped table-condensed">
                <colgroup class="firstcol"></colgroup>
                <colgroup class="alternatecol"></colgroup>
                <colgroup class="firstcol"></colgroup>
                <colgroup class="alternatecol"></colgroup>

                <tbody>
                    <tr>
                        <th width="40%" align="left">{$lang.addon}</th>
                        {if $service.showbilling} <th align="left">{$lang.price}</th>
                        <th>{$lang.nextdue}</th>
                        <th >{$lang.status}</th>{/if}

                    </tr>
	{foreach from=$addons item=addon name=foo}
                    <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
                        <td>{$addon.name} {if $addon.info && $addon.status == 'Active'}<a href="" onclick="showAddonInfo(this,{$addon.id}); return false;" style="color: red; font-size: 11px">{$lang.moreinfo}</a>{/if}</td>
                        {if $service.showbilling}<td>{$addon.recurring_amount|price:$currency}</td>
                        <td align="center">{$addon.next_due|dateformat:$date_format}</td>
                        <td align="center" ><span class="label label-{$addon.status}">{$lang[$addon.status]}</span></td>{/if}

                    </tr>
                    {if $addon.info && $addon.status == 'Active'}
                    <tr class="addoninfo_r{$addon.id} {if $smarty.foreach.foo.index%2 == 0} even{/if}" style="display:none">
                        <td colspan="4"> <div style="padding: 10px">
                                {$addon.info|replace:'"':"'"|nl2br}</div>
                        </td>
                    </tr>
                    {/if}
                    {foreachelse}
                    <tr><td colspan="4">{$lang.nothing}</td></tr>
	{/foreach}
                </tbody>

            </table>

            {if $service.status!='Fraud' && $service.status!='Cancelled' && $service.status!='Terminated'}{$service.id|string_format:$lang.clickaddaddons}{/if}



        </div>
            {/if}


        {/if}



    </div>

</div>
{/if}

{literal}

<script type="text/javascript">
    function showAddonInfo(elem,id) {
        if($('.addoninfo_r'+id).hasClass('shown')) {
            $('.addoninfo_r'+id).removeClass('shown').hide();
            $(elem).html('{/literal}{$lang.moreinfo}{literal}');}
    else {
        $('.addoninfo_r'+id).addClass('shown').show();
        $(elem).html('{/literal}{$lang.hide}{literal}');
    }
}
</script>            {/literal}