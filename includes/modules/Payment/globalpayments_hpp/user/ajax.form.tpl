<script src="{$base_url}includes/modules/Payment/globalpayments_hpp/user/rxp-hpp.js"></script>
{literal}
    <script type="text/javascript">
        (function () {
            $('.btn-paynow').hide();
            const json = {/literal}{$gpayment|@json_encode}{literal};
            RealexHpp.setHppUrl("https://pay.sandbox.realexpayments.com/pay");
            RealexHpp.embedded.init("autoload", "iframeId", "{/literal}{$callback_url}{literal}", json);
        })();
    </script>
{/literal}
<iframe frameborder="0" id="iframeId" style="width: 100%; height: 600px;"></iframe>
