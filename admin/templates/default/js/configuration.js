function check_i(element) {
    var td = $(element).parent();
    if ($(element).is(':checked'))
        $(td).find('.config_val').removeAttr('disabled');
    else
        $(td).find('.config_val').attr('disabled', 'disabled');
}

function testConfiguration() {
    $('#testing_result').html('<img style="height: 16px" src="ajax-loading.gif" />');
    ajax_update('?cmd=configuration&action=test_connection',
        {
            'SystemMail': $('input[name="SystemMail"]').val(),
            'testmailaddress': $('#testmailaddress').val(),
            'MailUseSMTP': $('input[name="MailUseSMTP"]:checked').val(),
            'MailSMTPHost': $('input[name="MailSMTPHost"]').val(),
            'MailSMTPPort': $('input[name="MailSMTPPort"]').val(),
            'MailSMTPEmail': $('input[name="MailSMTPEmail"]').val(),
            'MailSMTPUsername': $('input[name="MailSMTPUsername"]').val(),
            'MailSMTPPassword': $('input[name="MailSMTPPassword"]').val(),
            'MailAuthentication': $('select[name="MailAuthentication"]').val(),
            'MailProvider': $('select[name="MailProvider"]').val(),
            'MailClientID': $('input[name="MailClientID"]').val(),
            'MailClientSecret': $('input[name="MailClientSecret"]').val(),
        }, '#testing_result', false);
}

function c_note() {
    var val = $('input[name=CnoteEnable]:checked').val();
    if (val == 'on')
        $('.cnote').show()
    else
        $('.hide').show()
}

function c_note_numeration() {
    var val = $('input[name=CNoteNumeration]:checked').val();
    if (val == 'default')
        $('.cnote_numeration').show()
    else
        $('.cnote_numeration').hide()
}

function handleCycleFormat(root){
    var presets = $('.format-preset', root),
        custom = $('.format-custom', root),
        doc = $('.format-doc', root),
        presets_btn = $('.format-btn-preset', root),
        custom_btn = $('.format-btn-custom', root);

    $('.format-btn-custom, .format-btn-preset', root).on('click', function () {
        var is_preset = presets_btn.is(this)

        if (is_preset) {
            presets.val(custom.val())
            if(presets.val() === null){
                presets.val('')
            }
            doc.hide()
        } else {
            custom.val(presets.val())
            doc.show()
        }

        presets.toggle(is_preset).prop('disabled', !is_preset);
        presets_btn.toggle(!is_preset)

        custom.toggle(!is_preset).prop('disabled', is_preset);
        custom_btn.toggle(is_preset)
    })

    presets.children().each(function(){
        if(this.value === custom.val()){
            doc.hide();
            presets.val(this.value);
            presets_btn.click();
            return false;
        }
    })

    $('.format-btn-preview', root).on('click', function () {
        var dialog = bootbox.dialog({
            title: 'Billing cycle dropdown preview',
            onEscape: true,
            message: $('#FormatPreview').html(),
        });
        var form = $('input, select', root).serializeForm();
        form.type = this.value;
        $.post('?cmd=configuration&action=bilingcycle_preview', form, function (data) {
            $('.modal-body select', dialog).replaceWith(data);
        })
        return false;
    })
}

function c_reload(sel) {
    switch ($(sel).val()) {
        case '-1':
            $('#currency_edit').show();
            break;
        case 'USD':
            $('#ISOCurrency').val('USD');
            $('#CurrencyFormat').val('1,234.56');
            $('#CurrencyCode').val('USD');
            $('#CurrencySign').val('$');
            break;
            break;
        case 'GBP':
            $('#ISOCurrency').val('GBP');
            $('#CurrencyFormat').val('1,234.56');
            $('#CurrencyCode').val('GBP');
            $('#CurrencySign').val('£');
            break;
        case 'EUR':
            $('#ISOCurrency').val('EUR');
            $('#CurrencyFormat').val('1,234.56');
            $('#CurrencyCode').val('EUR');
            $('#CurrencySign').val('€');
            break;
        case 'BRL':
            $('#ISOCurrency').val('BRL');
            $('#CurrencyFormat').val('1,234.56');
            $('#CurrencyCode').val('');
            $('#CurrencySign').val('R$ ');
            break;
        case 'INR':
            $('#ISOCurrency').val('INR');
            $('#CurrencyFormat').val('1,234.56');
            $('#CurrencyCode').val('INR');
            $('#CurrencySign').val('');
            break;
        case 'CAD':
            $('#ISOCurrency').val('CAD');
            $('#CurrencyFormat').val('1,234.56');
            $('#CurrencyCode').val('CAD');
            $('#CurrencySign').val('$');
            break;
        case 'ZAR':
            $('#ISOCurrency').val('ZAR');
            $('#CurrencyFormat').val('1 234.56');
            $('#CurrencyCode').val('ZAR');
            $('#CurrencySign').val('R');
            break;
    }
    return false;
}

