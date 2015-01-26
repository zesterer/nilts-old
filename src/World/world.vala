/*//TODO - Rewrite this whole bloody thing, NOT using a nullable array for region storage!

class NWorld : World
{
	public uint32 seed = 15004026;
	public int64 ticker;
	public bool running;
	
	public Region?[,] regions;
	//This region is used when a region has not been loaded, and represents empty space. This prevents crashes and so on.
	public Region empty_region;
	//TODO
	//public Entity[] entites;
	public List<Entity> entities;
	public Player player;
	//public Inventory[] inventories;
	//public Item[] items;
	
	//The particles
	public List<Particle> particles;
	
	//The actual generator threads and stuff
	public RegionGenerator region_generator;
	public Thread<void*> generator_thread;
	
	public EventManager event_manager;
	
	public NWorld()
	{
		GLib.Rand ran = new GLib.Rand.with_seed(this.seed);
		this.seed = ran.next_int();
		
		//The good ole' entities list
		this.entities = new List<Entity>();
		
		//The generator thread
		this.region_generator = new RegionGenerator(this);
		try
		{
			this.generator_thread = new Thread<void*>.try("generation", this.region_generator.generateMethod);
			Consts.output("Started the region generation thread successfully.");
		}
		catch (Error error)
		{
			Consts.output("There was a major error while trying to start the region generation thread.");
			Consts.output(error.message);
		}
		
		this.player = new Player(this.seed + 1, this);
		this.entities.append((Entity)this.player);
		
		//Nothing as good as a test entity!
		Entity someguy = (Entity)new NPC(this.seed, this);
		this.entities.append(someguy);
		
		//Define the world tick
		this.ticker = 0;
		this.running = true;
		
		//The particles
		this.particles = new List<Particle>();
		
		//The region nullable array
		this.regions = new Region[Consts.world_size, Consts.world_size];
		
		//The empty default region
		this.empty_region = new Region(this, 0, 0, true);
		this.empty_region.generate();
		
		this.event_manager = new EventManager(this);
		
		Consts.output("Creating world");
	}
	
	public void generateRegion(int x, int y) //Generate a specific region
	{
		if (Consts.has_threads)
		{	
			//Add it to the quewe
			this.region_generator.mutex.lock();
			this.region_generator.generating_regions.append(this.regions[x, y]);
			this.region_generator.generating_regions_operation.append("generate");
			this.region_generator.mutex.unlock();
		}
		else
		{	
			//Straight-off generate it
			this.regions[x, y].generate();
		}
	}
	
	public unowned Region getRegion(int x, int y) //Find a region
	{	
		if ((x >= Consts.world_size) || (y >= Consts.world_size) || (x < 0) || (y < 0)) //We're outside the world.
			return this.empty_region;
		
		if (this.regions[x, y] != null)
		{
			//The region is already loaded into memory
			this.regions[x, y].updateTimeout();
			return this.regions[x, y];
		}
		else
		{	
			this.regions[x, y] = new Region(this, x, y);
			this.generateRegion(x, y);
			return this.regions[x, y];
		}
	}
	
	public Cell getCell(int32 x, int32 y)
	{
		x /= Consts.cell_size;
		y /= Consts.cell_size;
		return this.getRegion(x / Consts.region_size, y / Consts.region_size).getCell(x % Consts.region_size, y % Consts.region_size);
	}
	
	public void unloadRegion(Region region)
	{
		if (region.canUnload())
		{
			this.regions[region.pos.regionX, region.pos.regionY] = null;
		}
	}
	
	public int checkForUnload()
	{
		for (int x = 0; x < Consts.world_size; x ++)
		{
			for (int y = 0; y < Consts.world_size; y ++)
			{
				if (this.regions[x, y] != null)
				{
					if (this.regions[x, y].isOutdated())
					{
						this.unloadRegion(this.regions[x, y]);
					}
				}
			}
		}
		
		return 0;
	}
	
	public void tick()
	{
		this.ticker ++;
		
		//Do stuff in the world
		//Tick all entities
		for (int x = 0; x < this.entities.length(); x ++)
			this.entities.nth_data(x).tick();
		
		//Tick all particles
		for (int x = 0; x < this.particles.length(); x ++)
			this.particles.nth_data(x).tick();
		
		//Find out which particles need deleting
		for (int x = 0; x < this.particles.length(); x ++)
		{
			if (this.particles.nth_data(x).lifetime <= 0)
			{
				unowned List<Particle> todelete = this.particles.nth(0);
				this.particles.delete_link(todelete);
				x -= 1;
			}
		}
		
		//Check for unload-able regions
		this.checkForUnload();
		
		//Detect events that have happened this frame.
		this.event_manager.update();
	}
	
	public void end()
	{
		for (int x = 0; x < Consts.world_size; x ++)
		{
			for (int y = 0; y < Consts.world_size; y ++)
			{
				if (this.regions[x, y] != null)
				{
					this.unloadRegion(this.regions[x, y]);
				}
				
				this.regions[x, y] = null;
			}
		}
		
		this.running = false;
	}
}

class RegionGenerator : Object
{
	public World world;
	//The regions that are in the generation quewe
	public List<Region?> generating_regions;
	//The operation that needs to be performed on them
	public List<string> generating_regions_operation;
	//The mutex lock
	public Mutex mutex;
	
	public RegionGenerator(World world)
	{
		this.world = world;
		
		//Which regions should the independent thread generate?
		this.generating_regions = new List<Region?>();
		//The operation
		this.generating_regions_operation = new List<string>();
		//The mutex lock
		this.mutex = Mutex();
	}
	
	public void* generateMethod()
	{
		while (this.world.running)
		{
			if (this.generating_regions.length() > 0)
			{
				this.mutex.lock();
				string operation = this.generating_regions_operation.nth_data(0);
				unowned Region? region = this.generating_regions.nth_data(0);
				this.mutex.unlock();
				
				if (operation == "generate")
				{
					region.generate();
				}
				else if (operation == "load_cells")
				{
					//region.loadCells();
				}
				else if (operation == "render")
				{
					region.render();
				}
				
				this.mutex.lock();
				if (this.generating_regions.length() > 0)
				{
					unowned List<Region?> todelete1 = this.generating_regions.nth(0);
					this.generating_regions.delete_link(todelete1);
					unowned List<string> todelete2 = this.generating_regions_operation.nth(0);
					this.generating_regions_operation.delete_link(todelete2);
				}
				this.mutex.unlock();
				
				//Yield the thread
				Thread.yield();
			}
			
			Thread.usleep(1);
		}
		
		Thread.exit(0);
		
		return null;
	}
}*/

