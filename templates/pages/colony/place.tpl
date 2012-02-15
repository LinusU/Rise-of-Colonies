
<section class="building">
    
    {include file="pages/colony/_building.tpl"}
    
    <table>
        
        <colgroup>
            <col style="width: 192px;" />
            <col style="width: auto;" />
        </colgroup>
        
        {foreach from=unit::$data key=b item=val}
        <tr>
            {$b=$colony->building($b)}
            <th colspan="2"><br />{$b->title} (Lvl. {$b->lvl})</th>
        </tr>
        {foreach from=$val key=key item=item}
        <tr>
            <td>{$item->title}</td>
            <td><b>{$colony->__get("u_{$key}")}</b></td>
        </tr>
        {/foreach}
        {/foreach}
        
    </table>
    
</section>
