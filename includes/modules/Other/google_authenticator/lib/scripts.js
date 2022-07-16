function google2factorAuth() {
    var gau = $('.codeInput');
    var btn = $('.btnGenerateCode');
    var label = btn.attr('data-label');
    var issuer = btn.attr('data-bn');
    var qrcode = new QRCode("imageQRCode", {
        text: 'ga',
        width: 200,
        height: 200,
    });

    btn.click(function (e) {
        e.preventDefault();

        function randomString(length, chars) {
            var result = '';
            for (var i = length; i > 0; --i) result += chars[Math.floor(Math.random() * chars.length)];
            return result;
        }

        var code = randomString(16, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567');
        gau.val(code);
        qrcode.makeCode('otpauth://totp/' + label + '?secret=' + code + '&issuer=' + issuer);
        return false;
    }).trigger('click');
}

$(document).ready(google2factorAuth);