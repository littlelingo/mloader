/*
Copyright (c) 2012 Massive Interactive

Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
*/

package mloader;

import openfl.events.ProgressEvent;
import mloader.Loader;
import msignal.EventSignal;

/**
Loads BitmapData from a defined url.
*/
class ImageLoader extends LoaderBase<LoadableImage>
{
	var loader:openfl.display.Loader;

	public function new(?url:String, ?id:String)
	{
		super(url, id);

		loader = new openfl.display.Loader();

		var loaderInfo = loader.contentLoaderInfo;
		loaderInfo.addEventListener(openfl.events.ProgressEvent.PROGRESS, loaderProgressed);
		loaderInfo.addEventListener(openfl.events.Event.COMPLETE, loaderCompleted);
		loaderInfo.addEventListener(openfl.events.IOErrorEvent.IO_ERROR, loaderErrored);
	}

	override function loaderLoad()
	{
		
		
		/*
		var url:URLRequest = new URLRequest( "./images/page3/lady.png" );
		var ldr = new Loader();
		ldr.load( url );
		*/

			loader.load(new openfl.net.URLRequest(url));
	}

	override function loaderCancel()
	{
		loader.close();
	}
	
	function loaderProgressed(event:ProgressEvent)
	{
		progress = 0.0;

		if (event.bytesTotal > 0)
		{
			progress = event.bytesLoaded / event.bytesTotal;
		}

		loaded.dispatchType(Progress);
	}

	function loaderCompleted(event)
	{
		content = loader;//untyped loader.content.bitmapData;
		loaderComplete();
	}

	function loaderErrored(event)
	{
		loaderFail(IO(Std.string(event)));
	}
}
