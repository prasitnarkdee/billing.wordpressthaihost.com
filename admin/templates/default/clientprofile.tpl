
<div class="blu">
    <div class="menubar">
        <a href="?cmd=clients&action=show&id={$parent.id}">
            <strong>&laquo; {$lang.backtoclient}</strong>
        </a>
        &nbsp;
        {if $admindata.access.loginAsClient && (($action=='guests' &&  $client) || $action=='showprofile')}
            <a class=" menuitm menu-auto" href="{$system_url2}{$login_link}"
               target="_blank">
                <span><strong>{$lang.loginascontact}</strong></span>
            </a>
        {/if}
        {if $action=='guests'}
            <a class="menuitm clDropdown menu-auto" id="hd1" onclick="return false" href="#">
                <span class="morbtn">{$lang.moreactions}</span>
            </a>
            <ul id="hd1_m" class="ddmenu">
                <li  {if $client}class="disabled"{/if}>
                    <a href="SendInvite"
                       data-href="?cmd=clients&action=guests&id={$submit.id}&make=resend">
                        Re-Send Invite Email
                    </a>
                </li>
                <li>
                    <a href="DeleteAccess"
                       data-href="?cmd=clients&action=deleteprivilege&id={$submit.id}&security_token={$security_token}"
                       style="color:#ff0000">Remove access</a>
                </li>
            </ul>
        {elseif $action=='showprofile'}
            <a class="menuitm clDropdown menu-auto" id="hd1" onclick="return false" href="#">
                <span class="morbtn">{$lang.moreactions}</span>
            </a>
            <ul id="hd1_m" class="ddmenu">
                <li><a href="SendNewPass">{$lang.SendNewPass}</a></li>
                <li><a href="ConvertToClient">{$lang.converttoclient}</a></li>
                <li>
                    <a href="?cmd=clients&action=showprofile&id={$client.id}&make=close&security_token={$security_token}"
                       class="directly">{$lang.CloseAccount}</a>
                </li>
                <li><a href="DeleteContact" data-href="?cmd=clients&action=deleteprofile&client_id={$client.id}&security_token={$security_token}"
                       style="color:#ff0000">{$lang.deletecontact}</a>
                </li>
            </ul>
            {adminwidget module="contacts" section="profileheader"}
        {/if}
    </div>
</div>

