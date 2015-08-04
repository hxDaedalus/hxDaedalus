package wings.jsCanvas;

abstract ColorJS( Int ) from Int to Int
{
    @:to public inline function toString(): String {
        return '#' + StringTools.hex( this, 6 );
    }
}
