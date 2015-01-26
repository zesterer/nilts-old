class Application : GLib.Object
{
	public World world;
	public Display display;
	
	public Application(string[] args)
	{
		if (Consts.debug)
			Consts.output("Started configuring...");
		//Configure essential variables
		Consts.running = true;
		
		//Check arguments
		if ("--version" in args)
		{
			Consts.output("Version " + Consts.name_full + ".");
			Consts.running = false;
		}
		
		//Create game objects
		if (Consts.running)
		{
			//Configure starting constants
			Consts.init();
			Textures.define();
			BlockTypes.define();
			GroundTypes.define();
			NoiseTypes.define();
			Mods.init();
			
			//Can we use threads?
			if (Thread.supported() && Consts.use_threads)
			{
				if (Consts.debug)
					Consts.output("Using threads in-game. This is good.");
				Consts.has_threads = true;
			}
			else
			{
				if (Consts.debug)
					Consts.output("Not using threads in-game. This is bad.");
				Consts.has_threads = false;
			}
			
			//Create main game objects
			this.world = new World();
			this.display = new Display(this, this.world);
		}
		
		if (Consts.debug)
			Consts.output("Finished configuring " + Consts.name_full + ".");
	}
	
	public void run()
	{
		//Start the timer
		Consts.timer = new Timer();
		 
		while (Consts.running)
		{
			this.world.tick();
			this.display.tick();
		}
		
		Consts.output("Closed the application");
	}
}

int main(string[] args)
{
	Application application = new Application(args);
	
	if (Consts.running)
		application.run();
	
	return 0; // <------ YOU SHALL NOT PASSSSS!!!!!!!!!!!!!
}