function checkdefault(el) {
    if ($(el).val() == 'default') {
        alert("Please note: Default clientarea is DEPRECATED and left only for backwards compatibility");
    }
}

function shx() {
    $('.cart_d').hide().eq($('#template').eq(0).prop("selectedIndex")).show();
}

function pricepreview() {

    var sign = $('#CurrencySign').val();
    var format = $('#CurrencyFormat option:selected').val();
    var dp = $('#DecimalPlaces option:selected').val();
    var code = $('#CurrencyCode').val();
    ajax_update('?cmd=configuration&action=pricepreview', {
        format: format,
        sign: sign,
        dp: dp,
        code: code,
        decimal: $('#DisplayDecimalPlaces').val()
    }, '#pricepreview');
}

function makeadd() {
    var make = $('#newcurr input[name=make]').val();
    if (make == '') {
        $('#newcurr input[name=make]').val('add')
    } else {
        $('#newcurr input[name=make]').val('')
    }
}

function updateEnable(el, id) {
    var vis = ($(el).is(':checked')) ? '1' : '0';
    ajax_update('?cmd=configuration&action=currency&make=upenable&enable=' + vis + '&id=' + id, false);
    return false;
}

function showeditform(el, id) {
    ajax_update($(el).attr('href'), false, '#curr_' + id);
    return false;
}

function bindMe() {

    $('#newshelfnav').TabbedMenu({
        elem: '.sectioncontent',
        picker: '.list-1elem',
        aclass: 'active',
        picked: picked
    });
    $('#newshelfnav').TabbedMenu({
        elem: '.subm1',
        picker: '.list-1elem',
        picked: picked
    });
    $('#newshelfnav').TabbedMenu({
        elem: '.sectioncontenttable',
        picker: '.list-2elem',
        picktab: true,
        picked: subpicked
    });
    $('#newshelfnav').TabbedMenu({
        elem: '.sectioncontenttable4',
        picker: '.list-4elem',
        picktab: true,
        picked: subpicked
    });
    $('#newshelfnav').TabbedMenu({
        elem: '.sectiontable7',
        picker: '.list-7elem',
        picktab: true,
        picked: subpicked
    });
    $('#newshelfnav').TabbedMenu({
        elem: '.list-3content',
        picker: '.list-3elem',
        picktab: true,
        picked: subpicked
    });


    $('.tag-form').hbtags({sortable: true});
    $('#extensions_tag').on('tags.before.add', function (e, tags) {
        for (var i = 0; i < tags.length; i++) {
            if (tags[i]) {
                tags[i] = '.' + tags[i].replace(/(\.|\s)?(\w+)/g, '$2');
            }
        }
    }).on('tags.refresh', function (e, hbtags) {
        $('#extensions').val(hbtags.tags.join(';'));
    });

    $('.import-headers').on('tags.refresh', function (e, hbtags) {
        var self = $(this);
        self.next('input').val(hbtags.tags.join(','));
    });

    $('#CNoteIssueForUnpaid').on('change', function () {
        $('.cnote-unpaid').prop('disabled', !this.checked);
    }).trigger('change');

    $('input[name=CNoteDowngrade]').on('change', function () {
        var v = $(this).prop('checked'),
            cn = $('input[name=CNoteDowngradeAsDraft]');
        cn.prop('disabled', !v);
        cn.parent().toggle(v);
    }).trigger('change');

    $('input[name=GenerateSeparateInvoices]').on('init change', function (e) {
        var self = $(this),
            toggle = e.type == 'init' ? 'toggle' : 'ToggleNicely';
        if (!self.is(':checked'))
            return;

        $('#GenerateSeparateInvoicesOff')[toggle](self.val() != 'on')
    }).trigger('init')

    $('input,select', '#currencyedittable').change(function () {
        pricepreview();
    });

    $('select[data-toggle]').on('change int', function(e){
        var targets = {};
        $(this).children().each(function(){
            if(!this.dataset['toggle']){
                return;
            }

            var list = JSON.parse(this.dataset['toggle']);
            if(!list || !list.length){
                return;
            }
            for(let opt of list){
                if(!targets.hasOwnProperty(opt) || !targets[opt]){
                    targets[opt] = this.selected;
                }
            }
        })

        for(var key of Object.keys(targets)){
            let querykey = '.opt_' + key;
            if(e.type === 'init'){
                $(querykey).toggle(targets[key]);
            } else if(targets[key]){
                $(querykey).ShowNicely();
            } else{
                $(querykey).hide();
            }
        }
        console.log(targets);
    }).trigger('init');

    $(".chosen").each(function(){
        var self = $(this)
        self.chosenedge({
            enable_split_word_search: true,
            search_contains: true,
            width: self.css('width')
        });
    })

    pricepreview();
    handleCycleFormat($('#BillingCycleFormatOptions'));
    handleCycleFormat($('#DomainPeriodFormatOptions'));
}

