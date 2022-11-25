package;

import openfl.Assets as OpenAssets;
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
	/*
		Stores Tracked Sounds on a Map
	 */
	public static var mappedSounds:Map<String, Sound> = [];

	/*
		Stores every tracked asset on an Array, useful for cleaning up later on
	 */
	public static var trackedAssets:Array<String> = [];

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
	 * [Returns a sound from the specified directory]
	 * @param outputDir the directory we should look for
	 * @return uses OpenFL's sound feature to return a sound from the specified directory
	 */
	public static function getSound(outputDir:String):Sound
	{
		if (!mappedSounds.exists(outputDir))
			mappedSounds.set(outputDir, Sound.fromFile(outputDir));
		trackedAssets.push(outputDir);

		return mappedSounds.get(outputDir);
	}

	public static function clear()
	{
		for (soundAsset in mappedSounds.keys())
		{
			if (soundAsset != null && !trackedAssets.contains(soundAsset))
			{
				OpenAssets.cache.clear(soundAsset);
				mappedSounds.remove(soundAsset);
			}

			trackedAssets = [];
		}
	}

	/**
	 * [Returns the main assets directory]
	 * @param directory folder that we should return along with the main assets folder
	 * @param type the type of asset you need, leave it as blank for returning a directory instead
	 * @return the main assets directory with a specified subdirectory (and extension, if type is given)
	 */
	public static function mainPath(directory:String, ?type:AssetType):String
	{
		//
		var dir:String = '';
		if (directory != null)
			dir = '/$directory';
		return getExtensions('assets$dir', type);
	}

	/**
	 * [Filters through asset types and returns extensions for said assets]
	 * @param dir the directory we should get the extension from
	 * @param type the asset type (like: image, font, sound)
	 * @return if extension is valid, returns your path with the extension, else only the path
	 */
	public static function getExtensions(dir:String, type:AssetType):String
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
