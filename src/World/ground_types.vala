namespace GroundTypes
{
	GroundType?[] types;
	
	class GroundType : GLib.Object
	{
		public string name;
		public int texture_number;
		public bool vary_texture_colour;
	
		public GroundType(string name, int texture_number, bool vary_texture_colour)
		{
			this.name = name;
			this.texture_number = texture_number;
			this.vary_texture_colour = vary_texture_colour;
		}
	}
	
	public void define()
	{
		types = new GroundType[256];
		types[0] = new GroundType("space", 0, true);
		types[1] = new GroundType("grass", 1, true);
		types[2] = new GroundType("sand", 2, true);
		types[3] = new GroundType("water", 3, true);
		types[4] = new GroundType("ice", 4, true);
		types[5] = new GroundType("snow", 5, true);
		types[6] = new GroundType("swamp", 6, true);
	}
}
