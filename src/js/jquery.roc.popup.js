
(function ($, window, document, undefined) {
    
    var pluginName = 'popup',
        defaults = {
            url: "",
            width: 320
        };
    
    function Plugin( element, options ) {
        this.element = element;
        this.options = $.extend({ }, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.init();
    }

    Plugin.prototype.init = function () {
        
        this.popup = $('<div class="jquery-roc-popup" />')
            .appendTo('body')
            .load(this.options.url)
            .css({
                width: this.options.width
            });
        
        this.update();
        
    };
    
    Plugin.prototype.update = function () {
        this.popup.position({
            my: 'center top',
            at: 'center bottom',
            of: this.element,
            offset: "0 12",
            collision: "none flip"
        });
    };
    
    Plugin.prototype.destroy = function () {
        this.popup.remove();
        $.data(this.element, 'plugin_' + pluginName, null);
    };
    
    $.fn[pluginName] = function (options) {
        return this.each(function () {
            if(typeof options == 'string') {
                var plugin = $.data(this, 'plugin_' + pluginName);
                plugin[options].apply(plugin, Array.prototype.slice.call(arguments, 1));
            } else {
                if(!$.data(this, 'plugin_' + pluginName)) {
                    $.data(this, 'plugin_' + pluginName, new Plugin( this, options ));
                }
            }
        });
    }
    
})( jQuery, window, document )