{literal}
    <script type="text/javascript">
        !function (e, o, t) {
            e[t] = function (n, r) {
                var c = {
                    sandbox: "https://sandbox-merchant.revolut.com/embed.js",
                    prod: "https://merchant.revolut.com/embed.js",
                    dev: "https://merchant.revolut.codes/embed.js"
                }, d = o.createElement("script");
                d.id = "revolut-checkout", d.src = c[r] || c.prod, d.async = !0, o.head.appendChild(d);
                var s = {
                    then: function (r, c) {
                        d.onload = function () {
                            r(e[t](n))
                        }, d.onerror = function () {
                            o.head.removeChild(d), c && c(new Error(t + " is failed to load"))
                        }
                    }
                };
                return "function" == typeof Promise ? Promise.resolve(s) : s
            }
        }(window, document, "RevolutCheckout");
        (function () {
           RevolutCheckout("{/literal}{$revolut_order.public_id}{literal}", "{/literal}{$revolut_mode}{literal}").then((instance) => {
               var cl = {/literal}{$revolut_client.address|@json_encode}{literal};
               instance.payWithPopup({
                   //name: "{/literal}{$revolut_client.name}{literal}",
                   email: "{/literal}{$revolut_client.email}{literal}",
                   phone: "{/literal}{$revolut_client.phonenumber}{literal}",
                   savePaymentMethodFor: "merchant",
                   billingAddress: cl,
                   shippingAddress: cl,
                   onSuccess(message) {
                       $('#revolut-box-form').submit();
                   },
                   onError(message) {
                       console.error(message);
                   },
                   onCancel(message) {
                       console.warn(message);
                   },
               });
           });
        })();
    </script>
{/literal}
<form action="?cmd=revolut&action=success&invoice_id={$invoice_id}" method="post" id="revolut-box-form" target="_top"></form>
