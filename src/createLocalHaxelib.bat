rm hxDaedalus.zip
7za a -r hxDaedalus.zip * -x!*.bat -x!*.hxml
haxelib remove hxDaedalus
haxelib local hxDaedalus.zip