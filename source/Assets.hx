package;

class Assets
{
	public static function getImage(asset:String)
	{
		//
		return mainPath('images/$asset.png');
	}

	public static function getSound(asset:String, folder:String)
	{
		//
		return mainPath('$folder/$asset.ogg');
	}

	public static function mainPath(directory:String)
	{
		//
		return 'assets/$directory';
	}
}
