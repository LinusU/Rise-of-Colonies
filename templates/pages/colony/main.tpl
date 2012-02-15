
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
            <th>Construction</th>
            <th>Duration</th>
            <th>Completion</th>
            <th>Abortion</th>
        </tr>
        
        {foreach from=$queue name=queue item=q}
        {$b=$colony->building($q->subtype, $q->qty)}
        <tr>
            <td>{$b->title} (Lvl. {$b->lvl})</td>
            <td>{if $smarty.foreach.queue.first}<time datetime="{$q->end|date}" class="duration">{($q->end-$now)|duration}</time>{else}{($q->end-$q->start)|duration}{/if}</td>
            <td><time datetime="{$q->end|date}">{$q->end|date}</time></td>
            <td><a href="abort/{$q->id}/">Abort</a></td>
        </tr>
        {/foreach}
        
    </table>
    {/if}
    
    <table>
        
        <colgroup>
            <col style="width: 192px;" />
            <col style="width: 64px;" span="4" />
            <col style="width: 96px;" />
            <col style="width: auto;" />
        </colgroup>
        
        <tr>
            <th>Building</th>
            <th colspan="4">Cost</th>
            <th>Duration</th>
            <th>Construct</th>
        </tr>
        
        {foreach from=$buildings_after key=key item=b}
        {$b->lvlUp()}
        <tr style="height: 24px;">
            <td>{if $buildings[$key]->lvl>0}<a href="/colony/{$colony->id}/{$b->type}/">{$b->title}</a> (Lvl. {$buildings[$key]->lvl}){else}{$b->title}{/if}</td>
            {if $b->lvl > $b->levels}
            <td colspan="5"></td>
            <td>Fully constructed</td>
            {elseif !$b->requirementsMet($buildings_after)}
            <td colspan="4"></td>
            <td colspan="2">
                Requires:
                {foreach from=$b->requirements name=req key=r item=lvl}{if !$smarty.foreach.req.first}, {/if}
                <img src="{"/img/buildings/$r.png"|cdn}" /> {$colony->building($r)->title} (Lvl. {$lvl}){/foreach}
            </td>
            {else}
            {$b->lvlDown()}
            {$pop=$b->population}
            {$b->lvlUp()}
            <td><span class="icon wood"></span> {$b->wood}</td>
            <td><span class="icon stone"></span> {$b->stone}</td>
            <td><span class="icon iron"></span> {$b->iron}</td>
            <td><span class="icon population"></span> {$b->population-$pop}</td>
            <td>{($b->duration*$buildings_after['main']->timefactor()/server::speed('building'))|duration}</td>
            <td>{if $colony->canAfford($b) && ($buildings_after['farm']->capacity-$colony->population) >= ($b->population-$pop)}<a href="/colony/{$colony->id}/main/build/{$b->type}/">{if $b->lvl==1}Construct{else}Expand to level {$b->lvl}{/if}</a>{else}Not enough resources{/if}</td>
            {/if}
        </tr>
        {$b->lvlDown()}
        {/foreach}
        
    </table>
    
</section>
