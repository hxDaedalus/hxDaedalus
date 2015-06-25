package hxDaedalus.graphics;

#if format
typedef SimpleDrawingContext = hxDaedalus.graphics.pixel.SimpleDrawingContext;
#elseif flambe
typedef SimpleDrawingContext = hxDaedalus.graphics.flambe.SimpleDrawingContext;
#elseif (flash || openfl || nme)
typedef SimpleDrawingContext = hxDaedalus.graphics.flash.SimpleDrawingContext;
#elseif luxe
typedef SimpleDrawingContext = hxDaedalus.graphics.luxe.SimpleDrawingContext;
#elseif svg
typedef SimpleDrawingContext = hxDaedalus.graphics.svg.SimpleDrawingContext;
#elseif js
typedef SimpleDrawingContext = hxDaedalus.graphics.js.SimpleDrawingContext;
#elseif java
typedef SimpleDrawingContext = hxDaedalus.graphics.swing.SimpleDrawingContext;
#end