class World : Object
{
	//The seed
	private uint32 _seed = 0;
	private bool _running;
	private int64 _tick_counter;
	
	//private List<Region> _regions;
	private Region?[,] _regions;
	private Region _empty_region;
	
	public List<Entity> entities;
	public Player player;
	
	public DynamicList<Particle> particles;
	
	public EventManager event_manager;
	
	public World()
	{
		//The seed
		GLib.Rand ran = new GLib.Rand.with_seed(this.seed);
		this.seed = ran.next_int();
		
		//Ticker and running
		this._running = true;
		this._tick_counter = 0;
		
		//The regions
		//this._regions = new List<Region>();
		this._regions = new Region[Consts.world_size, Consts.world_size];
		this._empty_region = new Region(this, 0, 0, true);
		this._empty_region.generate();
		
		//The entities list
		this.entities = new List<Entity>();
		
		//Player!
		this.player = new Player(this.seed + 1, this);
		this.player.pos.setPos(Consts.world_size_pixels / 2, Consts.world_size_pixels / 2);
		this.entities.append((Entity)this.player);
		//Nothing as good as a test entity!
		Entity someguy = (Entity)new NPC(this.seed, this);
		someguy.pos.setPos(Consts.world_size_pixels / 2, Consts.world_size_pixels / 2);
		this.entities.append(someguy);
		
		//The particles
		this.particles = new DynamicList<Particle>();
		
		//The event manager
		this.event_manager = new EventManager(this);
	}
	
