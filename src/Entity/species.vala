namespace Species
{
	public SpeciesType[] types;
	
	//Define the texture size
	public SFML.Graphics.IntRect rect;
	
	public class SpeciesType : GLib.Object
	{
		public string name;
		public Textures.Tex tex;
	
		public SpeciesType(string name)
		{
			this.name = name;
			this.tex = Textures.Tex.fromFile(name);
		}
	}
	
	public void define()
	{
		Species.types = new SpeciesType[0];
		types[0] = new SpeciesType("default");
	}
}
