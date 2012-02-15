
<section class="building">
    
    {include file="pages/colony/_building.tpl"}
    
    <table>
        
        <colgroup>
            <col style="width: 192px;" />
            <col style="width: auto;" />
        </colgroup>
        
        <tr>
            <td>Current capacity</td>
            <td><b>{$building->capacity}</b></td>
        </tr>
        {$building->lvlUp()}
        <tr>
            <td>Capacity on next level</td>
            <td><b>{$building->capacity}</b></td>
        </tr>
        {$building->lvlDown()}
    </table>
    
</section>