	public uint32 seed
	{
		get
		{return this._seed;}
		set
		{Consts.output("Cannot manually set seed");}
	}
	
	public new bool running
	{
		get
		{return this._running;}
		set
		{this._running = value;}
	}
	
	public int64 tick_counter
	{
		get
		{return this._tick_counter;}
		set
		{Consts.output("Cannot manually set tick");}
	}
	
	public unowned Region? getRegion(int x, int y)
	{
		if ((x >= Consts.world_size) || (y >= Consts.world_size) || (x < 0) || (y < 0)) //We're outside the world.
			return this._empty_region;
		
		unowned Region region = this._regions[x, y];
		return region;
	}
	
	public unowned Region loadRegion(int x, int y) //Find a region
	{
		unowned Region? region = this.getRegion(x, y);
		
		if (region != null) //We're outside the world.
		{
			region.updateTimeout();
			return region;
		}
		else
		{
			this._regions[x, y] = new Region(this, x, y);
			region = this._regions[x, y];
			region.generate();
			return region;
		}
	}
	
	public Cell getCell(int32 x, int32 y)
	{
		x /= Consts.cell_size;
		y /= Consts.cell_size;
		return this.loadRegion(x / Consts.region_size, y / Consts.region_size).getCell(x % Consts.region_size, y % Consts.region_size);
	}
	
	public double getAltitude(int32 x, int32 y)
	{
		double alt_tl = this.getCell(x, y).altitude;
		double alt_tr = this.getCell(x + Consts.cell_size, y).altitude;
		double alt_bl = this.getCell(x, y + Consts.cell_size).altitude;
		double alt_br = this.getCell(x + Consts.cell_size, y + Consts.cell_size).altitude;
		
		double toplerp = Maths.lerp(alt_tl, alt_tr, (double)(x % Consts.cell_size) / Consts.cell_size);
		double bottomlerp = Maths.lerp(alt_bl, alt_br, (double)(x % Consts.cell_size) / Consts.cell_size);
		
		return Maths.lerp(toplerp, bottomlerp, (double)(y % Consts.cell_size) / Consts.cell_size);
	}
	
	public void unloadRegion(int x, int y)
	{
		if (this._regions[x, y].canUnload())
		{
			this._regions[x, y] = null;
			
			//this.regions[region.pos.regionX, region.pos.regionY] = null;
		}
	}
	
	public void checkForUnload(bool ending = false)
	{
		for (int x = 0; x < Consts.world_size; x ++)
		{
			for (int y = 0; y < Consts.world_size; y ++)
			{
				if (this._regions[x, y] != null)
				{
					unowned Region region = this._regions[x, y];
					if (region.isOutdated() || ending)
					{
						this.unloadRegion(x, y);
					}
				}
			}
		}
	}
	
	public void tick()
	{
		this._tick_counter ++;
		
		//Do stuff in the world
		//Tick all regions
		for (int x = 0; x < Consts.world_size; x ++)
		{
			for (int y = 0; y < Consts.world_size; y ++)
			{
				if (this._regions[x, y] != null)
				{
					this._regions[x, y].tick();
				}
			}
		}
		
		//Tick all entities
		for (int count = 0; count < this.entities.length(); count ++)
			this.entities.nth_data(count).tick();
		
		//Tick all particles
		for (int count = 0; count < this.particles.length; count ++)
		{
			this.particles[count].tick();
			
			if (this.particles[count].lifetime <= 0)
			{
				this.particles.remove_at(count);
				count -= 1;
			}
		}
		
		//Check for unload-able regions
		this.checkForUnload();
		
		//Detect events that have happened this frame.
		this.event_manager.update();
	}
	
	//This has no relation to either cabbages or mewing, how disappointing.
	public void end()
	{
		this.checkForUnload(true);
		
		this.running = false;
	}
}
