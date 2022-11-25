package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.media.Sound;
import openfl.system.System;
import sys.FileSystem;

/*
	Enumerator for Asset Types, right now, there isn't much going on with this
	it just defines what Asset Type we are dealing with, and gives extensions to said asset type
*/
enum AssetType
{
	IMAGE;
	VIDEO;
	SOUND;
	FONT;
}

/*
	Typedefine for Cached Assets, simply put, it defines what `type` an asset is, and what data it comes with
	data can be anything, as we are going to use it to later `grab` it in order to manage said data
*/
typedef CacheableAsset =
{
	var type:AssetType;
	var data:Dynamic;
}

/**
 * This is the Assets Class, meant to allow access to assets, and manage used ones
 */
class AssetHandler
{
	/*
		Stores Tracked Assets on a Map

		-----------------------
		I have yet to understand how asset managment works properly
		so if this looks weird, that's because it might be, i've decided that
		instead of creating multiple maps for various type of assets
		having a single one could be somewhat easier to manage
		@BeastlyGhost
	 */
	public static var mappedAssets:Map<AssetType, Map<String, CacheableAsset>> = [
		//
		IMAGE => new Map<String, CacheableAsset>(),
		SOUND => new Map<String, CacheableAsset>(),
		VIDEO => new Map<String, CacheableAsset>(),
	];

	/*
		Stores every tracked asset in an Array, useful for cleaning up later on
	 */
	public static var trackedAssets:Array<String> = [];

	/*
		Stores only user-preferred assets that shoud not be cleared when `clear` is called
	 */
	public static var persistentAssets:Array<String> = [];

	/**
	 * [Returns a specified asset]
	 * @param asset the asset name
	 * @param type the asset type (like: IMAGE, SOUND, FONT for example)
	 * @param directory the directory we should look for the specified asset name
	 * @return your asset path along with the asset and its extensions (if null, then nothing)
	 */
	public static function grabAsset(asset:String, type:AssetType, directory:String):Dynamic
	{
		//
		var path = grabRoot('$directory/$asset', type);
		switch (type)
		{
			case IMAGE:
				return grabGraphic(path);
			case SOUND:
				return grabSound(path);
			default:
				if (FileSystem.exists(path))
					return path;
		}
		trace('asset is returning null at $path');
		return null;
	}

	public static function grabGraphic(outputDir:String):FlxGraphic
	{
		if (!mappedAssets[IMAGE].exists(outputDir))
		{
			var myGraphic:BitmapData = BitmapData.fromFile(outputDir);
			mappedAssets[IMAGE].set(outputDir, {type: IMAGE, data: FlxGraphic.fromBitmapData(myGraphic, false, outputDir, false)});
			trackedAssets.push(outputDir);
			return mappedAssets[IMAGE].get(outputDir).data;
		}

		trace('graphic asset is returning null at $outputDir');
		return null;
	}

	/**
	 * [Returns a sound from the specified directory]
	 * @param outputDir the directory we should look for
	 * @return uses OpenFL's sound feature to return a sound from the specified directory
	 */
	public static function grabSound(outputDir:String):Sound
	{
		if (!mappedAssets[SOUND].exists(outputDir))
			mappedAssets[SOUND].set(outputDir, {type: SOUND, data: Sound.fromFile(outputDir)});
		trackedAssets.push(outputDir);
		return mappedAssets[SOUND].get(outputDir).data;
	}

	public static function clear(clearMappedImages:Bool = false)
	{
		if (clearMappedImages)
		{
			for (asset in mappedAssets[IMAGE].keys())
			{
				if (!persistentAssets.contains(asset) && !trackedAssets.contains(asset))
				{
					// grab the image asset
					var image = mappedAssets[IMAGE].get(asset);
					if (image != null)
					{
						@:privateAccess
						if (Assets.cache.hasBitmapData(image.data))
						{
							// remove it from the assets cache if it exists
							Assets.cache.removeBitmapData(image.data);
							FlxG.bitmap._cache.remove(image.data);
						}

						// and remove it from the mapped assets
						image.data.destroy();
						mappedAssets[IMAGE].remove(asset);
					}
				}
			}

			// run the system garbage collector
			System.gc();
		}

		for (asset in mappedAssets[SOUND].keys())
		{
			if (asset != null && !persistentAssets.contains(asset) && !trackedAssets.contains(asset))
			{
				Assets.cache.clear(asset);
				mappedAssets[SOUND].remove(asset);
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
	public static function grabRoot(directory:String, ?type:AssetType):String
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
