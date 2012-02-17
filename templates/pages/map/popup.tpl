
{if $colony->population > 500}
<img src="{"img/map/v2.png"|cdn}" style="float: left; margin: 12px;" />
{else}
<img src="{"img/map/v1.png"|cdn}" style="float: left; margin: 12px;" />
{/if}

<h3>{$colony}</h3>

<p>
    &nbsp;
</p>

<p style="text-align: center; margin-top: 128px;">
    {if $colony->user_id == $pageUser->id}
    <button onclick="window.location.href='/colony/{$colony->id}/';">Go to village</button>
    {else}
    <button>Send troops</button>
    {/if}
    <button style="margin-left: 32px;">Send resources</button>
</p>
