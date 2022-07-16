{if $client_contacts}
    <div class="form-group">
        <label class="control-label">Notified contacts</label><br>
        <select name="notified_contacts[]" class="chosenedge" multiple>
            {foreach from=$client_contacts item=ccontact key=id}
                <option value="{$ccontact.email}" {if in_array($ccontact.email, $client_contacts_selected)}selected{/if}>#{$ccontact.id} {$ccontact.firstname} {$ccontact.lastname}</option>
            {/foreach}
        </select>
    </div>
{elseif $parent_client}
    <div class="form-group">
        <label class="control-label">Parent account</label><br>
        <div><a href="?cmd=clients&action=show&id={$parent_client.id}">#{$parent_client.id} - {$parent_client.firstname} {$parent_client.lastname} </a></div>
    </div>
{/if}

<div class="form-group">
    <label class="control-label">CC</label>
    <div id="cc_emails" data-type="cc"  class="emsubs-form" data-tags="{$cc_emails|@json_encode|escape}" data-placeholder="Type in email address, confirm with ↵ key"></div>
    <input type="hidden" name="cc" value="{$ticket_cc}" class="form-control"/>
</div>

<div class="form-group">
    <label class="control-label">BCC</label>
    <div id="bcc_emails" data-type="bcc" class="emsubs-form" data-tags="{$bcc_emails|@json_encode|escape}" data-placeholder="Type in email address, confirm with ↵ key"></div>
    <input type="hidden" name="bcc" value="{$ticket_bcc}" class="form-control"/>
</div>

{literal}
<script>
    $(function () {
        $('.chosenedge').chosenedge({
            width: '100%',
            enable_split_word_search: true,
            search_contains: true
        })

        $('.emsubs-form').hbtags().on('tags.before.add', function (e, tags) {
            function isValidEmailAd(emailAddress) {
                var pattern = new RegExp(/^(("[\w-+\s]+")|([\w-+]+(?:\.[\w-+]+)*)|("[\w-+\s]+")([\w-+]+(?:\.[\w-+]+)*))(@((?:[\w-+]+\.)*\w[\w-+]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][\d]\.|1[\d]{2}\.|[\d]{1,2}\.))((25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\.){2}(25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\]?$)/i);
                return pattern.test(emailAddress);
            }
            for(var i = 0; i < tags.length; i++){
                if(tags[i]){
                    if (!isValidEmailAd(tags[i]))
                        tags[i] = '';
                }
            }
        }).on('tags.refresh', function (e, hbtags) {
            var type = $(this).attr('data-type'),
                    emi = $(this).parent().find('input[name="'+type+'"]'),
                    neval = hbtags.tags.join(',');
            emi.val(neval);
        });
    });
</script>
{/literal}