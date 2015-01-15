namespace BlockTypes
{	
	BlockType?[] types;
	
	class BlockType : GLib.Object
	{
		public string name;
		public Textures.Tex tex;
	
		public BlockType(string name)
		{
			this.name = name;
			this.tex = Textures.Tex.fromFile(name);
		}
	}
	
	public void define()
	{
		//Nothing yet... TODO
		BlockTypes.types = new BlockType[0];
		//types[0] = new BlockType("space");
	}
}
