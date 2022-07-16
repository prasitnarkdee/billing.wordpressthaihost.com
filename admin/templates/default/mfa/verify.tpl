<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes"/>
    {adminwidget module="login" section="meta" wrapper=""}
    <title>{$theme_vars.AdminCustomTitle}HostBill - {$business_name} </title>
    <link href="{$template_dir}dist/stylesheets/application.css?v={$hb_version}" rel="stylesheet" media="all"/>
    {if $theme_vars.AdminFavicon}
        <link rel="icon" href="{$theme_vars.AdminFavicon}" type="image/png">
    {/if}
    <script type="text/javascript" src="{$template_dir}js/jquery.js?v={$hb_version}"></script>
    {literal}
    <style>
        html, body {
            min-height: 100%;
            position: relative;
        }
        .lighterblue {
            background: #EBF3FF;
        }
        img.key {
            max-width: 100%;
            max-height: 150px;
            margin: 25px auto;
            display: block;
        }
    </style>
    {/literal}
</head>
<body>
<div class="login-box">
    <img src="{$system_url}{$theme_vars.AdminLogoPath}" style="margin-bottom:10px;width:109px"/>
    <div style=" padding:2px;margin-bottom:4px;background:#ffffff;" class="box">
        {if $error}
            <div class="lighterblue" style="padding:15px;">
                {foreach from=$error item=err}
                    <div style="margin: 5px 0; color: red;">{$err}</div>
                {/foreach}
            </div>
        {/if}
        <div style="padding:15px;">
            {include file=$formtpl}
        </div>
        <div class="lighterblue" style="padding:15px;">
            <a href="?cmd=root&action=logout">Logout</a>
        </div>
    </div>
    <div style="text-align:right;">
        <small>Powered by <a href="http://hostbillapp.com" target="_blank">HostBill</a></small>
    </div>
</div>
</body>
</html>