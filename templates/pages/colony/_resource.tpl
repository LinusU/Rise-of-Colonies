
<section class="building">
    
    {include file="pages/colony/_building.tpl"}
    
    <table>
        
        <colgroup>
            <col style="width: 192px;" />
            <col style="width: auto;" />
        </colgroup>
        
        <tr>
            <td>Current production</td>
            <td><b>{$building->capacity * server::speed('resource')}</b> per hour</td>
        </tr>
        {$building->lvlUp()}
        <tr>
            <td>Production on next level</td>
            <td><b>{$building->capacity * server::speed('resource')}</b> per hour</td>
        </tr>
        {$building->lvlDown()}
    </table>
    
</section>
