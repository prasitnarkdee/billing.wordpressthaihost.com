$(function () {
    var timepickers = $('.timepicker');
    timepickers.timepicker({
        timeFormat: 'H:i',
        showDuration: true
    }).each(function (index, val) {
        if (index % 2 === 0) {
            $(this).on('changeDate change', function (x) {
                timepickers.eq(index + 1).timepicker('option', 'minTime', $(this).timepicker('getTime'))
            });
            timepickers.eq(index + 1).timepicker('option', 'minTime', $(this).timepicker('getTime'))
        }
    });

    $('.sla_trigger').on('change', function () {
        var s = $(this).closest('div').next().find('.sla_trigger_unit').first().find('option');
        var t = $(this).find("option:selected").data('trigger');
        s.each(function () {
            if (t === $(this).data('trigger')) {
                $(this).show();
                $(this).attr('selected', true);
            } else {
                $(this).hide();
            }
        });
    });

    $('.choose').chosenedge({
        width: '100%',
        enable_split_word_search: true,
        search_contains: true
    });

    $('.sla-chosen').chosenedge({width:'100%'});
});
function submit_sla(self) {
    var f = $(self).closest('.modal-dialog'),
        s = $(self).closest('form').serializeObject();
    f.addLoader();
    $.post(s.form, s, function (response) {
        parse_response(response);
        f.hideLoader();
        if($(self).closest('form').data('slaid') == 'new') {
            window.location.reload();
        }

    });
}
(function ($, window) {
    var hb, tpl_row, tpl_items, tpl_statuses, tpl_macros, tpl_tags, tpl_modal,
        macros, tickettags, lists, slas, available, forms, statuses, triggers, admins;

    var newId = 1;

    function parse_info(response){
        if(response.hasOwnProperty('errors')){
            for(let msg of response.errors) {
                $('#taskMGR').taskMgrAddError(msg);
            }
        }
        if(response.hasOwnProperty('info')){
            for(let msg of response.info) {
                $('#taskMGR').taskMgrAddError(msg);
            }
        }
    }

    function bindModal(root){
        $('.vtip_description', root).vTip();
        $('.sla-chosen', root).chosenedge({width:'100%'});
        $('.sla_trigger', root).on('change', function () {
            var s = $(this),
                o = s.find('option:selected'),
                trigger = o.val(),
                unit = $('.sla_trigger_unit', root),
                unitval = unit.val();

            var units = triggers.hasOwnProperty(trigger) ? triggers[trigger].units : triggers.time.units;
            var h = tpl_items({ options: prepareunits(units, unitval)});

            unit.html(h);
        }).trigger('change');
    }

    function showModal(index, action){
        var sla = slas[index] || {
            id: 'new',
            dept_id: $('#dept_id').val(),
            status: '',
            macro_id: 0,
            override_staff: [],
            level: 1,
            trigger: 'replytime',
            trigger_unit: 'hours',
            trigger_status: []
        };

        var data = prepareSLAsData(sla);
        data.action = action;

        var modal = bootbox.dialog({
            message: tpl_modal(data),
            title: sla.name,
            backdrop: true,
            buttons: {
                accept: {
                    label: 'Save Changes',
                    className: 'btn-success',
                    callback: function () {
                        var form  = $('form', this);
                        lists.addLoader();
                        $.post(form.attr('action'), form.serializeForm(), function (response) {
                            lists.hideLoader();
                            parse_info(response);
                            if(response.hasOwnProperty('sla') && response.sla){
                                if(action === 'edit_sla'){
                                    slas[index] = response.sla
                                } else{
                                    slas.push(response.sla);
                                }
                                renderSLAs();
                            }
                        });
                        return true;
                    }
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-default'
                }
            }
        });

        console.log(data);
        bindModal(modal.find(".bootbox-body"), sla)
    }

    function bindSLAsOptions(root) {
        root = root || $('.slas');

        root.on('click', '.edit', function () {
            showModal($(this).closest('.metric-row').data('index'), 'edit_sla');
            return false;
        });

        root.on('click', '.remove', function () {
            lists.addLoader();
            var index = $(this).closest('.metric-row').data('index');
            $.get(this.getAttribute('href'), function (response) {
                lists.hideLoader();
                parse_info(response);

                delete slas[index];
                renderSLAs();
            });
            return false;
        });

        $('.add-sla').on('click', function () {
            showModal(null, 'add_sla');
            return false;
        });

        return root;
    }

    function prepareunits(arr,val) {
        var ret = {};
        for(var b=0;b<arr.length;b++) {
            ret[arr[b]]={
                value: arr[b],
                name: arr[b],
                selected: val && val == arr[b] ? 'selected':''
            };
        }
        return ret;
    }

    function prepareSLAsData(sla) {
        var data = {
            sla: sla,
            dept_id: $('#dept_id').val(),
            statuses: $.extend(true, {}, statuses),
            triggers: $.extend(true, {}, triggers),
            macros: $.extend(true, {}, macros),
            admins: $.extend(true, {}, admins),
            business_hours: [
                {value: 1, name: 'Anytime'},
                {value: 2, name: 'During business hours'},
                {value: 3, name: 'Outside business hours'}
            ],
            levels: []
        }

        $.each(data.statuses,function(i,d){
            d.value = d.status;
            d.selected = sla.trigger_status.includes(d.status)
        });
        $.each(data.macros, function (i, d) {
            d.value = d.id;
            d.selected = sla.macro_id === d.id;
        });
        $.each(data.admins, function (i, d) {
            d.value = d.id;
            d.selected = sla.override_staff.includes(d.id);
        });
        $.each(data.business_hours,function(i,d){
            d.selected = sla.business_hours == d.value;
        });
        $.each(data.triggers, function (i, d) {
            d.value = i;
            d.selected = sla.trigger === i;
            d.units = prepareunits(d.units, sla.trigger_unit)
        });
        for(let i = 1; i< 11; i++){
            data.levels.push({
                value: i,
                selected: sla.level == i
            })
        }
        return data;
    }

    function renderSLAs() {
        for (let sla of slas){
            if(!sla){
                continue
            }
            sla.trigger_name = '';
            for(let [id, trigger] of Object.entries(triggers)){
                if(id === sla.trigger){
                    sla.trigger_name = trigger.name;
                    break;
                }
            }
        }
        slas.sort(function(a,b){
            return b.level - a.level;
        })
        lists.html(tpl_row({sla: slas}))
    }

    window.initSLAsOptions = function (_slas,_statuses,_triggers,_macros, _tickettags, _admins) {
        slas = _slas || {};
        statuses = _statuses || {};
        triggers = _triggers || {};
        macros = _macros || {};
        tickettags = _tickettags || {};
        admins = _admins || {};

        hb = Handlebars.create();
        tpl_row = hb.compile(document.getElementById("slas-row-template").innerHTML);
        tpl_modal = hb.compile(document.getElementById("sla-modal").innerHTML);
        tpl_items = hb.compile(document.getElementById("slas-form-options").innerHTML);

        hb.registerPartial('select', tpl_items);

        $(function () {
            lists = $('#sla-list-body');
            renderSLAs();
            bindSLAsOptions();
        })
    }
})(jQuery, window);