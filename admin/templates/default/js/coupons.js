function sh_(what, ins) {
    if ($(ins).is(':checked')) {
        $(what).show();
        $('#cycles').show();

    } else {
        $(what).hide();
        if (!$('#products').is(':visible') && !$('#upgrades').is(':visible') && !$('#addons').is(':visible') && !$('#domains').is(':visible')) {
            $('#cycles').hide();
        }
    }
}

function randomCode(target) {
    var length = 20;
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    pass = "";
    for (x = 0; x < length; x++) {
        i = Math.floor(Math.random() * 62);
        pass += chars.charAt(i);
    }
    $(target).val(pass);
    return false;
}

function client_check(vals) {
    if (vals == 'existing') {
        $('#specify').show();
    } else
        $('#specify').hide();

}

var applycode = $('#apply_code').val();

function recurring_check(vals) {
    if (vals == 'setupfee') {
        $('#cycle_code').val('once').find('option:last').prop('disabled', true).attr('disabled', 'disabled').parents('tr').eq(0).ShowNicely();
    } else if (applycode == 'setupfee')
        $('#cycle_code option').prop('disabled', false).removeAttr('disabled').parents('tr').eq(0).ShowNicely();
    applycode = vals;
}

function check_i(element) {
    var td = $(element).parent();
    if ($(element).is(':checked'))
        $(td).find('input.config_val').removeAttr('disabled');
    else
        $(td).find('input.config_val').attr('disabled', 'disabled');
}

$(document).ready(function () {
    var proRel = $('#apply_products, #apply_categories, #apply_domains', '#toggles');

    proRel.on('change', function () {
        var checked = proRel.filter(":checked").length > 0;
        var coupCart = $('#coupon_type').val() === 'cart';
        $('#cycles').toggle(checked);
        $('#apply_forms', '#toggles')
            .prop('disabled', !checked || !coupCart)
            .trigger('change');
    });

    $('#toggles').on('change', '[data-toggle]', function () {
        $(this.dataset.toggle).toggle(this.checked && !this.disabled);
        if (!this.checked && this.dataset.clear == '1')
            $(this.dataset.toggle).find('select').val('').trigger('change');
    }).find('[data-toggle]').trigger('change');

    $('#applicable [data-chosen]').chosenedge({
        width: "100%",
        search_contains: true,
    });

    $('#cycle_code').change(function () {
        var val = $(this).val();
        var target = $('#increase_in_days').closest('tr');
        if (val == 'once') {
            target.hide();
            $('input#increase_in_days_check').removeAttr('checked');
            $('input#increase_in_days').attr('disabled', 'disabled').val(0);
        } else {
            target.show();

        }
    });

    $('#coupon_type').change(function () {
        var val = $(this).val();

        $('.coupon-type-invoice').toggle(val === 'invoice');
        $('.coupon-type-cart').toggle(val === 'cart');

        proRel.trigger('change');
    }).trigger('change');
});

function generateCodes(btn, batch_id) {
    var count = $('#generate_codes').val();
    if (!count || (parseInt(count) <= 0))
        return;
    if ($(btn).is('[disabled=disabled]'))
        return;

    $(btn).attr('disabled', true);
    $('.creditVouchersLoaderImg').show();
    $.ajax({
        type: 'POST',
        url: "?cmd=coupons&action=batch&make=generate_codes",
        data: {
            id: batch_id,
            size: count
        },
        success: function (data) {
            parse_response(data);
            $('.creditVouchersSize').html(parseInt($('.creditVouchersSize').html()) + parseInt(count));
            $('.creditVouchersLoaderImg').hide();
            $(btn).attr('disabled', false);
        }
    });
}