<form action='' method='post'>
    <input type="hidden" value="{$client.client_id}" name="client_id" id="client_id"/>
    <input type="hidden" value="{$parent.id}" name="parent_id" id="parent_id"/>
    <input type="hidden" value="main" name="section_submit">
    <div id="ticketbody">
        {if $action=='guests'}
            <h1>
                #{$parent.id}
                <a href="?cmd=clients&action=show&id={$parent.id}">{$parent|@client}</a>
                &raquo; {$lang.guest|capitalize}: {if $client.id}#{$client.id} {$client|@client}{else}{$submit.email}{/if}
            </h1>
            <div id="client_nav">
                <!--navigation-->
                <a class="nav_el nav_sel left" href="#">Access Profile</a>
                {if $client.id}
                    <a class="nav_el left" href="?cmd=clients&action=clientaccess&id={$client.id}" onclick="return false">
                        Access List
                    </a>
                    <a class="nav_el direct left" href="?cmd=clients&action=show&id={$client.id}">{$lang.Profile}</a>
                {/if}
                <div class="clear"></div>
            </div>
            <div class="ticketmsg ticketmain" id="client_tab">
                <div class="slide" style="display:block">
                    <div class="" id="tdetail" style="display: none"><a href="#"><!-- legacy --></a></div>
                    <div id="detcont">
                        <div class="tdetails">
                            <div class="row">
                                <div class="col-lg-12">
                                    {include file='clients/fields.tpl' client=$submit class='form-plaintext-live'}
                                </div>
                            </div>
                        </div>
                        <div class="secondtd" style="display:none">
                            <div class="row">
                                <div class="col-lg-12">
                                    {include file='clients/fields_edit.tpl' client=$submit}
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12" style="text-align: center;">
                                    <input type="submit" id="clientsavechanges" class="btn btn-success"
                                           value="{$lang.savechanges}"/>
                                    <input type="hidden" value="1" name="save"/>
                                    <span class="orspace fs11">{$lang.Or}</span>
                                    <a href="#" class="editbtn" onclick="$('#tdetail a').click(); return false;">
                                        {$lang.Cancel}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="slide">Loading</div> <!-- access list -->
            </div>
            <div class="row" style="color: #777">
                <div class="col-md-4">
                    <label>{$lang.datecreated}:</label>
                    {$client.created_at|dateformat:$date_format}
                </div>
                {if $client}
                <div class="col-md-6">
                    <label>{$lang.clientlastlogin}:</label>
                    {if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}
                    {else}{$client.lastlogin|dateformat:$date_format}{/if}
                    {$lang.From} {$client.ip} {$lang.Host}: {$client.host}
                </div>
                {/if}
            </div>
        {elseif $action=='newguest'}
            <h1>
                #{$parent.id}
                <a href="?cmd=clients&action=show&id={$parent.id}">{$parent|@client}</a>
                &raquo; New Guest
            </h1>
            <div id="client_tab" class="ticketmsg ticketmain">

                <div class="container-fluid clear lighterblue" style="padding-top:14px">


                    <div class="row">
                        <div class="col-lg-8">
                            {include file='clients/fields_edit.tpl' client=$submit}
                        </div>
                        <div class="col-lg-4">
                            <div class="box box-primary">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label>Send invite</label>
                                        <div class="checkbox">
                                            <label>
                                                <input name="notifyclient" value="yes" type="checkbox" checked/>
                                                Send invite to provided email
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="blu">
                        <div class="menubar" style="text-align: center">
                            <button type="submit" name="save" value="1" class="btn btn-success">
                                Add Guest
                            </button>
                            <hr>
                            <p>Managing permissions of this guest will be available after creation</p>
                        </div>
                    </div>
                </div>
            </div>
        {elseif $action=='showprofile'}
            <h1>
                #{$parent.id}
                <a href="?cmd=clients&action=show&id={$parent.id}">{$parent|@client}</a>
                &raquo; {$lang.contact|capitalize}: #{$client.id} {$client.firstname} {$client.lastname}
            </h1>
            <div id="client_nav">
                <!--navigation-->
                <a class="nav_el nav_sel left" href="#">Contact profile</a>
                <a class="nav_el left" href="?cmd=clients&action=clientaccess&id={$client.id}" onclick="return false">
                    Access List
                </a>
                <div class="clear"></div>
            </div>
            <div class="ticketmsg ticketmain" id="client_tab">
                <div class="slide" style="display:block">
                    <div class="" id="tdetail" style="display: none"><a href="#"><!-- legacy --></a></div>
                    <div id="detcont">
                        <div class="tdetails">
                            {include file='clients/_drawprofile.tpl'}
                            <div class="row">
                                <div class="col-md-12" style="text-align: center;">
                                    <a href="#" onclick="$('#tdetail a').click(); return false;"
                                       class="btn btn-primary">Edit contact details</a>
                                </div>
                            </div>
                        </div>
                        <div class="secondtd" style="display:none">
                            {include file='clients/_editprofile.tpl'}
                            <div class="row">
                                <div class="col-md-12" style="text-align: center;">
                                    <input type="submit" id="clientsavechanges" class="btn btn-success"
                                           value="{$lang.savechanges}"/>
                                    <input type="hidden" value="1" name="save"/>
                                    <span class="orspace fs11">{$lang.Or}</span>
                                    <a href="#" class="editbtn" onclick="$('#tdetail a').click(); return false;">
                                        {$lang.Cancel}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="slide">Loading</div> <!-- access list -->
            </div>
            <div class="row" style="color: #777">
                <div class="col-md-4">
                    <label>{$lang.signupdate}:</label>
                    {$client.datecreated|dateformat:$date_format}
                </div>
                <div class="col-md-6">
                    <label>{$lang.clientlastlogin}:</label>
                    {if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}
                    {else}{$client.lastlogin|dateformat:$date_format}{/if}
                    {$lang.From} {$client.ip} {$lang.Host}: {$client.host}
                </div>
            </div>
        {elseif $action=='newprofile'}
            <h1>
                #{$parent.id}
                <a href="?cmd=clients&action=show&id={$parent.id}">{$parent|@client}</a>
                &raquo; {$lang.addcontact}
            </h1>
            {literal}
                <script type="text/javascript">
                    function isInArray(value, array) {
                        return array.indexOf(value) > -1;
                    }

                    function fillParentDetails() {
                        $('[data-parentval]').each(function () {
                            var self = $(this);
                            var selfn = self.attr('name');
                            var parval = self.attr('data-parentval');
                            if (!isInArray(selfn, ['firstname','lastname','phonenumber','email'])) {
                                if (selfn === 'state' && parval && $('.form-control__state_select').length) {
                                    $('.form-control__state_select').val(parval).trigger('change');
                                } else if (self.attr('type') === 'checkbox' && parval == '1') {
                                    self.prop('checked', true).trigger('change');
                                } else if (!self.val() && parval) {
                                    self.val(parval).trigger('change');
                                }
                            }
                        });
                        return false;
                    }
                </script>
            {/literal}
            <input type="hidden" name="id" value="{$parent.id}"/>
            <div id="client_tab" class="ticketmsg ticketmain">
                <div class="container-fluid clear lighterblue" style="padding-top:14px">

                    <button onclick="return fillParentDetails();" class="btn btn-default btn-sm" style="margin-bottom: 10px;">Fill in with the main profile details</button>

                    <div class="row">
                        <div class="col-lg-8">
                            {include file='clients/fields_edit.tpl'}
                        </div>

                        <div class="col-lg-4">
                            <div class="box box-primary">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label>Optional: </label>
                                        <div class="checkbox">
                                            <label>
                                                <input name="notifyclient" value="yes" type="checkbox"/>
                                                {$lang.notifyclient}
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="blu">
                <div class="menubar" style="text-align: center">
                    <button type="submit" name="save" value="1" class="btn btn-success">
                        {$lang.addcontact}
                    </button>
                    <hr>
                    <p>Managing permissions of this contact will be available after creation</p>
                </div>
            </div>
        {/if}
        {literal}
            <style type="text/css">
                .pgroup {
                    padding: 0 0 20px 15px
                }
            </style>
        {/literal}
    </div>


    {securitytoken}
