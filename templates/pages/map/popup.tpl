
<div style="margin: 12px;">
    
    <img src="{"img/map/v{$img}.png"|cdn}" style="float: left; margin: 0px 12px 12px 0px; background-color: {if $mine}white{else}red{/if};" />
    
    <h3>{$colony}</h3>
    
    <table>
        <tr>
            <td>Points</td>
            <td>{$colony->points}</td>
        </tr>
        <tr>
            <td>Owner</td>
            <td>{if $owner}{$owner}{else}<i>abandond colony</i>{/if}</td>
        </tr>
    </table>
    
    <p style="text-align: center;">
        {if $mine}
        <button onclick="window.location.href='/colony/{$colony->id}/';">Go to colony</button>
        {else}
        <button onclick="window.location.href='/colony/{$pageUser->colony()->id}/place/?colony={$colony->id}'">Send troops</button>
        {/if}
        <button onclick="window.location.href='/colony/{$pageUser->colony()->id}/market/?colony={$colony->id}'" style="margin-left: 32px;">Send resources</button>
    </p>
    
</div>
