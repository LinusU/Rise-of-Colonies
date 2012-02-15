
<section class="building">
    
    {include file="pages/colony/_building.tpl"}
    
    {if count($queue)}
    <table style="margin-bottom: 24px;">
        
        <colgroup>
            <col style="width: 192px;" />
            <col style="width: 96px;" />
            <col style="width: 160px;" />
            <col style="width: auto;" />
        </colgroup>
        
        <tr>
            <th>Unit</th>
            <th>Duration</th>
            <th>Completion</th>
            <th>Abortion</th>
        </tr>
        
        {foreach from=$queue name=queue item=q}
        {$u=unit::__callStatic($q->type, array($q->subtype))}
        <tr>
            <td>{$q->qty} {$u->title}</td>
            <td>{if $smarty.foreach.queue.first}<time datetime="{$q->end|date}" class="duration">{($q->end-$now)|duration}</time>{else}{($q->end-$q->start)|duration}{/if}</td>
            <td><time datetime="{$q->end|date}">{$q->end|date}</time></td>
            <td><a href="abort/{$q->id}/">Abort</a></td>
        </tr>
        {/foreach}
        
    </table>
    {/if}
    
    <form action="recruit/" method="post">
        <table>
            
            <colgroup>
                <col style="width: 192px;" />
                <col style="width: 64px;" span="4" />
                <col style="width: 96px;" />
                <col style="width: 128px;" />
                <col style="width: auto;" />
            </colgroup>
            
            <tr>
                <th>Unit</th>
                <th colspan="4">Cost</th>
                <th>Duration</th>
                <th>Current</th>
                <th>Recruit</th>
            </tr>
            
            {foreach from=$units key=key item=u}
            <tr style="height: 24px;">
                <td><a href="/help/{$key}/">{$u->title}</a></td>
                <td><span class="icon wood"></span> {$u->wood}</td>
                <td><span class="icon stone"></span> {$u->stone}</td>
                <td><span class="icon iron"></span> {$u->iron}</td>
                <td><span class="icon population"></span> {$u->population}</td>
                <td>{($u->duration*$building->timefactor()/server::speed('training'))|duration}</td>
                <td>{$colony->__get("u_{$key}")}</td>
                <td>{if $colony->canAfford($u)}<input type="number" name="train[{$key}]" min="0" value="0" max="{$colony->canAfford($u)}" />{else}Not enough resources{/if}</td>
            </tr>
            {/foreach}
            
        </table>
        
        <p style="text-align: right;">
            <input type="submit" value="Recruit" />
        </p>
        
    </form>
    
</section>
