{cartfieldlogic}
{if $cf.config.showsteps}
    {once}
        <script type="text/javascript" src="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.js"></script>
        <link rel="stylesheet" href="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.css" />
    {/once}
{/if}
{foreach from=$cf.items item=cit}
    <div class="custom_field_{$cf.copy_of}">
        <div class="slider-group">
            <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"
                    {cartformvalue} value="{if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}"
                   type="text" style="display:none" id="custom_field_{$cf.copy_of}"
                   onchange="$(document).trigger('hbcart.changeform', [this]);if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"
                   variable="{$cf.variable}" class="custom_field_{$cf.copy_of}"/>
            <div id="custom_slider_{$cit.id}" class="slides left"
                 style="margin:6px 20px 0px 20px !important;float:left !important;width:370px;">
                <div class="sl"></div>
                <div class="sr"></div>
            </div>
            <div id="custom_slider_{$cit.id}_value_indicator" class="slider-value-indicator" style="font-weight:bold;font-size:14px;padding-top:3px;">
                {if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}{$cit.name}
            </div>
        </div>
        <script type="text/javascript">

            {if $cf.config.conditionals}
            $('#custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}
                type: '{$cf.type}'
                {literal}}{/literal}, [{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
                value: '{$cd.targetval}',
                condition_type: '{$cd.condition}',
                condition_source: '{if $cd.conditionsource}{$cd.conditionsource}{else}self{/if}',
                target: '.custom_field_{$cd.target}',
                condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
                action: '{$cd.action}'
                {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}], {$subtotal|@json_encode});
            {/if}

            var _size = parseInt('{$cf.config.maxvalue}') || 100;
            window.SliderInputSize = Math.max(window.SliderInputSize, _size);

            setTimeout(function () {literal}{{/literal}
                var _s = '#custom_slider_{$cit.id}';
                var s = $(_s);
                var sval = $('#custom_field_{$cf.copy_of}');
                var svalind = $('#custom_slider_{$cit.id}_value_indicator');
                var unit = {$cit.name|json_encode};
                if (typeof ($('#slider').slider) != 'function'){literal} {
                    s.hide();
                    return false;
                }

                function getKeyByValue(object, value) {
                    return Object.keys(object).find(key => object[key] === value);
                }

                {/literal}

                var initialval = parseInt('{$cf.config.initialval}') || 0,
                    steps = {$cf.steps|@json_encode},
                    size = 12 * (window.SliderInputSize.toString().length + 1),
                    showsteps = {if $cf.config.showsteps} true {else} false {/if};

                var initialkey = getKeyByValue(steps, parseInt('{if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}'));

                {literal}

                s.width(s.parent().width() - size - (s.outerWidth(true) - s.width()) - (sval.outerWidth(true) - sval.width()))
                .slider({
                    min: 0,
                    max: steps.length - 1,
                    step: 1,
                    animate: true,
                    range: "min",
                    value: initialkey,
                    values: [initialkey],
                    stop: function(e, ui) {
                        var x = steps[ui.value];
                        svalind.html(x + unit);
                        sval.val(x).trigger('change'); // trigger as last action
                    },
                });

                if (showsteps) {
                    s.slider('pips', {labels: steps, rest: 'label'})
                    .slider('float', {labels: steps, rest: 'label'});
                }

                sval.data('getValue', function(){
                    return steps[s.slider('values')[0]];
                })
                sval.data('setValue', function(value){
                    let vstep = 0;
                    steps.forEach(function(v, i){
                        if(v <= value)
                            vstep = i;
                    })
                    value = steps[vstep]
                    s.slider('values', [vstep]);
                    svalind.html(value + unit);
                    sval.val(value);
                })

            }, 200);{/literal}
        </script>
    </div>
{/foreach}