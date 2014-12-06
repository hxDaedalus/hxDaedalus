package hxDaedalus.graphics;

#if (flash || openfl || nme) 
typedef SimpleDrawingContext = hxDaedalus.graphics.flash.SimpleDrawingContext;
#elseif js
typedef SimpleDrawingContext = hxDaedalus.graphics.js.SimpleDrawingContext;
#elseif java
typedef SimpleDrawingContext = hxDaedalus.graphics.swing.SimpleDrawingContext;
#end
