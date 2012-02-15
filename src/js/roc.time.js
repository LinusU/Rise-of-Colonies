
$(function () {
    
    var update = [];
    
    $('time.duration').each(function () {
        var to = Date.parse($(this).attr('datetime'));
        update.push([$(this), to]);
    });
    
    setInterval(function () {
        var reloading = false;
        var now = (new Date()).getTime();
        $.each(update, function () {
            var seconds = Math.ceil((this[1] - now) / 1000);
            if(seconds <= 0) {
                this[0].text("Now");
                if(!reloading) { reloading = setTimeout(function () { window.location.reload(); }, 1000); }
            } else {
                var s = seconds % 60;
                var m = Math.floor(seconds / 60) % 60;
                var h = Math.floor(seconds / 3600);
                this[0].text( h + ":" + (m<10?"0"+m:m) + ":" + (s<10?"0"+s:s) );
            }
        });
    }, 1000);
    
});
