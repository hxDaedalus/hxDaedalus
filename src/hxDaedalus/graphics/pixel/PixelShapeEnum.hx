package hxDaedalus.graphics.pixel;
//http://members.chello.at/~easyfilter/bresenham.html
enum PixelShapeEnum {
    ECircle( circle: PixelCircle );
    ELine( line: PixelLine );
    EQuadratic( quatratic: PixelQuadratic );
    ETriangle( triangle: PixelTriangle );
    ERectangle( rectangle: PixelRectangle );
    ENull( );
}
