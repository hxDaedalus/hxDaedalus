/*
* Divtastic3
* Copyright (c) 2011 to 2013, Justinfront Ltd
* author: Justin L Mills
* email: JLM at Justinfront dot net
* created: 5 Dec 2012
* ported and update to haxe3: 2 April 2012
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
* * Redistributions of source code must retain the above copyright
* notice, this list of conditions and the following disclaimer.
* * Redistributions in binary form must reproduce the above copyright
* notice, this list of conditions and the following disclaimer in the
* documentation and/or other materials provided with the distribution.
* * Neither the name of the Justinfront Ltd nor the
* names of its contributors may be used to endorse or promote products
* derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY Justinfront Ltd ''AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL Justinfront Ltd BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package wings.jsCanvas;

import js.Lib;
import js.html.ImageElement;
import js.html.Event;
import js.html.Document;
import js.Browser;
typedef Hash<T> = haxe.ds.StringMap<T>;

@:expose
class ImageLoader
{
	public var images: Hash<ImageElement>;
	private var loaded: Void -> Void;
	private var count: Int;
	public function new( imageNames: Array<String>, loaded_: Void -> Void )
	{
		images = new Hash();
		loaded = loaded_;
		count = imageNames.length;
		for( name in imageNames ) load( name );
	}
	private function load( img: String )
	{
		var image: ImageElement = js.Browser.document.createImageElement();
		var imgStyle = image.style;
		imgStyle.left = '0px';
		imgStyle.top = '0px';
		imgStyle.paddingLeft = "0px";
		imgStyle.paddingTop = "0px";
		image.onload = store.bind( image, img.split('/').pop() );
		imgStyle.position = "absolute";
		image.src = img;
	}
	private function store( image: ImageElement, name: String, e: Event )
	{
		count--;
		images.set( name, image );
		if( count == 0 )
		{
			loaded();
		}
	}
}
