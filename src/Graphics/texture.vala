namespace Textures
{
	public List<Tex> types;
	
	//Define the texture size
	public SFML.Graphics.IntRect rect;
	
	public class Tex : SFML.Graphics.Texture
	{	
		public Tex()
		{
			base(1, 1);
			if (Consts.debug)
				Consts.output("Created a texture.");
			
			/*int r = 0;
			int g = 0;
			int b = 0;
			int a = 0;
			
			SFML.Graphics.Image img = this.copy_to_image();
			for (uint x = 0; x < this.get_size().x; x += 3)
			{
				for (uint y = 0; y < this.get_size().y; y += 3)
				{
					SFML.Graphics.Color c = img.get_pixel(x, y);
					r += c.r;
					g += c.g;
					b += c.b;
					a += c.a;
				}
			}*/
			
			//this.col = {(uint8)(r / (this.get_size().x / 3)), (uint8)(g / (this.get_size().x / 3)), (uint8)(b / (this.get_size().x / 3)), (uint8)(a / (this.get_size().x / 3))};
		}
		
		public static Tex fromFile(string name, string type = "ground")
		{
			SFML.Graphics.Texture texture = new SFML.Graphics.Texture(1, 1);
			Tex tex = new Tex();
			switch (type)
			{
				case ("ground"):
					tex = (Tex)new texture.from_file(Consts.groundtypes_location + name + ".png", Textures.rect);
					break;
				case ("block"):
					tex = (Tex)new texture.from_file(Consts.blocktypes_location + name + ".png", Textures.rect);
					break;
				case ("entity"):
					tex = (Tex)new texture.from_file(Consts.entitytypes_location + name + ".png", Textures.rect);
					break;
				case ("uielement"):
					tex = (Tex)new texture.from_file(Consts.uielements_location + name + ".png", Textures.rect);
					break;
			}
			
			return tex;
		}
	}
	
	public void define()
	{
		//Define the texture size
		Textures.rect = {0, 0, 32, 32};	
		
		//Define the array
		Textures.types = new List<Tex>();
		
		//Define the array components
		Textures.types.append(Tex.fromFile("space"));
		Textures.types.append(Tex.fromFile("grass"));
		Textures.types.append(Tex.fromFile("sand"));
		Textures.types.append(Tex.fromFile("water"));
		Textures.types.append(Tex.fromFile("ice"));
		Textures.types.append(Tex.fromFile("snow"));
		Textures.types.append(Tex.fromFile("swamp"));
		Textures.rect = {0, 0, 80, 80};	
		Textures.types.append(Tex.fromFile("compass_dial", "uielement"));
		Textures.types.append(Tex.fromFile("compass_background", "uielement"));
		Textures.rect = {0, 0, 96, 64};	
		Textures.types.append(Tex.fromFile("fps_background", "uielement"));
		Textures.rect = {0, 0, 32, 32};
		Textures.types.append(Tex.fromFile("maxus", "entity"));
	}
	
	public void loadFromNMLObject(NMLObject object)
	{
		Textures.types.append(Tex.fromFile(object.getProperty("name"), object.getProperty("texture-type")));
	}
}
