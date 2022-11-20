package;

import sys.FileSystem;

class Assets
{
	public static function getImage(asset:String)
	{
		//
		var imagePath:String = mainPath('images/$asset.png');
		var extensions:Array<String> = ['.png', '.jpg'];

		for (extension in extensions)
		{
			var extendedPath:String = mainPath('images/$asset$extension');
			if (FileSystem.exists(extendedPath))
				return extendedPath;
		}
		return imagePath;
	}

	public static function getSound(asset:String, folder:String)
	{
		//
		var soundPath:String = mainPath('$folder/$asset.mp3');
		var extensions:Array<String> = ['.mp3', '.ogg', '.wav'];

		for (extension in extensions)
		{
			var extendedPath:String = mainPath('$folder/$asset$extension');
			if (FileSystem.exists(extendedPath))
				return extendedPath;
		}
		return soundPath;
	}

	public static function getFont(asset:String)
	{
		//
		var soundPath:String = mainPath('fonts/$asset.ttf');
		var extensions:Array<String> = ['.ttf', '.otf'];

		for (extension in extensions)
		{
			var extendedPath:String = mainPath('fonts/$asset$extension');
			if (FileSystem.exists(extendedPath))
				return extendedPath;
		}
		return soundPath;
	}

	public static function mainPath(directory:String)
	{
		//
		return 'assets/$directory';
	}
}
