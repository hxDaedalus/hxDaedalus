package hxDaedalus.canvas;

abstract AlphaColorJS( Int ) from Int to Int
{
    @:to public inline function toString(): String {
        return '#' + StringTools.hex( this, 8 );
    }
}