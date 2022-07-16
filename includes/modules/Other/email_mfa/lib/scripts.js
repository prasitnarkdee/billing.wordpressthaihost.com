var MFAEMAIL = {
    send: function (btn, url) {
        var b = $(btn);
        var v = b.html();
        var r = b.attr('data-resend');
        b.prop('disabled', true);
        setTimeout(function () {
            b.prop('disabled', false);
        }, 10000); //turn off for 10 seconds

        $.ajax({
            url: url + '&resend=' + r,
            type: 'POST',
            data: {},
            success: function (data) {
                b.attr('data-resend', '1').html(v);
                b.find('[data-state="visible"]').hide();
                b.find('[data-state="hidden"]').show();
            }
        });
    },
    sendEnable: function (btn) {
        var m = $(btn).attr('data-module-id');
        return MFAEMAIL.send(btn, '?cmd=mfa&action=enable&id=' + m);
    },
    sendVerify: function (btn) {
        $('#2faform').show();
        return MFAEMAIL.send(btn, '?cmd=mfa&action=verify');
    }
}