<div class="box box-primary  ">
    <div class="box-header">
        <h3 class="box-title">Stripe Sepa Mandate <i class="fa fa-money  pull-left"></i></h3>
    </div>
    <div class="box-body">
        <div id="" class="form-horizontal">
            <div class="row">
                <div class="col-sm-2">
                    <label>Mandate</label>
                </div>
                <div class="col-sm-10">
                    {$sepadd.reference}
                </div>
            </div>

            <div class="row">
                <div class="col-sm-2">
                    <label>Last 4</label>
                </div>
                <div class="col-sm-8">
                    {$sepadd.last4}
                </div>
            </div>
            <div class="row">
                <div class="col-sm-2">
                    <label>Customer</label>
                </div>
                <div class="col-sm-8">
                    <a href="https://dashboard.stripe.com/customers/{$sepadd.customer}" target="_blank" rel="noreferrer nofollow noopener" class="external">{$sepadd.customer}</a>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-2">
                    <label>Source</label>
                </div>
                <div class="col-sm-8">
                    {$sepadd.source}
                </div>
            </div>
        </div>

    </div>
</div>
