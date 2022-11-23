package;

import openfl.media.Sound;
import sys.FileSystem;

// Enumerator for Asset Types;
enum AssetType
{
	IMAGE;
	VIDEO;
	SOUND;
	FONT;
}

/**
 * This is the Assets Class, meant to allow access to assets, and manage used ones
 */
class Assets
{
	/**
	 * [Returns a specified asset]
	 * @param asset the asset name
	 * @param type the asset type (like: IMAGE, SOUND, FONT for example)
	 * @param directory the directory we should look for the specified asset name
	 * @return your asset path along with the asset and its extensions (if null, then nothing)
	 */
	public static function getAsset(asset:String, type:AssetType, directory:String):Dynamic
	{
		//
		var path = mainPath('$directory/$asset', type);
		switch (type)
		{
			case SOUND:
				return getSound(path);
			default:
				if (FileSystem.exists(path))
					return path;
		}
		trace('asset is returning null at $path');
		return null;
	}

	/**
	 * [Returns a sound from the specified folder]
	 * @param asset the sound file name
	 * @param folder the folder name that we should look for
	 */
	public static function getSound(fromDirectory:String)
	{
		return Sound.fromFile(fromDirectory);
	}

	/**
	 * [Returns the main assets directory]
	 * @param directory folder that we should return along with the main assets folder
	 */
	public static function mainPath(directory:String, ?type:AssetType)
	{
		//
		var dir:String = '';
		if (directory != null)
			dir = '/$directory';
		return getExtensions('assets$dir', type);
	}

	/**
	 * [Filters through asset types and returns extensions for said assets]
	 * @param type the asset type (like: image, font, sound)
	 * @param dir the directory we should get the extension from
	 */
	public static function getExtensions(dir:String, type:AssetType)
	{
		var extensions:Array<String> = null;
		switch (type)
		{
			case IMAGE:
				extensions = ['.png', '.jpg'];
			case VIDEO:
				extensions = ['.mp4'];
			case FONT:
				extensions = [".ttf", ".otf"];
			case SOUND:
				extensions = ['.ogg', '.wav'];
			default:
				//
		}

		if (extensions != null)
		{
			for (i in extensions)
			{
				var assetPath:String = '$dir$i';
				if (FileSystem.exists(assetPath))
					return assetPath;
			}
		}

		return dir;
	}
}
