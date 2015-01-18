class EventHandler : Object
{
	public weak Display display;
	public weak World world;	
	
	public EventHandler(Display display, World world)
	{
		this.display = display;
		this.world = world;
		
		if (Consts.debug)
			Consts.output("Started event handler.");
	}
	
	public void tick()
	{
		SFML.Window.Event event;
		while (this.display.window.poll_event(out event))
		{
			this.handleEvent(event);
		}
		
		this.world.event_manager.KEY_D = SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.D);
		this.world.event_manager.KEY_W = SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.W);
		this.world.event_manager.KEY_A = SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.A);
		this.world.event_manager.KEY_S = SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.S);
		this.world.event_manager.KEY_Q = SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.Q);
		this.world.event_manager.KEY_E = SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.E);
		
		if (SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.Q))
		{
			Consts.view_rotation -= 2;
			this.display.recalculateRotation();
		}
		
		if (SFML.Window.Keyboard.is_key_pressed(SFML.Window.KeyCode.E))
		{
			Consts.view_rotation += 2;
			this.display.recalculateRotation();
		}
	}
	
	public void handleEvent(SFML.Window.Event event)
	{
		switch (event.type)
		{
			case (SFML.Window.EventType.CLOSED):
				this.display.close();
				break;
			case (SFML.Window.EventType.RESIZED):
				this.display.resetView((int)event.size.width, (int)event.size.height);
				break;
		}
	}
}
