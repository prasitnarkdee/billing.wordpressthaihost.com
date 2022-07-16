<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>

{literal}
    <script type="text/javascript">
        function loadWYSIWYG() {
            var w = {
                selector: '#tplcontent',
                plugins: 'preview importcss searchreplace autolink save directionality code visualblocks visualchars fullscreen image link codesample table charmap pagebreak nonbreaking anchor insertdatetime advlist lists wordcount help quickbars',
                menubar: 'file edit view insert format tools table help',
                toolbar: 'undo redo | bold italic underline strikethrough | fontfamily fontsize blocks | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | fullscreen  preview print | image link anchor codesample | ltr rtl',
                toolbar_sticky: true,
                quickbars_selection_toolbar: 'bold italic | quicklink h2 h3 blockquote quickimage quicktable',
            };

            var textarea = $('#tplcontent');
            textarea.addClass('tinyApplied');
            tinymce.init(w);
            textarea.data('getValue', function(){
                return tinymce.get('tplcontent').getContent()
            })
        }

        function loadSrcEditor(){
            var textarea = $('#tplcontent'),
                acetor = ace.edit('tplcontent-ace');

            acetor.setTheme("ace/theme/chrome");
            acetor.getSession().setMode("ace/mode/smarty");
            acetor.setOptions({
                minLines: 15,
                maxLines: 9999,
                highlightActiveLine: false
            });

            textarea.data('ace', true)
            textarea.data('aceeditor', acetor);
            acetor.getSession().setValue(textarea.val())

            textarea.closest('form').on('submit', function () {
                console.log('submit ace')
                textarea.val(acetor.getValue());
            })

            textarea.data('getValue', function(){
                return acetor.getValue();
            })
        }


        function previewTemplate() {
            var template = $('#tplcontent');

            $('#preview_content').val(template.data('getValue')());
            $('#preview_meta').val($('input.metadata').serialize());
            $('#previewform').submit();
            return false;
        }

        var popup;
        function previewPopup(){
            var template = $('#tplcontent'),
                form = $('#previewform');

            if ((popup == null) || (popup.closed)){
                popup = window.open('about:blank', 'Preview')
                template.data('aceeditor').commands.addCommand({
                    name: 'saveFile',
                    bindKey: {
                        win: 'Ctrl-S',
                        mac: 'Command-S',
                        sender: 'editor|cli'
                    },
                    exec: function(env, args, request) {
                        previewPopup();
                    }
                });
            }

            $('#preview_meta').val($('input.metadata').serialize());
            $('#preview_content').val(template.data('getValue')());

            form.attr('target', 'Preview')
                .attr('action',  form.attr('action').replace('&inline=1', '') + '&inline=1');

            form.submit();
        }

        function switchVariableGroup(el) {
            var v = $(el).val();
            $('optgroup', '#tpl_variables').hide().eq(0).show();
            $('#og_' + v, '#tpl_variables').show();

            $('#tpl_variables').val(0);
        }

        function switchVariable(el) {
            var v = $(el).val();
            if (v == 0)
                return;
            $('#var-container').val(v);
            $('#variable-box').show();
        }

        $(function () {
            $('#var-container').on('click', function(){
                this.select() || this.setSelectionRange(0, this.value.length);
                document.execCommand('copy');
            });
        })

    </script>
    <style>
        .mceIframeContainer{
            height: 100%;
        }
    </style>
{/literal}
<form id="previewform" target="_blank" method="post"
      action="?cmd=configuration&action=invoicetemplates&make=preview">
    <input type="hidden" name="content" id="preview_content" value=""/>
    <input type="hidden" name="metadata" id="preview_meta" value=""/>
    <input type="hidden" name="target" value="{$template.target}"/>
    {securitytoken}
</form>
{if !$mbstring}
    <div class="alert alert-danger">
        <strong>Note: Your PHP is missing mbstring extension - PDF generation will not work.</strong>
    </div>
{/if}


