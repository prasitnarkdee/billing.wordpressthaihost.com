<h3>{$lang.privileges}</h3>
<b>{$lang.premadepriv}</b>
<a href="#None" onclick="return loadProfile($(this).attr('rel'))" rel="{$p.file}"
   class="label label-info">{$lang.none}</a>
{foreach from=$premade item=p}
    <a href="#{$p.lang}" rel="{$p.file}" onclick="return loadProfile($(this).attr('rel'))"
       class="label label-info">{*
        *}{if $lang[$p.lang]}{$lang[$p.lang]}{else}{$p.name}{/if}{*
    *}</a>
{/foreach}

<div class="clear"></div>

<div class="right" style="margin-bottom:20px"></div>
<div class="clear"></div>
<div>
    {foreach from=$privilages item=privs key=group}
        {foreach from=$privs item=privopt}
            {if !$privopt.displaygroup || $privoptdisplaygroup==group}
                {assign value=1 var=displaythis}
            {/if}
        {/foreach}
        {if $displaythis!=1}{break}{/if}
        <h4>
            <input type="checkbox" class="privilege " id="{$group}_main"
                   onclick="cUnc(this,'{$group}')"/><span for="{$group}_main">
                {assign value="`$group`_main" var=groupmain}{$lang[$groupmain]}
            </span>
        </h4>
        <div class="pgroup mb20">

            {foreach from=$privs item=privopt key=priv name=loop}
                {if $privopt.condition && !$privopt.condition|checkcondition}{continue}{/if}
                <div>
                    <input type="checkbox" class="privilege {$group}" id="{$group}_{$priv}"
                           value="1" name="privileges[{$group}][{$priv}]"
                           {if $submit.privileges.$group.$priv}checked{/if} />
                    <span for="{$group}_{$priv}" {if $privopt.important}style="color:red"{/if}>
                        {assign value="`$group`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                    </span>
                </div>
            {/foreach}
            {assign value=0 var=displaythis}
            {foreach from=$privilages item=privs2 key=group2}
                {foreach from=$privs2 item=privopt key=priv name=loop}
                    {if $privopt.displaygroup == $group && (!$privopt.condition || $privopt.condition|checkcondition)}
                        <div>
                            <input type="checkbox" class="privilege {$group2}" id="{$group2}_{$priv}" value="1"
                                   name="privileges[{$group2}][{$priv}]"
                                   {if $submit.privileges.$group2.$priv}checked{/if} />
                            <span for="{$group2}_{$priv}" {if $privopt.important}style="color:red"{/if}>
                                {assign value="`$group2`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                            </span>
                        </div>
                    {/if}
                {/foreach}
            {/foreach}
        </div>
    {/foreach}

    <div id="priv_serv" {if $submit.privileges.services.full}style="display:none"{/if}>
        {foreach from=$services item=o}
            <h4>
                <input type="checkbox" class="privilege " id="smain_{$o.id}"
                       onclick="cUnc(this,'s{$o.id}')"/>
                <span for="smain_{$o.id}">
                    {$o.catname} - {$o.name} {if $o.domain}<em>( {$o.domain} )</em>{/if}
                    {if $o.label}<i class="label label-default">{$o.label}</i>{/if}
                </span>
            </h4>
            <div class="pgroup mb20">
                <div>
                    <input type="checkbox" class="privilege s{$o.id} services"
                           id="services_{$o.id}_basic" value="1"
                           name="privileges[services][{$o.id}][basic]"
                           {if $submit.privileges.services[$o.id].basic}checked{/if}/>
                    <span for="services_{$o.id}_basic">{$lang.services_basic}</span>
                </div>
                <div>
                    <input type="checkbox" class="privilege  s{$o.id} services"
                           id="services_{$o.id}_billing" value="1"
                           name="privileges[services][{$o.id}][billing]"
                           {if $submit.privileges.services[$o.id].billing}checked{/if}/>
                    <span for="services_{$o.id}_billing">{$lang.services_billing}</span>
                </div>
                <div>
                    <input type="checkbox" class="privilege  s{$o.id} services"
                           id="services_{$o.id}_cancelation" value="1"
                           name="privileges[services][{$o.id}][cancelation]"
                           {if $submit.privileges.services[$o.id].cancelation}checked{/if} />
                    <span for="services_{$o.id}_cancelation">{$lang.services_cancelation}</span>
                </div>

                <div>
                    <input type="checkbox" class="privilege s{$o.id} services"
                           id="services_{$o.id}_upgrade" value="1"
                           name="privileges[services][{$o.id}][upgrade]"
                           {if $submit.privileges.services[$o.id].upgrade}checked{/if}/>
                    <span for="services_{$o.id}_upgrade">{$lang.services_upgrade}</span>
                </div>
                <div>
                    <input type="checkbox" class="privilege s{$o.id} services"
                           id="services_{$o.id}_notify" value="1"
                           name="privileges[services][{$o.id}][notify]"
                           {if $submit.privileges.services[$o.id].notify}checked{/if}/>
                    <span for="services_{$o.id}_notify">{$lang.services_notify}</span>
                </div>
                {if $o.widgets}
                    {foreach from=$o.widgets item=w name=wl}
                        <div>
                            <input type="checkbox" class="privilege s{$o.id} services"
                                   id="services_{$o.id}_{$w.name}" value="1"
                                   name="privileges[services][{$o.id}][{$w.name}]"
                                   {if $submit.privileges.services[$o.id][$w.name]}checked{/if}/>
                            <span for="services_{$o.id}_{$w.name}">
                                {assign var=widg_name value="`$w.name`_widget"}
                                {if $lang[$widg_name]}{$lang[$widg_name]}
                                {elseif $lang[$w.name]}{$lang[$w.name]}
                                {elseif $w.fullname}{$w.fullname}
                                {else}{$w.name}{/if}
                            </span>
                        </div>
                    {/foreach}
                {/if}
            </div>
        {/foreach}
    </div>

    <div id="priv_dom" {if $submit.privileges.domains.full}style="display:none"{/if}>
        {foreach from=$domains item=o}
            <h4>
                <input type="checkbox" class="privilege " id="dmain_{$o.id}" onclick="cUnc(this,'d{$o.id}')"/>
                <span for="dmain_{$o.id}">{$lang.domain} - {$o.name}</span>
            </h4>
            <div class="pgroup mb20">
                <div>
                    <input type="checkbox" class="privilege d{$o.id} domains"
                           id="domains_{$o.id}_basic" value="1"
                           name="privileges[domains][{$o.id}][basic]"
                           {if $submit.privileges.domains[$o.id].basic}checked{/if}/>
                    <span for="domains_{$o.id}_basic">{$lang.domains_basic}</span>
                </div>
                <div>
                    <input type="checkbox" class="privilege  d{$o.id} domains"
                           id="domains_{$o.id}_renew" value="1"
                           name="privileges[domains][{$o.id}][renew]"
                           {if $submit.privileges.domains[$o.id].renew}checked{/if}/>
                    <span for="domains_{$o.id}_renew">{$lang.domains_renew}</span>
                </div>
                <div>
                    <input type="checkbox" class="privilege  d{$o.id} domains"
                           id="domains_{$o.id}_notify" value="1"
                           name="privileges[domains][{$o.id}][notify]"
                           {if $submit.privileges.domains[$o.id].notify}checked{/if}/>
                    <span for="domains_{$o.id}_notify">{$lang.services_notify}</span>
                </div>
                {if $o.widgets}
                    {foreach from=$o.widgets item=w name=wl}
                        <div>
                            <input type="checkbox" class="privilege d{$o.id} domains"
                                   id="domains_{$o.id}_{$w.name}" value="1"
                                   name="privileges[domains][{$o.id}][{$w.name}]"
                                   {if $submit.privileges.domains[$o.id][$w.name]}checked{/if}/>
                            <span for="domains_{$o.id}_{$w.name}">
                                {assign var=widg_name value="`$w.name`_widget"}
                                {if $lang[$widg_name]}{$lang[$widg_name]}
                                {elseif $lang[$w.name]}{$lang[$w.name]}
                                {elseif $w.fullname}{$w.fullname}
                                {else}{$w.name}{/if}
                            </span>
                        </div>
                    {/foreach}
                {/if}
            </div>
        {/foreach}
    </div>
</div>
{literal}
    <script type="text/javascript">
        function cUnc(el, target) {
            if ($(el).is(':checked')) {
                $('.' + target).attr('checked', 'checked');
            } else {
                $('.' + target).removeAttr('checked');

            }
        }

        function loadProfile(val) {
            $('.privilege').removeAttr('checked');
            $('#priv_dom').show();
            $('#priv_serv').show();
            if (val == 0) {
                return false;
            }
            $.post('?cmd=profiles&action=loadpremade', {premade: val}, function (response) {
                if (response.all) {
                    $('.privilege').attr('checked', 'checked').change();
                    return;
                }
                if (response.billing) {
                    if (response.billing.all) {
                        $('.billing').attr('checked', 'checked').change();
                    }
                }
                if (response.domains) {
                    if (response.domains.all) {
                        $('.domains').attr('checked', 'checked').change();
                    }
                }
                if (response.services) {
                    if (response.services.all) {
                        $('.services').attr('checked', 'checked').change();
                    }
                }
                if (response.support) {
                    if (response.support.all) {
                        $('.support').attr('checked', 'checked').change();
                    }
                }
            });

            return false;
        }
        $(function(){
            $('#services_full').change(function () {
                if ($(this).is(':checked')) $('#priv_serv').slideUp(); else $('#priv_serv').slideDown();
            }).change();
            $('#domains_full').change(function () {
                if ($(this).is(':checked')) $('#priv_dom').slideUp(); else $('#priv_dom').slideDown();
            }).change();
        })
    </script>
    <style>
        .pgroup {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
        }
    </style>
{/literal}