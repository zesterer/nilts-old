class World : Object
{
	public uint32 seed = 15004027;
	public int64 ticker;
	
	public Region?[,] regions;
	//This region is used when a region has not been loaded, and represents empty space. This prevents crashes and so on.
	public Region empty_region;
	//TODO
	//public Entity[] entites;
	public List<Entity> entities;
	public Player player;
	//public Inventory[] inventories;
	//public Item[] items;
	
	//The actual generator threads and stuff
	public RegionGenerator region_generator;
	public Thread<void*> generator_thread;
	
	public EventManager event_manager;
	
	public World()
	{
		if (Consts.debug)
			stdout.printf("Creating world...\n");
		
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
		
		//The region nullable array
		this.regions = new Region[Consts.world_size, Consts.world_size];
		
		//The empty default region
		this.empty_region = new Region(this, this.seed, 0, 0);
		this.empty_region.generateEmpty();
		
		this.event_manager = new EventManager(this);
		
		if (Consts.debug)
			stdout.printf("Created world.\n");
	}
	
	public void generateRegion(int x, int y) //Generate a specific region
	{
		if (Consts.has_threads)
		{	
			//Add it to the quewe
			this.region_generator.mutex.lock();
			this.region_generator.generating_regions.add(this.regions[x, y]);
			this.region_generator.generating_regions_operation.add("generate");
			this.region_generator.mutex.unlock();
		}
		else
		{	
			//Straight-off generate it
			this.regions[x, y].generate();
		}
	}
	
	public Region getRegion(int x, int y) //Find a region
	{	
		if ((x >= Consts.world_size) || (y >= Consts.world_size) || (x < 0) || (y < 0)) //We're outside the world.
			return this.empty_region;
		
		if (this.regions[x, y] != null)
		{
			//The region is already loaded into memory
			this.regions[x, y].update_tick = Consts.tick;
			return this.regions[x, y];
		}
		else
		{	
			this.regions[x, y] = new Region(this, this.seed, x, y);
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
		if (region.unloadEvent())
		{
			//Check the reference counter for debugging purposes
			//if (Consts.debug)
				//stdout.printf("Object reference counter = %s.\n", region.ref_count.to_string());
			
			//Delete / dereference it all
			//this.regions[region.pos.getRegion_x(), region.pos.getRegion_y()].texture.close();
			this.regions[region.pos.regionX, region.pos.regionY] = null;
			//this.regions[region.pos.getRegion_x(), region.pos.getRegion_y()].cells = null;
			//this.regions[region.pos.getRegion_x(), region.pos.getRegion_y()] = null;
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
					if (Consts.tick - this.regions[x, y].update_tick > Consts.region_lifetime)
					{
						this.unloadRegion(this.regions[x, y]);
					}
					
					//if (Consts.tick - this.regions[x, y].update_tick == Consts.render_lifetime && this.regions[x, y].texture != null)
					//{
						//this.regions[x, y].texture = null;
					//}
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
		{
			this.entities.nth_data(x).tick();
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
	}
}

class RegionGenerator : Object
{
	public World world;
	//The regions that are in the generation quewe
	public Gee.ArrayList<Region?> generating_regions;
	//The operation that needs to be performed on them
	public Gee.ArrayList<string> generating_regions_operation;
	//The mutex lock
	public Mutex mutex;
	
	public RegionGenerator(World world)
	{
		this.world = world;
		
		//Which regions should the independent thread generate?
		this.generating_regions = new Gee.ArrayList<Region?>();
		//The operation
		this.generating_regions_operation = new Gee.ArrayList<string>();
		//The mutex lock
		this.mutex = Mutex();
	}
	
	public void* generateMethod()
	{
		while (true)
		{
			if (this.generating_regions.size > 0)
			{
				this.mutex.lock();
				string operation = this.generating_regions_operation[0];
				Region? region = this.generating_regions[0];
				this.mutex.unlock();
				
				if (operation == "generate")
				{
					region.generate();
				}
				else if (operation == "generate_empty")
				{
					region.generateEmpty();
				}
				else if (operation == "load_cells")
				{
					region.loadCells();
				}
				else if (operation == "render")
				{
					region.render();
				}
				
				this.mutex.lock();
				if (this.generating_regions.size > 0)
				{
					this.generating_regions.remove_at(0);
					this.generating_regions_operation.remove_at(0);
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
}
