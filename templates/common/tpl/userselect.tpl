<!DOCTYPE html>
<html lang="{$html_lang}" dir="{$language_direction}" class="loading">
<head>
    <base href="{$system_url}"/>
    <meta charset="utf-8">
    <base href="{$system_url}"/>
    <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
    <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap.min.css"/>
    <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/main.css"/>
    <!--[if lt IE 9]>
            <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/ie8.css" />
            <script type="text/javascript" src="{$template_dir}js/ie8.js"></script>
            <![endif]-->
    <script type="text/javascript" src="{$template_dir}js/jquery.js"></script>
    <script type="text/javascript" src="{$template_dir}js/bootstrap.min.js"></script>
    <script type="text/javascript" src="{$template_dir}js/common.min.js"></script>
    <script type="text/javascript" src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="templates/common/js/userselect.js"></script>
    {literal}
        <style>
            .flex {
                display: flex;
                width: 480px;
                height: 100vh;
                align-items: stretch;
                justify-content: center;
                flex-direction: column;
                margin: auto;
            }
            .user-select-box {
                margin: 20px 0 0!important;
            }
            .user-select-box > .wbox{
                margin: 0;
            }
            .user-select{
                list-style: none;
                margin: -10px -19px 0;
                padding: 0;
                max-height: 400px;
                overflow: auto;
            }

            .user-select-item a{
                text-decoration: none;
                color: inherit;
                padding: 10px 15px;
                border-bottom: 1px solid #c0c0c0;
                display: block;
            }
            .user-select-item:last-child a{
                border-bottom: none;
            }
            .user-select-item:last-child:first-child a{
                border-bottom: none;
            }
            .user-select-item .icon{
                margin-top: 12px;
            }
            footer{
                margin-top: 0px;
                border-top: none;
            }
            .user-search{
                position: relative;
                padding: 10px 10px 10px 0;
                margin-bottom: 10px;
                margin-top: -20px;
            }
            .user-search-input{
                width: calc(100% - 25px);
                padding-right: 25px!important;
            }
            .user-search-icon {
                position: absolute;
                top: 16px;
                right: 8px;
                pointer-events: none;
            }
            .user-name {
                font-weight: bold;
            }
            .user-none{
                display: none;
                padding: 0px 20px 20px;
            }
            .highlight{
                background-color: yellow;
            }
        </style>

    {/literal}
    {userheader}
</head>

<body class="{$language|capitalize} tpl_nextgen">
<div class="flex">
    <h1>{$business_name}</h1>
    <div class="user-select-box">
        <div class="wbox">
            <div class="wbox_header">
                {$lang.welcomeback} {$login.firstname} {$login.lastname}
            </div>
            <div class="wbox_content">
                {if $action === 'accept'}
                    <form action="" method="post">
                        <p>{$lang.user_invite_text|sprintf:$parent_name}</p>
                        <button type="submit" value="1" name="confirm" class="btn btn-primary">Accept</button>
                        <button type="submit" value="0" name="confirm" class="btn btn-default">Reject</button>
                        {securitytoken}
                    </form>
                {else}
                <div class="alert alert-info">{$lang.switch_user_select}</div>
                <div class="user-search">
                    <input type="text" class="user-search-input" autocomplete="off" />
                    <span class="user-search-icon icon icon-search fa fa-search"></span>
                </div>
                <ul class="user-select">
                    {foreach from=$users item=user}
                        <li class="user-select-item">
                            <a href="{$ca_url}login/select/{$user.parent_id}&security_token={$security_token}">
                                <i class="icon icon-chevron-right pull-right"></i>
                                <div class="user-name">{$user.parent_details|@client}</div>
                                <small class="muted">{$lang.client_number}
                                    <span class="user-id">{$user.parent_details.id}</span>
                                </small>
                            </a>
                        </li>
                    {/foreach}
                </ul>
                {/if}
            </div>
            <div class="user-none muted">
                {$lang.nothing}
            </div>
        </div>
        <footer>
            <span class="left">&copy; {$smarty.now|date_format:"%Y"} {$business_name}</span>
            <span class="right">
                <a href="?action=logout">{$lang.logout}</a>
            </span>
            {userfooter}
        </footer>
    </div>
</body>
</html>