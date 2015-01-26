namespace Mods
{
	public DynamicList<Mod> loaded;
	
	public File directory;
	public File config;
	
	public void init()
	{
		Mods.loaded = new DynamicList<Mod>();
		
		Mods.directory = File.new_for_path(GLib.Path.build_filename(Consts.data_directory.get_path(), "mods"));
		if (Mods.directory.query_exists() != true)
			Mods.directory.make_directory();
		Mods.config = File.new_for_path(GLib.Path.build_filename(Mods.directory.get_path(), "mods.nml"));
		
		Consts.output("Now parsing the mods.nml file...");
		
		NMLParser parser = new NMLParser();
		parser.objectAdded.connect(Mods.addMod);
		parser.parseFile(Mods.config.get_path());
	}
	
	public void addMod(NMLObject object)
	{
		Mod mod = new Mod(object);
		Mods.loaded.add(mod);
	}
}

public class Mod : Object
{
	public string name;
	public ObjectProperties properties;
	
	public File directory;
	public File config;
	
	public Mod(NMLObject object)
	{
		this.name = object.name;
		this.properties = new ObjectProperties();
		
		Consts.output("Loaded mod '" + this.name + "'");
		
		this.directory = File.new_for_path(GLib.Path.build_filename(Mods.directory.get_path(), this.name));
		this.config = File.new_for_path(GLib.Path.build_filename(this.directory.get_path(), this.name + ".nml"));
		
		NMLParser parser = new NMLParser();
		parser.objectAdded.connect(this.addObject);
		parser.parseFile(this.config.get_path());
	}
	
	public void addObject(NMLObject object)
	{
		this.properties.setFromNMLObject(object);
	}
}
