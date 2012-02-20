
<div class="building">
    {if $building->lvl > 11}
    <img src="{"img/colony/"|cat:$building->type|cat:"3.png"|cdn}" style="float: left;" />
    {elseif $building->lvl > 4}
    <img src="{"img/colony/"|cat:$building->type|cat:"2.png"|cdn}" style="float: left;" />
    {elseif $building->lvl > 0}
    <img src="{"img/colony/"|cat:$building->type|cat:"1.png"|cdn}" style="float: left;" />
    {/if}
    
    <h1>{$building->title} (Lvl. {$building->lvl})</h1>
</div>

<hr />
