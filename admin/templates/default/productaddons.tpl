<script type="text/javascript">loadelements.services = true;</script>
<script type="text/javascript" src="{$template_dir}js/services.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td colspan="2"><h3>{$lang.productsandaddons}</h3></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=services&action=addcategory" class="tstyled btn btn-success" style="margin-bottom: 10px;"><strong>{$lang.addneworpage}</strong></a>
            <a href="?cmd=services" class="tstyled">{$lang.orpages}</a>
            <a href="?cmd=productaddons" class="tstyled {if $action!='categories' && $action!='category' && $action!='addcategory'}selected{/if}">{$lang.manageaddons}</a>
            <a href="?cmd=formgroups" class="tstyled">{$lang.formgroups}</a>
        </td>
        <td valign="top" class="bordered" rowspan="2">
            <div id="bodycont">
                {include file='ajax.productaddons.tpl'}
            </div>
        </td>
    </tr>
</table>
<script type="text/javascript">
    {literal}
    function showhid(el) {
        if ($(el).val() == 'Free') {
            $('.prices').hide();
        } else {
            $('.prices').show();
        }
    }
    function un_c(el) {
        if ($(el).attr('class') == 'catA' && $(el).is(':checked')) {
            $('.prodA').attr('checked', false);
        } else if ($(el).attr('class') == 'prodA' && $(el).is(':checked')) {
            $('.catA').attr('checked', false);
        }
    }
    function selectalladdons() {
        for (var i = 0; i < $('#listAlready')[0].options.length; i++) {
            $('#listAlready')[0].options[i].selected = true;
        }
    }
    {/literal}
</script>