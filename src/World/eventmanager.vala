class EventManager : GLib.Object
{
	public bool KEY_D = false;
	public bool KEY_W = false;
	public bool KEY_A = false;
	public bool KEY_S = false;
	public bool KEY_Q = false;
	public bool KEY_E = false;
	
	public World world;
	
	public EventManager(World world)
	{
		this.world = world;
		
		if (Consts.debug)
			Consts.output("Started event manager.");
	}
	
	public void update()
	{
		//Well. Loads to do here.
		
		
		
		
		
		
		
		
		
		//*whistles something unrecognisable*
	}
}
