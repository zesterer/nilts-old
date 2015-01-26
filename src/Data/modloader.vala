/*namespace Mods
{
	public File mod_directory;
	public List<Mod> loaded_mods;
	
	public const string mod_config_file = "mods.nml";
	
	public void init()
	{
		Mods.loaded_mods = new List<Mod>();
		
		Mods.mod_directory = File.new_for_path(GLib.Path.build_filename(Consts.data_directory.get_path(), "mods"));
		if (Mods.mod_directory.query_exists() != true)
		{
			//Create it since it doesn't exist.
			Consts.output("Creating the mod directory since it does not exist.");
			Mods.mod_directory.make_directory();
		}
		Consts.output("The mods directory is " + Mods.mod_directory.get_path());
		
		Mods.checkMods();
	}
	
	public void checkMods()
	{
		Consts.output("Checking for mods using the file " + Mods.mod_config_file);
		NMLParser parser = new NMLParser();
		parser.objectAdded.connect(Mods.addMod);
		parser.parseFile(GLib.Path.build_filename(Mods.mod_directory.get_path(), Mods.mod_config_file));
		
		for (int count = 0; count < Mods.loaded_mods.length(); count ++)
			Mods.loaded_mods.nth_data(count).loadResources();
	}
	
	public void addMod(NMLParserObject object)
	{
		Mods.Mod mod = new Mods.Mod();
			
		if (object.getProperty("filename") != null)
			mod.filename = object.getProperty("filename");
		if (object.getProperty("version-major") != null)
			mod.version_major = int.parse(object.getProperty("version-major"));
		if (object.getProperty("version-minor") != null)
			mod.version_minor = int.parse(object.getProperty("version-minor"));
		if (object.getProperty("version-build") != null)
			mod.version_build = int.parse(object.getProperty("version-build"));
			
		Mods.loaded_mods.append(mod);
		Consts.output("Created a new mod");
	}
	
	public class Mod : Object
	{
		public string name;
		public string filename;
		public int version_major;
		public int version_minor;
		public int version_build;
		
		public Mod()
		{
			this.name = "";
			this.filename = "";
			this.version_major = 0;
			this.version_minor = 0;
			this.version_build = 0;
		}
		
		public void loadResources()
		{
			this.loadTexturesNML();
		}
		
		private void loadTexturesNML()
		{
			File directory = File.new_for_path(GLib.Path.build_filename(Mods.mod_directory.get_path(), this.filename, "texture-data"));
			if (Mods.mod_directory.query_exists() != true)
				return;
			
			NMLParser parser = new NMLParser();
			//parser.objectAdded.connect(Textures.loadFromNMLObject);
			parser.parseFile(GLib.Path.build_filename(directory.get_path(), "textures.nml"));
		}
	}
}*/
