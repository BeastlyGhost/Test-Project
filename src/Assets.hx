package;

import openfl.media.Sound;
import sys.FileSystem;

class Assets
{
	public static function getImage(asset:String)
	{
		//
		return getExtensions("image", mainPath('images/$asset'));
	}

	public static function getSound(asset:String, folder:String)
	{
		//
		return Sound.fromFile(getExtensions("sound", mainPath('$folder/$asset')));
	}

	public static function getFont(asset:String)
	{
		//
		return getExtensions("font", mainPath('fonts/$asset'));
	}

	public static function getExtensions(type:String, dir:String)
	{
		var extensions:Array<String> = null;
		switch (type)
		{
			case "image":
				extensions = ['.png', '.jpg'];
			case "font":
				extensions = [".ttf", ".otf"];
			case "sound":
				extensions = ['.ogg', '.wav'];
		}

		for (i in extensions)
		{
			var assetPath:String = '$dir$i';
			if (FileSystem.exists(assetPath))
				return assetPath;
		}

		return dir;
	}

	public static function mainPath(directory:String)
	{
		//
		return 'assets/$directory';
	}
}
