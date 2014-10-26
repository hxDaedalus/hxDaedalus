DaedalusHX
==========

( compiles but not runs )

Daedalus-lib Haxe version a port of the AS3 library found here:
https://code.google.com/p/daedalus-lib/

Licence is MIT for the original and this port.

Currently the three examples compile fine but unfortunately they have runtime errors which I have not yet spent time fixing, but hopefully, with most of the boring porting done, others maybe interested enough to help get the examples running.

Where possible I have replaced Haxe flash code with more generic Haxe code, for instance replacing Dictionaries with Maps and Vectors with Arrays ( which may need more optimisation and consideration later ). I have not yet modified the view code to be less flash centric as it seemed more important for code to run in flash before attempting to make it more generic, but I would love to have the code running in haxe JS and being a lib that Java or Python coders could use. Current code has strange iterators, since as3 does not support them... it would be nice to amend them to Haxe ones but I was not quite sure on how, so till the code is running I have left that aspect.

Any help appreciated in making this library production ready, I think this could be really useful library especially in this Haxe form.

