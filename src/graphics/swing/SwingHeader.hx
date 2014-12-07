package graphics.swing;
import haxe.macro.Compiler;

class SwingHeader{
    
    public var width: Int;
    public var height: Int;
    public var frameRate: Int;
    public var bgColor: Int;
    
    @static inline function parseInt( e: String ): Int return Std.parseInt( e );
    @static inline function toHashColor( e: String ): String return '#'+ e;
    
    public function new()
    {
        var swingHeader = Compiler.getDefine("canvasHeader").split(':');//-D swingHeader=600:400:60:FFFFFF
        //var swingHeader ='600:400:60:FFFFFF'.split(':');
        width = parseInt( swingHeader[0] );
        height = parseInt( swingHeader[1] );
        frameRate = parseInt( swingHeader[2] );
        bgColor = parseInt( swingHeader[3] );
    }
    
}