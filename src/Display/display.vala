class Display : Object
{
	public Position pos;
	
	//The reference things
	public weak Application application;
	public weak World world;
	
	//The window and video modes
	public SFML.Window.VideoMode vm;
	public SFML.Window.ContextSettings cs;
	public SFML.Graphics.RenderWindow window;
	
	//Measure the FPS
	public ulong microseconds;
	public double seconds;
	public Timer timer;
	
	//The view
	public SFML.Graphics.View view;
	
	//The user interface elements
	public Gee.ArrayList<UIElement> ui_elements;
	
	//The event handler for processing events
	public EventHandler event_handler;
	
	public Display(Application application, World world)
	{
		if (Consts.debug)
			Consts.output("Creating display...");
		
		this.application = application;
		this.world = world;
		
		this.pos = new Position(0, 0, 0);
		
		//Actually create the window ready for drawing and everything
		this.vm = {(int)(Consts.view_width * Consts.screen_scale), (int)(Consts.view_height * Consts.screen_scale), 32};
		this.cs = SFML.Window.create_context_settings();
		this.window = new SFML.Graphics.RenderWindow(this.vm, Consts.name_full, SFML.Window.Style.DEFAULT, out this.cs);
		//this.window.set_vertical_sync_enabled(Consts.vsync);
		this.window.set_framerate_limit((uint)Consts.fps_target);
		this.window.set_key_repeat_enabled(false);
		
		//The view
		this.view = new SFML.Graphics.View();
		
		//The user interface elements
		this.ui_elements = new Gee.ArrayList<UIElement>();
		UIElement ele = (UIElement)new CompassDisplay(this, this.world);
		this.ui_elements.add(ele);
		UIElement fps = (UIElement)new FPSDisplay(this, this.world);
		this.ui_elements.add(fps);
		
		//The event handler - this comes last, since it's relatively unimportant.
		this.event_handler = new EventHandler(this, this.world);
		
		//This goes at the end, just to confirm that it's all been done.
		if (Consts.debug)
			Consts.output("Created display.");
	}
	
	public void resetView(int width, int height)
	{
		Consts.view_width = (int)(width / Consts.screen_scale);
		Consts.view_height = (int)(height / Consts.screen_scale);
		
		//And it's maximum size
		Consts.view_max_size = int.max(Consts.view_width, Consts.view_height);
		
		//Reset the view sizes
		SFML.System.Vector2f view_centre = {Consts.view_width / 2, Consts.view_height / 2};
		this.view.set_center(view_centre);
		
		//Set the size of the in-game view
		SFML.System.Vector2f view_size = {Consts.view_width, Consts.view_height};
		this.view.set_size(view_size);
		
		//Set the viewport proportions on-screen
		SFML.Graphics.FloatRect view_rect = {0, 0, 1, 1};
		this.view.set_viewport(view_rect);
		
		//Set the rotation...
		this.view.set_rotation(Consts.view_rotation);
		//...and hence recalculate the rotation vector
		this.recalculateRotation();
		
		//Yet, this is the view we're using
		this.window.set_view(this.view);
		
		if (Consts.debug)
			Consts.output("Resized the view.");
	}
	
	public void recalculateRotation()
	{
		//Calculate radians
		Consts.view_rotation_radians = (float)Math.PI * (float)Consts.view_rotation / 180;
		
		//Recalculate the rotation vector according to the new rotation angle
		Consts.view_i = {(float)Math.cos(Consts.view_rotation_radians), (float)Math.sin(Consts.view_rotation_radians)};
		Consts.view_j = {(float)Math.sin(-Consts.view_rotation_radians), (float)Math.cos(Consts.view_rotation_radians)};
		Consts.view_i_inverse = {(float)Math.cos(-Consts.view_rotation_radians), (float)Math.sin(-Consts.view_rotation_radians)};
		Consts.view_j_inverse = {(float)Math.sin(Consts.view_rotation_radians), (float)Math.cos(-Consts.view_rotation_radians)};
		
		Consts.view_cartesian_width = (int)(Math.fabs((float)Consts.view_height * Math.sin(Consts.view_rotation_radians)) + Math.fabs((float)Consts.view_width * Math.cos(Consts.view_rotation_radians)));
		Consts.view_cartesian_height = (int)(Math.fabs((float)Consts.view_width * Math.sin(Consts.view_rotation_radians)) + Math.fabs((float)Consts.view_height * Math.cos(Consts.view_rotation_radians)));
		
		//Change the view also
		this.view.set_rotation(Consts.view_rotation);
		
		//Signal an update to all UI elements such that they may move / resize
		//This method is triggered by resetView() also, so it will run for both!
		for (int x = 0; x < this.ui_elements.size; x ++)
		{
			this.ui_elements[x].update();
		}
		
		//Yet, this is the view we're using
		this.window.set_view(this.view);
	}
	
	public void tick()
	{	
		//The position of the view
		//int32 x = this.pos.x + Consts.view_width / 2;
		//int32 y = this.pos.y + Consts.view_width / 2;
		//Region? region = this.world.regions[x / Consts.region_size_pixels, y / Consts.region_size_pixels];
		//this.pos.z = region.cells[(x / Consts.cell_size) % Consts.region_size, (y / Consts.cell_size) % Consts.region_size].altitude;
		
		this.pos.z = this.world.getCell(this.pos.x, this.pos.y).altitude;
		
		this.pos.x = this.world.player.pos.x;
		this.pos.y = this.world.player.pos.y;
		
		//And handle the momentum
		this.pos.tick();
		
		//First, draw all the stuffs
		this.window.clear({0, 0, 0, 255});
		Render.drawMap(this.window, this.world, this.pos);
		Render.drawEntities(this.window, this.world, this.pos);
		Render.drawFog(this.window, this.world, this.pos);
		
		//Draw the UI
		Render.drawUIElements(this.window, this.world, this);
		
		//Tick the UI elements
		for (int count = 0; count < this.ui_elements.size; count ++)
		{
			this.ui_elements[count].tick();
		}
		
		//Increment the ticker
		Consts.tick ++;
		
		//Show the window
		this.window.display();
		
		//Handle all the events that have happened this frame. Executed last to prevent extra frame. NOT SO FOR KEYBOARD DETECTION!
		this.event_handler.tick();
		
		//What's the FPS?
		//handle the fps and delta time and all that rubbish
		if (Consts.debug)
		{
			this.seconds = Consts.timer.elapsed(out this.microseconds);
			Consts.fps_current = double.min((double)(Consts.fps_target) / seconds, Consts.fps_target);
			Consts.time_delta = (double)60 / Consts.fps_current;
		}
	}
	
	public void close()
	{
		if (Consts.debug)
			Consts.output("Closed the application.");
		this.window.close();
		this.world.end();
		Consts.running = false;
	}
}

