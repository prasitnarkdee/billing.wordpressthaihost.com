{cartfieldlogic}
{if $cf.config.showsteps}
    {once}
        <script type="text/javascript" src="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.js"></script>
        <link rel="stylesheet" href="{$system_url}includes/libs/configoptions/slider/pips/jquery-ui-slider-pips.css" />
    {/once}
{/if}
{foreach from=$cf.items item=cit}
    <div class="custom_field_{$cf.copy_of}">

        <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"
                 {cartformvalue}
               value="{if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}"
               type="text" style="display:none" id="custom_field_{$cf.copy_of}"
               onchange="$(document).trigger('hbcart.changeform', [this]);
                       if (typeof (simulateCart) == 'function')
                       simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"
               variable="{$cf.variable}" class="custom_field_{$cf.copy_of}"/>
        <div class="slider-group">
            <div id="custom_slider_{$cit.id}" class="slides left"
                 style="margin:6px 20px 0px 20px !important;float:left !important;width:370px;">
                <div class="sl"></div>
                <div class="sr"></div>
            </div>
            <input value="{if $cfvalue.qty}{$cfvalue.qty}{else}{$cf.config.initialval}{/if}"
                   type="text" id="custom_slider_{$cit.id}_value_indicator"
                   class="slider-value-indicator" title="{$cit.name}"/>
        </div>
        <script type="text/javascript">

            {if $cf.config.conditionals}
                $('#custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal}, [{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
                    value: '{$cd.targetval}',
                    condition_source: '{$cd.conditionsource}',
                    condition_type: '{$cd.condition}',
                    target: '.custom_field_{$cd.target}',
                    condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
                    action: '{$cd.action}'
                    {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}], {$subtotal|@json_encode});
            {/if}

            var _size = parseInt('{$cf.config.maxvalue}') || 100;
            window.SliderInputSize = Math.max(window.SliderInputSize, _size);

            setTimeout(function () {literal}{{/literal}
                var s = $('#custom_slider_{$cit.id}');
                var sval = $('#custom_field_{$cf.copy_of}');
                var svalind = $('#custom_slider_{$cit.id}_value_indicator');
                if (typeof ($('#slider').slider) != 'function'){literal} {
                    s.hide();
                    return false;
                }{/literal}

                var maxval = parseInt('{$cf.config.maxvalue}') || 100,
                    minval = parseInt('{$cf.config.minvalue}') || 0,
                    stepval = parseInt('{$cf.config.step}') || 1,
                    initialval = parseInt('{$cf.config.initialval}') || 0,
                    size = 12 * (window.SliderInputSize.toString().length + 1),
                    showsteps = {if $cf.config.showsteps} true {else} false {/if};

                {literal}

                if ((maxval - minval) / stepval > 10) {
                    var pipstep = (maxval - minval) / 10;
                }

                s.width(s.parent().width() - size - (s.outerWidth(true) - s.width()) - (sval.outerWidth(true) - sval.width())).slider({
                    min: minval,
                    max: maxval,
                    value: sval.val() || initialval,
                    step: stepval,
                    range: "min",
                    values: [],
                    animate: true, stop: function (e, ui) {
                        var x = Math.floor(s.slider("value"));
                        svalind.val(x);
                        sval.val(x).trigger('change'); // trigger as last action
                    }
                });

                if (showsteps) {
                    s.slider("pips", {
                        rest: "label",
                        step: pipstep
                    }).slider("float");
                }

                svalind.width(size).on('change keyup', function (e) {
                    var self = $(this),
                        val = parseInt($(this).val());
                    if (val % stepval != 0)
                        val = val - val % stepval
                    if (isNaN(val) || minval > val)
                        val = minval;
                    else if (val > maxval)
                        val = maxval;
                    sval.val(val);
                    if (e.type != 'change')
                        return;
                    self.val(val);
                    s.slider('value', val);
                    sval.val(val).trigger('change');
                });

                sval.data('getValue', function(){
                    return s.slider('value');
                })
                sval.data('setValue', function(value){
                    s.slider('value', value);
                    sval.val(value)
                    svalind.val(value);
                })
            }, 200);{/literal}
        </script>
    </div>
{/foreach}