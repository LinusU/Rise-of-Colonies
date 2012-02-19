
{include file="pages/colony/top.tpl"}

<section class="map-view zoom-4"></section>

<script type="text/javascript">
    $(function () {
        
        var $map = $('section.map-view');
        var $inner = $('<div class="map-inner" />').appendTo($map);
        var $zoom = $('<div class="map-zoom" />').appendTo($map);
        
        var $popup = false;
        
        $map.css({
            width: 960,
            height: 480
        });
        
        $inner.css({
            left: 480,
            top: 240
        });
        
        $zoom.append('<button>0</button><button>1</button><button>2</button><button>3</button><button>4</button>');
        
        $zoom.find('button').on('click', function () {
            $map.removeClass('zoom-0 zoom-1 zoom-2 zoom-3 zoom-4').addClass('zoom-' + $(this).index());
        });
        
        var loaded = {};
        
        function loadTile(x, y) {
            
            if(loaded[x + "," + y]) {
                return ;
            }
            
            loaded[x + "," + y] = true;
            
            var $tile = $('<div class="map-tile" />').append('<img src="{"img/map/bg.png"|cdn}" />');
            
            $tile.css({
                left: x * 100 + '%',
                top: y * 100 + '%'
            });
            
            if(x == 0) { $tile.css('borderLeftColor', 'black'); }
            if(y == 0) { $tile.css('borderTopColor', 'black'); }
            
            $.ajax({
                url: x + '/' + y + '/',
                success: function (data) {
                    
                    $.each(data, function (i, colony) {
                        
                        $('<div class="map-cell" />')
                            .addClass('type-' + colony.type)
                            .appendTo($tile)
                            .append($('<img />').attr('src', cdn("img/map/v" + (colony.points<300?1:(colony.points<1000?2:(colony.points<3000?3:(colony.points<9000?4:(colony.points<11000?5:6))))) + (colony.user_id>0?"":"_left") + ".png")))
                            .css({
                                left: (colony.x - x * 5) * 20 + '%',
                                top: (colony.y - y * 5) * 20 + '%',
                                backgroundColor: ( colony.user_id == window.roc.user_id ? 'white' : 'red' )
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
        var dragging = false, moved = false, sx, sy;
        
        $inner.on('mousedown', function (e) {
            e.preventDefault();
            dragging = true;
            sx = e.screenX;
            sy = e.screenY;
        });
        
        $(document).on('mousedown', function () {
            moved = false;
        });
        
        $(document).on('mousemove', function (e) {
            moved = true;
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
            if(!moved) {
                if($popup) { $popup.popup('destroy'); }
                $popup = false;
            }
            moved = false;
            if(!dragging) { return ; }
            e.preventDefault();
            dragging = false;
        });
        
        $(document).on('keyup', function (e) {
            if(e.which == 27 && $popup) {
                e.preventDefault();
                $popup.popup('destroy');
                $popup = false;
            }
        })
        
        loadCurrent();
        
    });
</script>
