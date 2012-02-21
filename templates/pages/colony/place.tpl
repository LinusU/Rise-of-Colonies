
<section class="building">
    
    {include file="pages/colony/_building.tpl"}
    
    {if $target}
    <form action="?colony={$target->id}" method="post">
        
        <p>
            Target: {$target}
        </p>
        
        <table style="width: auto;">
            
            <colgroup>
                <col style="width: 128px;" />
                <col style="width: 64px;" />
                <col style="width: 96px;" />
            </colgroup>
            
            {foreach from=unit::$data key=b item=val}
            <tr>
                {$b=$colony->building($b)}
                <th colspan="3"><br />{$b->title} (Lvl. {$b->lvl})</th>
            </tr>
            {foreach from=$val key=key item=item}
            <tr>
                <td>{$item->title}</td>
                <td style="text-align: right;" onclick="$(this).parent().find('input').val()==parseInt($(this).text())?$(this).parent().find('input').val(0):$(this).parent().find('input').val(parseInt($(this).text()));">{$colony->__get("u_{$key}")}</td>
                <td style="text-align: right;"><input type="number" name="unit[{$b->type}][{$key}]" value="0" min="0" max="{$colony->__get("u_{$key}")}" style="text-align: right;" /></td>
            </tr>
            {/foreach}
            {/foreach}
            
        </table>
        
        <p style="text-align: center; width: 288px;">
            <input type="submit" name="attack" value="Attack" style="background: #F99;" />
            <input type="submit" name="assist" value="Assist" style="background: #9F9; margin-left: 32px;" />
        </p>
        
    </form>
    {else}
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
    {/if}
    
</section>
