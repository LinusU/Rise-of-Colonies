<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title>Rise of Colonies</title>
    <!--link rel="shortcut icon" href="{"favicon.png"|cdn}" /-->
    <link rel="stylesheet" type="text/css" href="/dev/css" />
    <script type="text/javascript" src="{"jquery-1.7.1.min.js"|cdn}"></script>
    <script type="text/javascript">
        
        $.holdReady(true);
        
        $.ajax({
            cache: true,
            dataType: 'script',
            url: "/dev/js",
            success: function() { $.holdReady(false); }
        });
        
        function cdn(url) {
            return "{""|cdn}" + url;
        }
        
        window.roc = {
            user_id: {if $pageUser}{$pageUser->id}{else}false{/if}
        };
        
    </script>
    <!--[if lt IE 9]>
    <script type="text/javascript">
        
        window.isie = true;
        
        'abbr article aside audio canvas details figcaption figure footer header hgroup mark meter nav output progress section summary time video'.replace(/\w+/g,function(n){ document.createElement(n);});
        
    </script>
    <!--link rel="stylesheet" type="text/css" href="{"ie678.css"|cdn}" /-->
    <![endif]-->
    <meta name="viewport" content="user-scalable=no, width=1024" />
</head>
<body>
<header>
    {if $pageUser}
    <nav>
        <a href="/account/">{$pageUser}</a>
        <a href="/logout/">Log out</a>
    </nav>
    {else}
    <nav>
        <a href="/">Home</a>
        <a href="/register/">Register an account</a>
    </nav>
    {/if}
</header>
<div id="site">