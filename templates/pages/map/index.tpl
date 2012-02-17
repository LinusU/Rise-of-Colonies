
{include file="pages/colony/top.tpl"}

<section class="map"></section>

<script type="text/javascript">
    $(function () {
        
        var $map = $('section.map');
        var $inner = $('<div />').appendTo($map);
        
        var $popup = false;
        
        $map.css({
            position: 'relative',
            overflow: 'hidden',
            width: 960,
            height: 480
        });
        
        $inner.css({
            position: 'absolute',
            width: 320 * 20,
            height: 240 * 20,
            left: -160 * 20 + 480,
            top: -120 * 20 + 240
        });
        
        var loaded = {};
        
        function loadTile(x, y) {
            
            if(loaded[x + "," + y]) {
                return ;
            }
            
            loaded[x + "," + y] = true;
            
            var $tile = $('<div />');
            
            $tile.css({
                background: "url({"img/map/bg.png"|cdn})",
                position: 'absolute',
                width: 320 - 1,
                height: 240 - 1,
                left: (x + 10) * 320,
                top: (y + 10) * 240,
                borderTop: '1px solid #060',
                borderLeft: '1px solid #060'
            });
            
            if(x == 0) { $tile.css('borderLeftColor', 'black'); }
            if(y == 0) { $tile.css('borderTopColor', 'black'); }
            
            $.ajax({
                url: x + '/' + y + '/',
                success: function (data) {
                    
                    $.each(data, function (i, colony) {
                        ( colony.population > 500 ? $('<img src="{"img/map/v2.png"|cdn}" />') : $('<img src="{"img/map/v1.png"|cdn}" />') )
                            .appendTo($tile)
                            .css({
                                position: 'absolute',
                                left: (colony.x - x * 5) * 64,
                                top: (colony.y - y * 5) * 48,
                                width: 64, height: 48,
                                cursor: 'pointer'
                            })
                            .on('click', function () {
                                if($popup) { $popup.popup('destroy'); }
                                $popup = $(this).popup({ url: "/map/popup/" + colony.colony_id + "/" });
                            });
                    });
                    
                    $tile.appendTo($inner);
                }
            });
            
            return $tile;
        }
        
        function loadCurrent() {
            
            var cbx = Math.round(cx / 320);
            var cby = Math.round(cy / 240);
            
            loadTile(cbx-2, cby-2);
            loadTile(cbx-1, cby-2);
            loadTile(cbx+0, cby-2);
            loadTile(cbx+1, cby-2);
            
            loadTile(cbx-2, cby-1);
            loadTile(cbx-1, cby-1);
            loadTile(cbx+0, cby-1);
            loadTile(cbx+1, cby-1);
            
            loadTile(cbx-2, cby+0);
            loadTile(cbx-1, cby+0);
            loadTile(cbx+0, cby+0);
            loadTile(cbx+1, cby+0);
            
            loadTile(cbx-2, cby+1);
            loadTile(cbx-1, cby+1);
            loadTile(cbx+0, cby+1);
            loadTile(cbx+1, cby+1);
            
        }
        
        var cx = 0, cy = 0;
        var dragging = false, sx, sy;
        
        $inner.on('mousedown', function (e) {
            e.preventDefault();
            dragging = true;
            sx = e.screenX;
            sy = e.screenY;
        });
        
        $(document).on('mousemove', function (e) {
            if(!dragging) { return ; }
            e.preventDefault();
            $inner.css({
                left: '+=' + (e.screenX - sx),
                top: '+=' + (e.screenY - sy)
            });
            cx -= (e.screenX - sx);
            cy -= (e.screenY - sy);
            sx = e.screenX;
            sy = e.screenY;
            loadCurrent();
            if($popup) { $popup.popup('update'); }
        });
        
        $(document).on('mouseup', function (e) {
            if(!dragging) { return ; }
            e.preventDefault();
            dragging = false;
        });
        
        loadCurrent();
        
    });
</script>
