package hxDaedalus.canvas;
import haxe.macro.Compiler;
class CanvasHeader{
    
    public var width: Int;
    public var height: Int;
    public var frameRate: Int;
    public var bgColor: String;
    
    @static inline function parseInt( e: String ): Int return Std.parseInt( e );
    @static inline function toHashColor( e: String ): String return '#'+ e;
    
    public function new()
    {
        var canvasHeader = Compiler.getDefine("canvasHeader").split(':');//-D -canvas-header 600:400:60:FFFFFF
        width = parseInt( canvasHeader[0] );
        height = parseInt( canvasHeader[1] );
        frameRate = parseInt( canvasHeader[2] );
        bgColor = toHashColor( canvasHeader[3] );
    }
    
}