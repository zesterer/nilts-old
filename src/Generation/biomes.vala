namespace BiomeTypes
{	
	BiomeType?[] types;
	int[,] biome_diagram;
	
	class BiomeType : GLib.Object
	{
		public string name;
		public Textures.Tex tex;
		
		public int top_layer = 0;
	
		public BiomeType(string name, string properties)
		{
			//TODO - Be quite Tristram. I'll get to it later.
			this.name = name;
			this.tex = Textures.Tex.fromFile(name);
		}
	}
	
	public void define()
	{
		//Define the whittaker diagram
		BiomeTypes.biome_diagram = new int[15, 26];
		
		//HE IS GOD! AND ON THE SECOND DAY, HE...
		//Defined the biomes
		BiomeTypes.types = new BiomeType[256];
		//types[0] = new BlockType("space");
	}
	
	public void defineBiome(int n, string name, SFML.Graphics.IntRect diagram_rect, string properties)
	{
		BiomeTypes.types[n] = new BiomeType(name, properties);
		
		for (int x = diagram_rect.x; x < diagram_rect.x + diagram_rect.width; x ++)
		{
			for (int y = diagram_rect.y; y < diagram_rect.y + diagram_rect.height; y ++)
			{
				biome_diagram[x, y] = n;
			}
		}
	}
}
