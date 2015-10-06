package wings.core;

#if flambe
typedef SimpleDrawingContext = wings.flambe.SimpleDrawingContext;
#elseif format
typedef SimpleDrawingContext = wings.pixel.SimpleDrawingContext;
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
