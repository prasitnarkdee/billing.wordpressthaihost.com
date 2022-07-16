{if $custom_overrides.entercvv}
    {include file=$custom_overrides.entercvv}
{else}
    {literal}<style type="text/css">
        #onestepcontainer #gatewayform .wbox {
            border:none;
        }
        #onestepcontainer #gatewayform .wbox_header {
            border:none;
            margin:0px;
            background:none;
            padding:0px;
            font-size:17px;
            letter-spacing: -1px;
            text-transform: lowercase;
        }
        #onestepcontainer #gatewayform .wbox_content {
            border-radius:4px 4px 4px 4px;
            border:1px solid #D2D2D2;
        }
        .credit_card {
            display:block;
            width:32px;
            height:32px;
            background-image: url('templates/orderpages/images/credit_cards.png');
            background-repeat:no-repeat;
            float:left;
            margin-right:10px;
        }
        .amex {
            background-position: -32px 0px;
        }
        .amex.offcard {
            background-position: -32px -32px !important;
        }
        .Visa {
            background-position: -64px 0px;
        }
        .Visa.offcard {
            background-position: -64px -32px !important;
        }
        .Discover {
            background-position: 0px 0px;
        }
        .Discover.offcard {
            background-position: 0px -32px !important;
        }
        .MasterCard {
            background-position: -96px 0px;
        }
        .MasterCard.offcard {
            background-position: -96px -32px !important;
        }

        .ccform label {
            margin-bottom:4px;
            clear:both;
            display:block;
        }
        .cfitm {
            padding:5px 10px 5px;
        }
        .citm {
            padding:5px;
            width: 280px;
        }


    </style>

    {/literal}
    <div class="wbox">
        <div class="wbox_header">
            <strong>{$lang.ccarddetails}</strong>
        </div>
        <div class="wbox_content ccform">
            <div class="left cfitm">
                <label for="field_credit_number">{$lang.ccardnum}</label>
                <b>{$creditcard.cardnum}</b>
            </div>

            <div class="left cfitm" style="padding-bottom:3px">
                <label for="field_credit_number">{$lang.ccardexp}</label>
                <b>{$creditcard.expdate}</b>
            </div>
            <div class="left cfitm">
                <label for="field_credit_number">CVV2</label>
                <input type="text" id="field_credit_number" class="styled" name="cc[cvv]" style="width:50px" value="" autocomplete="off" />
            </div>
            <div class="left cfitm" id="card_types">
                 <label for="field_credit_number">&nbsp;</label>
                <div class="credit_card {$creditcard.cardtype}"></div>
                <div class="clear"></div>
            </div>


            <div class="clear"></div>



        </div>
    </div>
{/if}
