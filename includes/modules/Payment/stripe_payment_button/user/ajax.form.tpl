{literal}
    <script type="text/javascript">
        (function () {
            $('.btn-paynow').remove();
            var allowed = {/literal}{$allowed_methods}{literal};
            var stripe = Stripe('{/literal}{$pk}{literal}');
            var elements = stripe.elements({
                locale: 'auto'
            });
            var strBox = $('.stripe-box');
            strBox.addClass('submitting');

            var paymentRequest = stripe.paymentRequest({
                country: "{/literal}{$owner.country}{literal}",
                currency: "{/literal}{$payment.currency}{literal}",
                total: {
                    label: "{/literal}{$payment.total.label}{literal}",
                    amount: {/literal}{$payment.total.amount}{literal},
                },
                requestPayerEmail: true,
            });
            var prButton = elements.create("paymentRequestButton", {
                paymentRequest: paymentRequest,
            });

            var showFail = function (message) {
                strBox.removeClass('submitted');
                $('.stripe-error').addClass('visible');
                $('.stripe-error-message').html(message);
            }

            var showSuccess = function (payment_method, int_id) {
                strBox.addClass('submitting');
                var form = $('#payment-form');
                form.find('input[name=\"stripePaymethod\"]').val(payment_method);
                form.find('input[name=\"stripeIntent\"]').val(int_id);
                setTimeout (function() {
                    strBox.removeClass('submitting');
                    strBox.addClass('submitted');
                    form.submit();
                }, 3000);
            }

            paymentRequest.canMakePayment().then(function(result) {
                strBox.removeClass('submitting');
                if (result && allowed && (
                    (result.applePay && allowed.includes('applepay')) ||
                    (result.googlePay && allowed.includes('googlepay'))
                )) {
                    prButton.mount("#payment-request-button");
                } else {
                    showFail("{/literal}{$lang.stripepaymentbtn_notsupport}{literal}");
                    $('#payment-request-button').remove();
                }
            });

            paymentRequest.on("paymentmethod", function(ev) {
                strBox.addClass('submitting');
                stripe.confirmCardPayment(
                        "{/literal}{$intent_secret}{literal}",
                        {payment_method: ev.paymentMethod.id},
                        {handleActions: false}
                ).then(function(confirmResult) {
                    strBox.removeClass('submitting');
                    $('#payment-request-button').remove();
                    console.log(confirmResult);
                    if (confirmResult.error) {
                        ev.complete("fail");
                        showFail(confirmResult.error.message)
                    } else {
                        ev.complete("success");
                        if (confirmResult.paymentIntent.status === "requires_action") {
                            stripe.confirmCardPayment(clientSecret).then(function(result) {
                                console.log(result);
                                if (result.error) {
                                    showFail(result.error.message)
                                } else {
                                    showSuccess(confirmResult.paymentIntent.payment_method, confirmResult.paymentIntent.id);
                                }
                            });
                        } else {
                            showSuccess(confirmResult.paymentIntent.payment_method, confirmResult.paymentIntent.id);
                        }
                    }
                });
            });
        })();
    </script>
{/literal}
<div class="wrapper stripe-box">
    <div class="stripe-error" role="alert"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 17 17">
            <path class="base" fill="#000" d="M8.5,17 C3.80557963,17 0,13.1944204 0,8.5 C0,3.80557963 3.80557963,0 8.5,0 C13.1944204,0 17,3.80557963 17,8.5 C17,13.1944204 13.1944204,17 8.5,17 Z"></path>
            <path class="glyph" fill="#FFF" d="M8.5,7.29791847 L6.12604076,4.92395924 C5.79409512,4.59201359 5.25590488,4.59201359 4.92395924,4.92395924 C4.59201359,5.25590488 4.59201359,5.79409512 4.92395924,6.12604076 L7.29791847,8.5 L4.92395924,10.8739592 C4.59201359,11.2059049 4.59201359,11.7440951 4.92395924,12.0760408 C5.25590488,12.4079864 5.79409512,12.4079864 6.12604076,12.0760408 L8.5,9.70208153 L10.8739592,12.0760408 C11.2059049,12.4079864 11.7440951,12.4079864 12.0760408,12.0760408 C12.4079864,11.7440951 12.4079864,11.2059049 12.0760408,10.8739592 L9.70208153,8.5 L12.0760408,6.12604076 C12.4079864,5.79409512 12.4079864,5.25590488 12.0760408,4.92395924 C11.7440951,4.59201359 11.2059049,4.59201359 10.8739592,4.92395924 L8.5,7.29791847 L8.5,7.29791847 Z"></path>
        </svg>
        <span class="stripe-error-message"></span>
    </div>
    <div class="stripe-success">
        <div class="icon">
            <svg width="84px" height="84px" viewBox="0 0 84 84" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <circle class="border" cx="42" cy="42" r="40" stroke-linecap="round" stroke-width="4" stroke="#000" fill="none"></circle>
                <path class="checkmark" stroke-linecap="round" stroke-linejoin="round" d="M23.375 42.5488281 36.8840688 56.0578969 64.891932 28.0500338" stroke-width="4" stroke="#000" fill="none"></path>
            </svg>
        </div>
    </div>

    <form action="?cmd=stripe_payment_button&action=success" method="post" id="payment-form" target="_top">
        <input type='hidden' name='stripePaymethod'>
        <input type='hidden' name='stripeIntent'>
        <input type='hidden' name='invoice_id' value="{$invoice_id}">
    </form>

    <div id="payment-request-button"></div>
</div>





