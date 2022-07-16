{if !$files}
    <em>This client does not have any files yet</em>
{else}
    <script type="text/javascript" src="{$template_dir}js/photoswipe/photoswipe.min.js"></script>
    <script type="text/javascript" src="{$template_dir}js/photoswipe/photoswipe-ui-default.min.js"></script>
    <script type="text/javascript" src="{$template_dir}js/hbfiles.js"></script>
    <link rel="stylesheet" type="text/css" href="{$template_dir}js/photoswipe/photoswipe.min.css">
    <link rel="stylesheet" type="text/css" href="{$template_dir}js/photoswipe/default-skin.min.css">

    <div class="hbfiles">
        {foreach from=$files item=file}
            <div data-type="{$file.type}"
                 data-id="{$file.id}"
                 data-thumbnail-url="?action=download&id={$file.id}&type=downloads&inline=1&thumbnail=1"
                 data-preview-url="?action=download&id={$file.id}&type=downloads&inline=1"
                 data-download-url="?action=download&id={$file.id}&type=downloads"
                 data-title="{$file.name}"
                 class="hbfile"
            >
                <div class="hbfile-control">
                    <a href="?action=download&type=downloads&id={$file.id}" class="hbfile-control-icon hbfile-download"><i class="fa fa-download"></i></a>
                    {if !$forbidAccess.editClients}
                        <a onclick="return confirm('Are you sure you want to delete this file?')" href="?cmd=clients&action=deleteclientfile&client_id={$client_id}&file_id={$file.id}&security_token={$security_token}" class="hbfile-control-icon hbfile-remove"><i class="fa fa-trash"></i></a>
                    {/if}
                </div>
                <div class="hbfile-placeholder-box">
                    <img src="{$template_dir}img/ajax-loading2.gif" class="hbfile-placeholder" title="{$file.name}" alt="{$file.name}"/>
                </div>
                <div class="hbfile-title" title="{$file.name}">{$file.name}</div>
            </div>
        {/foreach}
    </div>
{/if}
{if !$forbidAccess.editClients}
    <div id="fileform" class="blu" style="display:none">
        <table cellpadding="0" cellspacing="6" width="100%">
            <tr>
                <td align="right"><strong>{$lang.Name}</strong></td>
                <td><input name="name"/></td>
                <td align="right"><strong>{$lang.file}</strong></td>
                <td>
                    <input type="file" name="file"/>
                </td>
                <td align="right"><strong>Admin only</strong></td>
                <td><input type="checkbox" name="admin_only" value="1"/></td>
                <td align="right">
                    <input type="submit" name="uploadfile" value="Upload" class="btn btn-primary btn-sm" onclick="$('#clientform').append('<input name=\'action\' value=\'uploadclientfile\' type=\'hidden\' />')"/>
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" name="client_id" value="{$client_id}"/>
    <a href="#" class="menuitm right" onclick="$(this).hide();$('#fileform').show();return false;"><span>Upload file</span></a>
{/if}
<div class="clear"></div>
{literal}
    <script></script>
{/literal}