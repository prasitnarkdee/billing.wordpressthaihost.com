    <div class="flex">
        {foreach from=$summary item=stat}
            <div class="stat-item">
                <div class="pp-amount">
                    <span class="pp-amt">{$stat.credit|price:$stat.currency_id:false}</span>
                    <span class="pp-code">{$currencies[$stat.currency_id].iso}</span>
                </div>
            </div>
        {/foreach}
    </div>
    <div class="pull-right">
        <a target="_blank" class="btn btn-sm btn-primary" onclick='return loadCreditEntries();' style="margin:5px">Load credit details</a>
        <a target="_blank" class="btn btn-sm btn-primary" onclick='return loadTransactionsEntries();' style="margin:5px">Last transactions</a>
    </div>
    <div class="clear"></div>

<div id="creditload">

</div>
{literal}
<script>
    function loadCreditEntries() {
        var container = $('#creditload');
        container.parents('.box').append('<div class="overlay"><img src="ajax-loading.gif" /></div>');


        $.get('?cmd=credit_info_widget',{action:'loadcredit'},function(data) {
            container.parents('.box').find('.overlay').remove();

            $('#creditload').html(data);
        });
        return false;
    }
    function loadTransactionsEntries() {
        var container = $('#creditload');
        container.parents('.box').append('<div class="overlay"><img src="ajax-loading.gif" /></div>');


        $.get('?cmd=credit_info_widget',{action:'loadtransactions'},function(data) {
            container.parents('.box').find('.overlay').remove();

            $('#creditload').html(data);
        });
        return false;
    }
</script>
    <style>

        .box.credit_info_widget .flex{
            display: flex;
            flex-wrap: wrap;
            margin: -5px
        }

        .box.credit_info_widget .stat-item{
            margin: 5px 5px;
        }

        .box.credit_info_widget .pp-amount{
            display: flex;
            vertical-align: top;
            font-size: 15px;
            font-weight: bold;
            line-height: 25px;
            white-space: nowrap;
        }
        .box.credit_info_widget .pp-amt{
            border: 1px solid #3598DC;
            border-right: none;
            color: #323538;
            border-radius: 2px 0 0 2px;
            padding: 0 3px;
        }
        .box.credit_info_widget .pp-code{
            border-radius: 0 2px 2px 0;
            border: solid 1px #3598DC;
            border-left: none;
            background: #3598DC;
            color: white;
            padding: 0 4px;
        }
    </style>

{/literal}
