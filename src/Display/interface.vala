class UIElement : GLib.Object
{
	public float x;
	public float y;
	public int width;
	public int height;
	public int rot;
	
	//The animation properties (what's displayed)
	public float anim_x;
	public float anim_y;
	public int anim_width;
	public int anim_height;
	public int anim_rot;
	
	//Does the element resize?
	public bool does_resize = false;
	
	//Fonts for the UI and stuff
	public SFML.Graphics.Font font;
	public SFML.Graphics.Text text;
	
	public SFML.Graphics.RenderTexture texture;
	
	//How it collects data from the display and the world
	public weak Display display;
	public weak World world;
	
	public UIElement(Display display, World world)
	{
		this.display = display;
		this.world = world;
		
		this.x = 16;
		this.y = 16;
		this.width = 128;
		this.height = 64;
		this.rot = 0;
		
		this.anim_x = this.x;
		this.anim_y = this.y;
		this.anim_width = this.width;
		this.anim_height = this.height;
		this.anim_rot = this.rot;
		
		this.font = new SFML.Graphics.Font(Consts.fonts_location + Consts.font_ui);
		this.text = new SFML.Graphics.Text();
		
		this.texture = new SFML.Graphics.RenderTexture(this.width, this.height, false);
		this.resetTexture();
	}
	
	public void resetTexture()
	{
		//2014-12-13 This method is the little bastard causing all the memory leaking issues. Or at least one of the issues.
		//2015-01-14 No it's not. Ignore the above ^. It's being stupid. It's just trying to bully the poor method.
		//stdout.printf("Reset the texture!\n");
		this.texture = new SFML.Graphics.RenderTexture(this.width, this.height, false);
		this.render();
	}
	
	public void resize(int width, int height)
	{
		this.width = width;
		this.height = height;
		
		if (this.does_resize)
			this.resetTexture();
		this.update();
	}
	
	public virtual void update()
	{
		//Usually when the view is updated!
		this.x = Consts.view_width / 2 - (this.width + 16);
		this.y = Consts.view_height / 2 - (this.height + 16);
		
		this.render();
	}
	
	public virtual void render()
	{
		this.texture.clear(SFML.Graphics.white);
		this.texture.display();
	}
	
	public virtual void tick()
	{
		//Animate it
		this.anim_x += (this.x - this.anim_x) / 4;
		this.anim_y += (this.y - this.anim_y) / 4;
		
		this.anim_width += (this.width - this.anim_width) / 4;
		this.anim_height += (this.height - this.anim_height) / 4;
	}
}

class FPSDisplay : UIElement
{	
	public FPSDisplay(Display display, World world)
	{
		base(display, world);
		
		this.width = 96;
		this.height = 64;
		
		this.text.set_font(this.font);
		this.text.set_character_size(10);
		this.text.set_color({0, 0, 0, 255});
		this.text.set_position({16, 16});
		
		this.resetTexture();
	}
	
	public override void update()
	{
		this.x = -Consts.view_width / 2 + 16;
		this.y = -Consts.view_height / 2 + 16;
		
		if (Consts.tick % (Consts.fps_target / 4) == 0)
			this.render();
	}
	
	public override void render()
	{
		SFML.Graphics.Sprite cellsprite = new SFML.Graphics.Sprite();
		
		cellsprite.set_position({0, 0});
		cellsprite.set_texture(Textures.types[9], true);
		this.texture.draw_sprite(cellsprite, null);
		
		this.text.set_string("FPS: " + ((int)Consts.fps_current).to_string());
		this.texture.draw_text(this.text, null);
		
		this.texture.display();
	}
	
	public override void tick()
	{
		//Animate it
		this.anim_x += (this.x - this.anim_x) / 4;
		this.anim_y += (this.y - this.anim_y) / 4;
		
		this.anim_width += (this.width - this.anim_width) / 4;
		this.anim_height += (this.height - this.anim_height) / 4;
		
		this.render();
	}
}

class CompassDisplay : UIElement
{
	private float rotation;
	
	public CompassDisplay(Display display, World world)
	{
		base(display, world);
		
		this.width = 80;
		this.height = 80;
		
		this.rotation = 0.0f;
		
		this.resetTexture();
	}
	
	public override void update()
	{
		this.x = Consts.view_width / 2 - (this.width + 16);
		this.y = -Consts.view_height / 2 + 16;
		
		this.rotation = -Consts.view_rotation;
		
		this.render();
	}
	
	public override void render()
	{
		this.texture.clear({0, 0, 0, 0});
		
		SFML.Graphics.Sprite cellsprite = new SFML.Graphics.Sprite();
		
		//The compass background
		cellsprite.set_position({0, 0});
		cellsprite.set_texture(Textures.types[8], true);
		this.texture.draw_sprite(cellsprite, null);
		
		//The actual dial
		cellsprite.set_origin({40, 40});
		cellsprite.set_rotation(this.rotation);
		cellsprite.set_position({40, 40});
		cellsprite.set_texture(Textures.types[7], true);
		this.texture.draw_sprite(cellsprite, null);
		
		this.texture.display();
		
		//WHY, OH WHY DID I MAKE THIS AN OVERRIDE AND NOT PUT IT ALL IN THE PARENT CLASS? SO MUCH EASIER.
	}
}