function addEmailSender(self) {
    var tr = self.closest('tr');
    tr.addLoader();
    $.post('?cmd=configuration&action=email_sender', {
        "element_id": $('.email_sender').length,
        "sender_id": 'new'
    }, function (result) {
       tr.before('<tr><td>' + result + '</td></tr>');
       tr.hideLoader();
    });
}

function editEmailSender(self, id) {
    var tr = self.closest('tr');
    tr.addLoader();
    $.post('?cmd=configuration&action=email_sender&type=edit', {
        "element_id": $('.email_sender').length,
        "sender_id": id
    }, function (result) {
        tr.replaceWith('<tr><td>' + result + '</td></tr>');
        tr.hideLoader();
    });
}

function removeEmailSender(self, id, text) {
    var tr = self.closest('tr');

    if (confirm(text)) {
        tr.addLoader();
        $.post('?cmd=configuration&action=email_sender&type=remove', {"sender_id": id}, function (result) {
            parse_response(result);
            tr.remove();
        })
    }
    return true;
}

function changeEmailSender(self) {
    var td = self.closest('td');
    if (self.val() === 'smtp') {
        td.find($('.smtp')).slideDown();
    } else {
        td.find($('.smtp')).slideUp();
    }
}

function testEmailSender(self, id) {
    var d = self.closest('.form'),
        r = d.find('.test-result'),
        e = self.closest('.email_sender');

    self.addLoader();
    $.post('?cmd=configuration&action=test_connection', {
        'sender_id': id,
        'type': 'sender',
        'SystemMail': e.find('.sender-email').val(),
        'testmailaddress': d.find('.test-email').val(),
        'MailUseSMTP': e.find('.sender-type').val(),
        'MailSMTPHost': e.find('.sender-smtp-host').val(),
        'MailSMTPPort': e.find('.sender-smtp-port').val(),
        'MailSMTPEmail': e.find('.sender-smtp-email').val(),
        'MailSMTPUsername': e.find('.sender-smtp-user').val(),
        'MailSMTPPassword': e.find('.sender-smtp-pass').val(),
        'MailAuthentication': e.find('.sender-authentication').val(),
        'MailProvider': e.find('.sender-provider').val(),
        'MailClientID': e.find('.sender-smtp-clientid').val(),
        'MailClientSecret': e.find('.sender-smtp-clientsecret').val(),
        'MailAuthorizeURL': e.find('.sender-smtp-authotizeurl').val(),
        'MailAccessTokenURL': e.find('.sender-smtp-accesstokenurl').val(),
        'MailResourceOwnerDetailsURL': e.find('.sender-smtp-resourceurl').val()
    }, function (result) {
        self.hideLoader();
        parse_response(result);
        r.html(result);
    });
}

function mailAuthentication(self) {
    var t = self.closest('table');
    if (t.length === 0)
        t = self.closest('.smtp');
    if (self.val() === 'password') {
        t.find('.password').show();
        t.find('.oauth2').hide();
    } else if (self.val() === 'oauth2') {
        t.find('.oauth2').show();
        t.find('.password').hide();
        changeProvider(t.find('.sender-provider'));
    }
}

function changeProvider(self) {
    var t = self.closest('table');
    if (t.length === 0)
        t = self.closest('.smtp');
    if (self.val() === 'custom') {
        t.find('.oauth2-custom').show();
    } else {
        t.find('.oauth2-custom').hide();
    }
}
appendLoader('bindMe');