</form>
{if $action=='showprofile' || $action=='guests'}
    <form action='' method='post'>
        <input type="hidden" value="{$client.client_id}" name="client_id" />
        <input type="hidden" value="{$parent.id}" name="parent_id"/>
        <input type="hidden" value="permissions" name="section_submit">
        <input type="hidden" value="{$privilages_pages}" name="totalpages2" id="totalpages"/>
        <div class="blu">
            <div class="left">
                <h1>Permissions:</h1>
            </div>
            <div class="right">
                <div class="pagination"
                     data-total-pages="{$privilages_pages}"
                     data-updater="#privilege-updater"></div>
            </div>
            <div class="clear"></div>
        </div>
        <a href="?cmd=clients&action={$action}_priviliages&id={$submit.id}" id="currentlist" style="display:none"
           updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table">
            <tbody>
            <tr>
                <td id="privilege-updater">
                    {include file="ajax.clientprofile_priviliages.tpl"}
                </td>
            </tr>
            </tbody>
        </table>
        <div class="blu">
            <div class="right">
                <div class="pagination"
                     data-total-pages="{$privilages_pages}"
                     data-updater="#privilege-updater"></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="blu">
            <div class="menubar" style="text-align: center">
                <button type="submit" name="save" value="1" class="btn btn-success">
                    Save Permissions
                </button>
            </div>
        </div>
        {securitytoken}
    </form>
{/if}
<script type="text/javascript">
    lang['deleteaccessheading'] = "{$lang.deleteprofileheading}";
    lang['deleteprofileheading'] = "{$lang.deleteprofileheading}";
    lang['convertclientheading'] = "{$lang.convertclientheading}";
    {literal}
    $(function(){
        var status = $('#field_live_status'),
            user = $('#field_live_user_id'),
            toggles = $('#field_live_name, #field_live_email');

        user.chosensearch({
            width: "100%",
            enable_split_word_search: true,
            search_contains: true,
            args: {type: 'Clients&Contacts'},
            tpl: '#{{id}} {{firstname}} {{lastname}} {{companyname}} {{email}}'
        })

        user.on('change', function(){
            var oldval = status.val(),
                opt = this.value > 0 ? ['Active', 'Closed'] : ['Pending', 'Rejected'];
            status.html(opt.map(function(status){
                return `<option ${status === oldval ? 'selected' : ''}>${status}</option>`
            }).join());
            toggles.prop('readonly', this.value > 0)
        })
    })
    {/literal}
</script>