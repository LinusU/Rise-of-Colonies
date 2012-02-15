
<section class="info">
    
    <div class="subinfo" style="float: left;">
        <div><a href="/map/"><span class="icon map"></span> Map</a></div>
        <div><a href="/colony/{$colony->id}/"><span class="icon map"></span> {$colony->title}</a></div>
    </div>
    
    <div class="subinfo" style="float: right; margin-left: 12px;">
        <div{if $colony->maxPopulation() <= $colony->population} class="warning"{/if}><span class="icon population"></span>  {$colony->population}/{$colony->maxPopulation()}</div>
    </div>
    
    <div class="subinfo" style="float: right;">
        <div{if $colony->storageCapacity() == $colony->r_wood} class="warning"{/if}><span class="icon wood"></span>  {$colony->r_wood|floor}</div>
        <div{if $colony->storageCapacity() == $colony->r_stone} class="warning"{/if}><span class="icon stone"></span> {$colony->r_stone|floor}</div>
        <div{if $colony->storageCapacity() == $colony->r_iron} class="warning"{/if}><span class="icon iron"></span>  {$colony->r_iron|floor}</div>
    </div>
    
</section>
