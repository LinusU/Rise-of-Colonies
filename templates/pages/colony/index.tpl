
<map id="map" name="map">
    {*if $colony->b_main}
    <area shape="poly" coords="556,186,463,170,450,97,478,38,569,29,634,63,635,128" href="main/" title="Headquarter" />
    {/if}
    {if $colony->b_storage}
    <area shape="poly" coords="197,227,221,193,221,157,183,115,142,114,101,122,58,135,49,181,59,206,104,220,149,231,170,229" href="storage/" title="Storage" />
    {/if}
    {if $colony->b_barracks}
    <area shape="poly" coords="566,195,608,160,657,170,682,184,684,218,672,256,616,272,583,266,556,258,549,216" href="barracks/" title="Barracks" />
    {/if}
    {if $colony->b_stone}
    <area shape="poly" coords="0,479,131,479,149,443,143,416,125,404,90,379,38,355,0,362" href="stone/" title="Clay pit" />
    {/if}
    {if $colony->b_stable}
    <area shape="poly" coords="147,394,184,359,217,325,197,287,126,254,47,276,44,346" href="stable/" title="Stable" />
    {/if}
    {if $colony->b_smith}
    <area shape="poly" coords="153,409,166,382,215,342,267,361,289,377,278,427,235,457,181,446" href="smith/" title="Smithy" />
    {/if}
    {if $colony->b_iron}
    <area shape="poly" coords="0,0,0,132,56,129,131,109,154,59,152,0" href="iron/" title="Iron mine" />
    {/if}
    {if $colony->b_farm}
    <area shape="poly" coords="812,0,814,102,857,134,905,144,959,217,959,0" href="farm/" title="Farm" />
    {/if}
    <area shape="poly" coords="781,427,866,373,937,385,959,411,959,479,832,479" href="wood/" title="Timber Camp" />
    <area shape="poly" coords="796,409,774,360,736,338,672,346,640,371,640,409,674,435,720,439,765,429" href="garage/" title="Workshop" />
    <area shape="poly" coords="223,335,273,357,309,352,318,333,321,303,316,272,286,258,249,269,231,328" href="statue/" title="Statue" />
    *}
    
    <area shape="poly" coords="556,186,474,173,489,109,493,56,569,29,634,63,635,128" href="main/" />
    <area shape="poly" coords="197,227,222,189,202,164,183,115,142,114,101,122,58,135,49,181,59,206,104,220,149,231,170,229" href="storage/" />
    <area shape="poly" coords="566,195,608,160,657,170,682,184,684,218,672,256,616,272,583,266,556,258,549,216" href="barracks/" />
    <area shape="poly" coords="0,479,131,479,149,443,143,416,125,404,90,379,38,355,0,362" href="stone/" />
    <area shape="poly" coords="147,394,184,359,217,325,197,287,126,254,47,276,44,346" href="stable/" />
    <area shape="poly" coords="153,409,166,382,215,342,267,361,289,377,278,427,235,457,181,446" href="smith/" />
    <area shape="poly" coords="0,0,0,132,56,129,131,109,154,59,152,0" href="iron/" />
    <area shape="poly" coords="812,0,814,102,857,134,905,144,959,217,959,0" href="farm/" />
    <area shape="poly" coords="781,427,866,373,937,385,959,411,959,479,832,479" href="wood/" />
    <area shape="poly" coords="796,409,774,360,736,338,672,346,640,371,640,409,674,435,720,439,765,429" href="garage/" />
    <area shape="poly" coords="223,335,273,357,309,352,318,333,321,303,316,272,286,258,249,269,231,328" href="statue/" />
    <area shape="poly" coords="219,203,229,185,208,156,252,130,285,130,328,180,308,221,269,241,233,231" href="market/" />
    <area shape="poly" coords="291,246,321,230,333,188,378,198,397,211,401,279,355,298,328,299,321,265" href="place/" />
    <area shape="poly" coords="427,135,478,133,480,109,484,56,416,29,390,59,397,107" href="hide/" />
    <area shape="poly" coords="188,113,204,154,250,128,253,105,253,58,227,43,197,43,161,59" href="snob/" />
    
</map>

<section class="colony">
    
    {if $colony->b_main > 11}
    <img class="b_mainflag" src="{"img/colony/mainflag3.gif"|cdn}" />
    {elseif $colony->b_main > 4}
    <img class="b_mainflag" src="{"img/colony/mainflag2.gif"|cdn}" />
    {elseif $colony->b_main > 0}
    <img class="b_mainflag" src="{"img/colony/mainflag1.gif"|cdn}" />
    {elseif false}{* constructing *}
    <img class="b_mainflag" src="{"img/colony/mainflag0.gif"|cdn}" />
    {/if}
    
    {foreach from=$buildings item=b}
    {if $b->lvl > 11}
    <img class="b_{$b->type}" src="{"img/colony/{$b->type}3.png"|cdn}" />
    {elseif $b->lvl > 4}
    <img class="b_{$b->type}" src="{"img/colony/{$b->type}2.png"|cdn}" />
    {elseif $b->lvl > 0}
    <img class="b_{$b->type}" src="{"img/colony/{$b->type}1.png"|cdn}" />
    {elseif false}{* constructing *}
    <img class="b_{$b->type}" src="{"img/colony/{$b->type}0.gif"|cdn}" />
    {/if}
    {/foreach}
    
    <img class="b_empty" src="data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" usemap="#map" />
    
</section>
