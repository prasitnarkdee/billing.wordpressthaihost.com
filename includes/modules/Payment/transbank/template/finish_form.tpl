{if !$tbd}
    <div class="alert alert-danger">
        {if $fail_message}
            {$fail_message}<br>
            {$lang.transbank_failmessage1}
        {else}
            {$lang.transbank_failmessage2}
        {/if}
        <br><br>
        {if $token_ws}Token WS: {$token_ws} <br> {/if}
        {if $token_tbk}Token TBK: {$token_tbk}{/if}
    </div>
{else}
    <div class="container-fluid invoice-container">
        <div class="alert alert-success">{$lang.transbank_success_message}</div>
        <div class="transactions-container small-text">
            <div class="table-responsive table-bordered">
                <table class="table table-condensed">
                    <thead>
                        <tr>
                            <th class="text-center">{$lang.transbank1}</th>
                            <th class="text-center">{$lang.transbank2}</th>
                            <th class="text-center">{$lang.transbank3}</th>
                            <th class="text-center">{$lang.transbank4}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="text-center">{$lang.invoice} {$tbd.response.buy_order}</td>
                            <td class="text-center">{$tbd.response.transaction_date}</td>
                            <td class="text-center">{$tbd.response.amount}</td>
                            <td class="text-center">{$lang.transbank5}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <h3 class="mt-5">{$lang.transbank6}</h3>
            <div class="table-responsive table-bordered ">
                <table class="table table-condensed">
                    <tr>
                        <td>{$lang.transbank7}:</td>
                        <td><span class="RT">{$lang.success}</span></td>
                    </tr>
                    <tr>
                        <td>{$lang.transbank8}:</td>
                        <td><span class="RT">{$lang.invoice} {$tbd.response.buy_order}</span></td>
                    </tr>
                    <tr>
                        <td>{$lang.transbank9}:</td>
                        <td><span class="CA">{$tbd.response.authorization_code}</span></td>
                    </tr>
                    <tr>
                        <td>{$lang.transbank10}:</td>
                        <td><span class="FC">{$tbd.response.transaction_date}</span></td>
                    </tr>
                    <tr>
                        <td>{$lang.transbank11}:</td>
                        <td><span class="TC">**********{$tbd.response.card_detail.card_number}</span></td>
                    </tr>
                    <tr>
                        <td>{$lang.transbank12}:</td>
                        <td><span class="TP">{$tbd.tdp}</span></td>
                    </tr>
                    <tr>
                    <tr>
                        <td>{$lang.transbank13}:</td>
                        <td><span class="TP">{$tbd.tdc}</span></td>
                    </tr>
                    <tr>
                        <td>{$lang.transbank14}:</td>
                        <td><span class="amount">{$tbd.response.amount}</span></td>
                    </tr>
                </table>
            </div>
        </div>

        <h3 class="mt-5">{$lang.transbank15}</h3>
        <div class="table-responsive table-bordered">
            <table class="table table-condensed">
                <thead>
                    <tr>
                        <th><strong>{$lang.transbank16}</strong></th>
                        <th width="20%" class="text-center"><strong>{$lang.transbank17}</strong></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>{$lang.invoice} {$tbd.response.buy_order}</td>
                        <td class="text-center">{$tbd.response.amount}</td>
                    </tr>
                    <tr>
                        <td class="total-row text-right"><strong>{$lang.total}</strong></td>
                        <td class="total-row text-center">{$tbd.response.amount}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
{/if}

