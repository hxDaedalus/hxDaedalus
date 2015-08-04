package wings.core;

#if format
typedef SimpleDrawingContext = wings.pixel.SimpleDrawingContext;
#elseif flambe
typedef SimpleDrawingContext = wings.flambe.SimpleDrawingContext;
#elseif (flash || openfl || nme)
typedef SimpleDrawingContext = wings.flash.SimpleDrawingContext;
#elseif luxe
typedef SimpleDrawingContext = wings.luxe.SimpleDrawingContext;
#elseif svg
typedef SimpleDrawingContext = wings.jsSvg.SimpleDrawingContext;
#elseif js
typedef SimpleDrawingContext = wings.jsCanvas.SimpleDrawingContext;
#elseif java
typedef SimpleDrawingContext = wings.javaSwing.SimpleDrawingContext;
#end
