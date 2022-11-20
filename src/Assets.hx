package;

import openfl.media.Sound;
import sys.FileSystem;

/**
 * This is the Assets Class, it is used to manage asset usage in the game.
 * It's meant to allow access to assets, and manage used ones
 */
class Assets
{
	/**
	 * [Returns an image from the images folder]
	 * @param asset the image file name
	 */
	public static function getImage(asset:String)
	{
		//
		return getExtensions("image", mainPath('images/$asset'));
	}

	/**
	 * [Returns a sound from the specified folder]
	 * @param asset the sound file name
	 * @param folder the folder name that we should look for
	 */
	public static function getSound(asset:String, folder:String)
	{
		//
		return Sound.fromFile(getExtensions("sound", mainPath('$folder/$asset')));
	}

	/**
	 * [Returns a font from the fonts folder]
	 * @param asset the font file name
	 */
	public static function getFont(asset:String)
	{
		//
		return getExtensions("font", mainPath('fonts/$asset'));
	}

	/**
	 * [Filters through asset types and returns extensions for said assets]
	 * @param type the asset type (like: image, font, sound)
	 * @param dir the directory we should get the extension from
	 */
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

	/**
	 * [Returns the main assets directory]
	 * @param directory folder that we should return along with the main assets folder
	 */
	public static function mainPath(directory:String)
	{
		//
		return 'assets/$directory';
	}
}
