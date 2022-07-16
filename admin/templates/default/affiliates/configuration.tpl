{literal}
<script type="text/javascript">
    $(function () {
        $('#newshelfnav').TabbedMenu({elem:'.sectioncontent', picker:'.list-1 li:not(.direct)', aclass:'active'{/literal}{if $pickedtab}, picked:'{$pickedtab}'{/if}{literal}});
        $('#newshelfnav').TabbedMenu({elem:'.navsubmenu', picker:'.list-1 li:not(.direct)', aclass:'active'{/literal}{if $pickedtab}, picked:'{$pickedtab}'{/if}{literal}});
        $('.toggle-box').on('click update', function () {
            var self = $(this);
            if (self.is(':checked'))
                    self.next().prop('disabled', false)
            else
                self.next().prop('disabled', true)
        }).trigger('update');

        $('#multiplans').on('change update', function () {
            var multi = $(this).is(':checked'),
                    def = $('#defaultplans');
            def.prop('multiple', multi).children(':first').toggle(multi);
        }).trigger('update')
    });
</script>
{/literal}
<form action="" method="post" id="testform">
    {include file="affiliates/configuration_header.tpl"}

    <table width="100%" cellspacing="0" cellpadding="10" border="0">
        <tbody class="sectioncontent cpadding">
            <tr class="bordme">
                <td align="right" width="25%"><strong>{$lang.enableaff}:</strong></td>
                <td>
                    <input type="checkbox" {if $configuration.EnableAffiliates=='on'}checked="checked"{/if} value="1" name="EnableAffiliates"/>
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">Show refered customer data in affiliate panel:</td>
                <td>
                    <input type="checkbox" {if $configuration.AffShowReffered=='on'}checked="checked"{/if} value="1" name="AffShowReffered"/>
                </td>
            </tr>

            <tr class="bordme">
                <td align="right">Allow multiple commision plans:</td>
                <td>
                    <input type="checkbox" {if $configuration.AffMultiplePlans}checked="checked"{/if} value="1" name="AffMultiplePlans" id="multiplans"/>
                </td>
            </tr>

            <tr class="bordme">
                <td align="right" style="vertical-align: top; line-height: 25px">Default comission plans for new affiliates:</td>
                <td>
                    <select name="AffDefaultPlan[]" class="inp" {if $configuration.AffMultiplePlans}multiple{/if} id="defaultplans">
                        <option value="" {if !$configuration.AffDefaultPlan}selected{/if} >All Commission plans</option>
                        {foreach from=$commisions item=plan}
                            <option value="{$plan.id}" {if $plan.id|in_array:$configuration.AffDefaultPlan}selected{/if} >{$plan.name}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            <tr class="bordme">
                <td align="right">{$lang.AffBonus}:</td>
                <td>
                    <input size="3" name="AffBonus" value="{$configuration.AffBonus}" class="inp currency"/> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}
                    <input type="checkbox" {if $configuration.AffAutoWithBonus}checked="checked"{/if} value="1" name="AffAutoWithBonus"/> Auto-withdraw bonus to credit.
                </td>
            </tr>

            <tr class="bordme">
                <td align="right">{$lang.AffCookieDays}:
                    <a class="vtip_description" title="{$lang.AffCookieDaysDescr}"></td>
                <td>
                    <input size="3" name="AffCookieDays" value="{$configuration.AffCookieDays|default:60}" class="inp"/>
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">{$lang.AffDelay}:</td>
                <td>
                    <input size="3" name="AffDelay" value="{$configuration.AffDelay}" class="inp"/>
                    <input type="checkbox" name="AffCheckServices" {if $configuration.AffCheckServices}checked="checked"{/if} value="1" /> Accept only if all services related to referred order are active.
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">{$lang.AffMinWid}: </td>
                <td><input size="3" name="AffMinWid" value="{$configuration.AffMinWid}" class="inp currency"/> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</td>
            </tr>
            <tr class="bordme">
                <td align="right">
                    Auto-withdrawals account credit commissions over:
                    <a class="vtip_description" title="Automatically create a withdrawal as account credit for affiliates that selected that method"></a>
                </td>
                <td>
                    <input type="checkbox" {if $configuration.AffAutoPayInCredit}checked="checked"{/if} class="toggle-box"/>
                    <input size="3" name="AffAutoPayInCredit" value="{$configuration.AffAutoPayInCredit}" class="inp currency"/> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">
                    Auto-add to check queue commissions over:
                    <a class="vtip_description" title="Automatically creates an entry in withdrawal queue for affiliates that selected this method"></a>
                </td>
                <td>
                    <input type="checkbox" {if $configuration.AffAutoPayByCheck}checked="checked"{/if} class="toggle-box"/>
                    <input size="3" name="AffAutoPayByCheck" value="{$configuration.AffAutoPayByCheck}" class="inp currency"/> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">Default auto-withdrawal option
                    <a class="vtip_description" title="Disabled - client would need to request for withdraw manually.<br/>
                       Credit - if enabled above, auto-add credit<br/>
                       Check - if enabled above, add to check queue.">
                </td>
                <td>
                    <select name="AffAutoWithOption" class="inp">
                        <option value="0" {if !$configuration.AffAutoWithOption}selected="selected"{/if}>Disabled </option>
                        <option value="2" {if $configuration.AffAutoWithOption=='2'}selected="selected"{/if}>Credit </option>
                        <option value="1" {if $configuration.AffAutoWithOption=='1'}selected="selected"{/if}>Check </option>
                    </select>
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">
                    Multi-Level Affiliates
                    <a class="vtip_description" title="Affiliates referred by another affiliate establish a relation in which % amount of commission gained by sub-affiliate can be acquired by referring affiliate."></a>
                </td>
                <td>
                    <input type="checkbox" {if $configuration.AffMultiLevel}checked="checked"{/if} class="toggle-box"/>
                    Add <input size="3" name="AffMultiLevel" value="{$configuration.AffMultiLevel}" class="inp"/> % of sub-affiliate commissions to parent affiliate<br />
                    <input type="checkbox"  name="AffMultiLevelCut" {if $configuration.AffMultiLevelCut=='on'}checked="checked"{/if} value="1" class="inp"/>
                    Subtract from sub-affiliate commission
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">Promotion codes commission calculation
                    <a class="vtip_description" title="Select how commision from sale should be calculated if customer use staff-created promo code on referred order. <br>
                       <b>After discount</b>: affiliate will receive commission calculated from discounted order total<br />
                       <b>Before discount</b>: affiliate will receive commission calculated from order total without discount calculated">
                </td>
                <td>
                    <select name="AffPromoCalc" class="inp">
                        <option value="0" {if !$configuration.AffPromoCalc}selected="selected"{/if}> After discount </option>
                        <option value="1" {if $configuration.AffPromoCalc == 1}selected="selected"{/if}> Before discount </option>
                    </select>
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">Affiliate vouchers audience <a class="vtip_description" title="Select who can use vouchers created by affiliate"></td>
                <td>
                    <select name="AffVAudience" class="inp">
                        <option value="0" {if !$configuration.AffVAudience}selected="selected"{/if}> New clients only </option>
                        <option value="1" {if $configuration.AffVAudience == 1}selected="selected"{/if}> All clients </option>
                    </select>
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">Check voucher cookie</td>
                <td>
                    <input type="checkbox" name="AffVCookie" value="1"
                           {if $configuration.AffVCookie}checked="checked"{/if} />
                    <span class="help-inline">
                        When enabled only clients referred from affiliate link will be able to use their voucher
                    </span>
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">Assign client to affiliate</td>
                <td>
                    <input type="checkbox" {if $configuration.AffAssignClient}checked{/if}
                           name="AffAssignClient" value="1"/>
                    Referred clients will be assigned to affiliate automatically after sign-up.
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">{$lang.AffLandingPage} <a class="vtip_description" title="{$lang.afflandingpage_desc}"></a></td>
                <td>
                    <input style="width:500px" name="AffLandingPage" value="{$configuration.AffLandingPage}" class="inp"/>
                </td>
            </tr>
            <tr class="bordme">
                <td align="right">{$lang.AffSignupPage}</td>
                <td>
                    <input style="width:500px" value="{$configuration.AffSingup}" readonly="readonly" class="inp"/>
                </td>
            </tr>
            <tr class="bordme">
                <td ></td>
                <td >
                    {$lang.AffIntegration}:<br />
                    <textarea style="width:500px;height:150px;" name="AffIntegration">{$configuration.AffIntegration}</textarea>
                </td>
            </tr>
            <tr class="bordme">
                <td></td>
                <td>
                    {include file="affiliates/_banners.tpl"}
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding:0">
                    <div class="blu">
                        <input type="submit" value="{$lang.savechanges}" class="btn btn-primary" name="savechanges"/>
                    </div>
                </td>
            </tr>
        </tbody>
        <tbody class="sectioncontent" style="display:none">
            <tr>
                <td colspan="2">
                    {if $commisions}
                        <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
                        <br />
                        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                            <tbody>
                                <tr>
                                    <th width="20"><input type="checkbox" id="checkall"/></th>
                                    <th><a href="?cmd={$cmd}&action={$action}&orderby=id|ASC" class="sortorder">ID</a></th>
                                    <th><a href="?cmd={$cmd}&action={$action}&orderby=name|ASC"  class="sortorder">{$lang.Name}</a></th>
                                    <th><a href="?cmd={$cmd}&action={$action}&orderby=rate|ASC"  class="sortorder">{$lang.commission}</a></th>
                                    <th style="width:40%"><a href="?cmd={$cmd}&action={$action}&orderby=notes|ASC"  class="sortorder">{$lang.notes}</a></th>
                                </tr>
                            </tbody>

                            <tbody id="updater">
                                {include file='ajax.affiliates.tpl'}
                            </tbody>

                            <tbody id="psummary">
                                <tr>
                                    <th></th>
                                    <th colspan="9">
                                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                                    </th>
                                </tr>
                            </tbody>
                        </table>
                        <div class="blu"></div>
                    {else}
                        <div class="blank_state blank_services">
                            <div class="blank_info">
                                <h1>{$lang.commission_plans}</h1>
                                {$lang.commission_plans_blank}
                                <div class="clear"></div>
                                <a style="margin-top:10px" href="?cmd={$cmd}&action=commision&make=add" class="new_add new_menu">
                                    <span>{$lang.addcommision}</span>
                                </a>
                                <div class="clear"></div>
                            </div>
                        </div>
                    {/if}
                </td>
            </tr>
        </tbody>
    </table>
    {securitytoken}
</form>