<form action="" method="post" id="invoiceeditform" style="padding: 10px 0">
    <input type="hidden" name="template_id" value="{$template.id}"/>
    <input type="hidden" name="target" value="{$template.target}"/>
    <input type="hidden" name="name" value="{$template.name}"/>
    <input type="hidden" name="content_id" value="{$template.content_id}"/>
    <input type="hidden" name="make" value="edit"/>


    <div class="container-fluid">

        {if $errors}
            <div class="alert alert-danger">
                <p><strong>There are errors with template that prevent PDF generation.</strong></p>
                {foreach from=$errors item=error}
                    <p>{$error}</p>
                {/foreach}
            </div>
        {/if}
        {if $isinclusivewarning}
            <div class="alert alert-warning">
                <p>You are using <strong>inclusive</strong> tax setting. Do not use <code>{literal}{$item.linetotal}{/literal}</code> as it will be estimation and totals may not match</p>
                {foreach from=$errors item=error}
                    <p>{$error}</p>
                {/foreach}
            </div>
        {/if}

        {if !$systemtemplate}
            <div class="form-group">
                <label>Template name</label>
                <input type="text" name="name" value="{$template.name}" size="30" class="form-control"/>
            </div>
            {else}
            <div class="form-group">
                <label>Template for: {$template.name} </label>
            </div>
        {/if}

        <div class="row">

            {if $editor_type == 'wysiwyg'}
            <div class="form-group col-lg-8" style="max-width: 210mm;">
                <div style="width: 100%; padding-bottom: 150%; position: relative;">
                    <div style="position: absolute; top: 0; bottom: 0; left: 0; right: 0;">
                        <textarea name="content" id="tplcontent"
                                  style="width:100%;height:100%;">{$template.content}</textarea>

                    </div>
                </div>
                <script>appendLoader('loadWYSIWYG');</script>
            </div>
            {else}
                <div class="form-group col-lg-8" >
                   <textarea name="content" id="tplcontent"
                             style="width:100%;height:100%; display: none;">{$template.content}</textarea>
                    <div class="ace-editor-wy" id="tplcontent-ace" style="display: block"></div>
                    <script>appendLoader('loadSrcEditor');</script>
                </div>
            {/if}

            <div class="form-group col-lg-4">
                {if $vars}
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Template variables
                            <span class="vtip_description">
                                <span>
                                    Variables will be replaced by actual values when document is
                                    displayed/downloaded.<br/>
                                    I.e. {literal}{$client.firstname}{/literal} will be replaced with client name
                                </span>
                            </span>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <select class="form-control" onchange="switchVariable(this);"
                                        id="tpl_variables">
                                    <option value="0">---</option>
                                    {foreach from=$vars item=v key=k}
                                        <optgroup label="{if $lang[$k]}{$lang[$k]}{else}{$k}{/if}">
                                            {foreach from=$v item=i key=kk}
                                                <option value="{$kk}" class="opt_{$k}">{$i}</option>
                                            {/foreach}
                                        </optgroup>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group" id="variable-box" style="display:none">
                                <label class="fs11">Copy & paste to template:</label>
                                <textarea  readonly id="var-container"  class="form-control" ></textarea>
                            </div>
                        </div>
                    </div>

                {elseif $template.target == 'attachment'}
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            How to attach pdf to your emails:
                        </div>
                        <div class="panel-body">
                          To attach pdf with contents of this template use:<br/>
                            <code>{literal}{{/literal}attachment template={$template.id}{literal} name='yourfile.pdf'}{/literal}</code><br/>

                            in your <a href="?cmd=emailtemplates" target="_blank">email template</a>.<br/><br/>
                            You can use same variable as in email template you will be attaching to. Refer to <a href="https://hostbill.atlassian.net/wiki/spaces/DOCS/pages/492052/Email+templates+Email+template+attachment" target="_blank" rel="noreferrer nofollow noopener">documentation</a> to learn how to assign additional variables to your templates

                        </div>
                    </div>
                {/if}

                {if $template.target == 'invoice' || $template.target == 'estimate' || $template.target == 'creditnote' || $template.target =='creditreceipt'}
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Advanced features
                        </div>
                        <div class="panel-body">
                            <div class="form-group" >
                                <label > <input type="checkbox" class="metadata" name="metadata[noparse]" value="1" {if $template.metadata.noparse}checked="checked"{/if}/> Disable auto-parsing
                                    <span class="vtip_description">
                                <span>
                                    When auto-parsing is on (by default) HostBill looks for <code>{literal}{$item}{/literal}</code>  and wraps them automatically with foreach.<br/>
                                   Auto-parsing feature may break some of your template smarty logic and escape smarty tags in html attributes, once its disabled you should add your foreach loops explicitly.
                                </span>
                            </span>
                                </label>
                            </div>
                        </div>
                    </div>
                {/if}
                <div>
                    <a class="btn btn-default" href="#" onclick="return previewTemplate();">
                        <i class="fa fa-search"></i>
                        {$lang.Preview}
                    </a>
                    <a class="btn btn-success" href="#"
                       onclick="$('#invoiceeditform').submit();return false;">
                        {$lang.savechanges}
                    </a>
                    <span class="orspace fs11">{$lang.Or}</span>
                    <a href="?cmd=configuration&action=invoicetemplates"
                       onclick="window.history.go(-1); return false;"
                       class="fs11 editbtn">{$lang.Cancel}</a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <span class="fs11">
                    HTML & CSS allowed. You can change editor type in
                    <a href="?cmd=configuration&picked_tab=6&picked_subtab=2">Settings &raquo; Other &raquo; Admin Portal</a>

                </span>
            </div>
        </div>
    </div>


    {securitytoken}
</form>