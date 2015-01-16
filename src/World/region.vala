/* class Region : Object
{
	public weak World parent;
	public uint32 seed;
	public Position pos;
	public int64 update_tick;
	public bool empty;
	
	public Cell[,] cells;
	
	public bool generated;
	public bool rendered;
	
	public SFML.Graphics.RenderTexture? texture;
	
	public Region(World parent, uint32 seed, int32 x, int32 y)
	{
		this.parent = parent;
		this.seed = seed;
		this.pos = new Position(x * Consts.region_size_pixels, y * Consts.region_size_pixels);
		this.update_tick = Consts.tick;
		this.empty = false;
		
		this.cells = new Cell[Consts.region_size, Consts.region_size];
		
		this.generated = false;
		this.rendered = false;
		
		//TODO - support for multi-threaded loading of cells
		//this.loadCells();
		
		this.texture = null;
	}
	
	~Region()
	{
		this.texture = null;
	}
	
	public void loadCells() //Load the cells into memory
	{
		GLib.Rand ran = new GLib.Rand.with_seed(this.seed);
		
		for (int x = 0; x < Consts.region_size; x ++)
		{
			for (int y = 0; y < Consts.region_size; y ++)
			{
				unowned Cell cell = {x, y, ran.next_int(), 0, null};
				this.cells[x, y] = cell;
			}
		}
	}
	
	public Cell getCell(int x, int y)
	{
		this.update_tick = Consts.tick;
		return this.cells[x, y];
	}
	
	public void generate()
	{
		this.generated = true;
		for (int x = 0; x < Consts.region_size; x ++)
		{
			for (int y = 0; y < Consts.region_size; y ++)
			{
				int32 val = NoiseTypes.types[0].getValueAt(this.pos.x / Consts.cell_size + x, this.pos.y / Consts.cell_size + y, this.seed);
				
				this.cells[x, y].altitude = val;
				
				if (val > 100)
					this.cells[x, y].ground_type = 1;
				else if (val > 0)
					this.cells[x, y].ground_type = 2;
				else
				{
					this.cells[x, y].ground_type = 3;
					this.cells[x, y].altitude = 0;
				}
			}
		}
		
		if (Consts.debug)
			Consts.output("Generated the region at (" + this.pos.regionX.to_string() + " ," + this.pos.regionY.to_string() + ").");
		
		this.update_tick = Consts.tick;
	}
	
	public void generateEmpty()
	{
		this.empty = true;
		for (int x = 0; x < Consts.region_size; x ++)
		{
			for (int y = 0; y < Consts.region_size; y ++)
			{
				this.cells[x, y].seed = Seed.getSeedFromPos(this.seed, x, y);
				this.cells[x, y].ground_type = 0;
			}
		}
		
		this.update_tick = Consts.tick;
	}
	
	public void update()
	{
		if (this.texture == null)
			this.texture = new SFML.Graphics.RenderTexture(Consts.region_size_pixels, Consts.region_size_pixels, false);
		
		//Update the cells and stuff
		//TODO - add threading support for rendering!!!
		if (Consts.has_threads)
		{
			//Add it to the quewe
			this.parent.region_generator.mutex.lock();
			if ((this in this.parent.region_generator.generating_regions) == false)
			{
				this.parent.region_generator.generating_regions.add(this);
				this.parent.region_generator.generating_regions_operation.add("render");
			}
			this.parent.region_generator.mutex.unlock();
		}
		else
		{
			//Straight-off render it
			this.render();
		}
	}
	
	public void render()
	{
		this.rendered = true;
		SFML.Graphics.Sprite cellsprite = new SFML.Graphics.Sprite();
		SFML.System.Vector2f position;
		
		SFML.Graphics.Color col;
		
		//Clear it
		this.texture.clear(SFML.Graphics.black);
		
		unowned Cell cell;
		
		//Draw all the cells
		for (int x = 0; x < Consts.region_size; x ++)
		{
			for (int y = 0; y < Consts.region_size; y ++)
			{			
				//Find the cell
				cell = this.cells[x, y];
				GLib.Rand ran = new GLib.Rand.with_seed(cell.seed);
				
				//Set the position in the texture
				position = {(float)(x * Consts.cell_size + Consts.cell_size / 2), (float)(y * Consts.cell_size + Consts.cell_size / 2)};
				cellsprite.set_position(position);
				
				//Set the texture
				cellsprite.set_texture(Textures.types[GroundTypes.types[cell.ground_type].texture_number], true);
				cellsprite.set_origin({Consts.cell_size / 2, Consts.cell_size / 2});
				
				//The default colour, scale and rotation
				col = {255, 255, 255, 255};
				cellsprite.set_scale({1, 1});
				cellsprite.set_rotation(0);
				
				//Give it some variation
				if (Consts.vary_cell_colour && GroundTypes.types[cell.ground_type].vary_texture_colour)
				{
					col.a = uint8.max(col.a + (uint8)uint32.min(cell.temperature, 0), 128);
					col.r = uint8.max(col.r - (uint8)ran.int_range(0, 20), 128);
					col.g = uint8.max(col.g - (uint8)ran.int_range(0, 20), 128);
					col.b = uint8.max(col.b - (uint8)ran.int_range(0, 20), 128);
					
					if (ran.boolean())
					{
						if (Random.boolean())
						cellsprite.set_scale({1, 1});
						else
						cellsprite.set_scale({-1, 1});
					}
					else
					{
						if (ran.boolean())
						cellsprite.set_scale({1, -1});
						else
						cellsprite.set_scale({-1, -1});
					}
					
					cellsprite.set_rotation(Random.int_range(0, 4) * 90);
				}
				
				//Set that colour
				cellsprite.set_color(col);
				
				//Draw the ground finally!
				this.texture.draw_sprite(cellsprite, null);
			}
		}
		
		this.texture.display();
	}
	
	public bool unloadEvent()
	{
		if (Consts.debug)
			Consts.output("Unloading the region at (" + this.pos.regionX.to_string() + " ," + this.pos.regionY.to_string() + ").");
		
		return true;
	}
} 

struct Cell
{
	public int x;
	public int y;
	public uint32 seed;
	public int ground_type;
	public int? block_type;
	public int32 temperature;
	public double altitude;
}*/

class Region : Object
{
	public weak World mother;
	
	public uint32 seed;
	public Position pos;
	
	private int64 updateTimeoutCounter;
	
	private SFML.Graphics.RenderTexture? _texture;
	
	private Cell[,] cells;
	
	public bool isEmpty;
	private bool generateHasBeenCalled;
	private bool renderHasBeenCalled;
	
	public Region(World mother, int32 x, int32 y, bool isEmpty = false)
	{
		this.mother = mother;
		
		this.pos = new Position(x * Consts.region_size_pixels, y * Consts.region_size_pixels);
		this.seed = mother.seed;
		this.updateTimeoutCounter = this.mother.ticker;
		
		this.cells = new Cell[Consts.region_size, Consts.region_size];
		
		this.isEmpty = isEmpty;
		this.generateHasBeenCalled = false;
		this.renderHasBeenCalled = false;
		
		//It's nothing at the moment
		this._texture = null;
	}
	
	//Destructor
	~Region()
	{
		Consts.output("A region has been unloaded");
	}
	
	//Unload confirm event
	public bool canUnload()
	{
		return true;
	}
	
	//The texture value. Can get, but not set.
	public unowned SFML.Graphics.RenderTexture? texture
	{
		get
		{return this._texture;}
		set
		{Consts.output("Error: texture cannot be written to.");}
	}
	
	//Update the timeout counter such that the region will not yet be marked for unloading
	public void updateTimeout()
	{
		this.updateTimeoutCounter = this.mother.ticker;
	}
	
	public bool isOutdated()
	{
		if (this.updateTimeoutCounter + Consts.region_lifetime < this.mother.ticker)
			return true;
		return false;
	}
	
	//Find the cell corresponding to the in-region cell position
	public Cell? getCell(int x, int y)
	{
		this.updateTimeout();
		return this.cells[x, y];
	}
	
	//Generate the region
	public void generate()
	{
		if (this.isEmpty)
		{
			this.generateEmpty();
		}
		else
		{
			this.generateHasBeenCalled = true;
		
			for (int x = 0; x < Consts.region_size; x ++)
			{
				for (int y = 0; y < Consts.region_size; y ++)
				{
					int32 val = NoiseTypes.types[0].getValueAt(this.pos.x / Consts.cell_size + x, this.pos.y / Consts.cell_size + y, this.seed);
				
					this.cells[x, y].altitude = (double)val;
				
					if (val > 100)
						this.cells[x, y].ground_type = 1;
					else if (val > 0)
						this.cells[x, y].ground_type = 2;
					else
					{
						this.cells[x, y].ground_type = 3;
						this.cells[x, y].altitude = 0;
					}
				}
			}
		
			Consts.output("Generated a region");
		
			this.updateTimeout();
		}
	}
	
	//Generate the region but empty.
	private void generateEmpty()
	{
		this.generateHasBeenCalled = true;
		
		for (int x = 0; x < Consts.region_size; x ++)
		{
			for (int y = 0; y < Consts.region_size; y ++)
			{
				this.cells[x, y].seed = Seed.getSeedFromPos(this.seed, x, y);
				this.cells[x, y].ground_type = 0;
			}
		}
		
		Consts.output("Generated an empty region");
		
		this.updateTimeout();
	}
	
	public void update()
	{
		this.updateTimeout();
		this.renderHasBeenCalled = true;
		
		if (this._texture == null)
			this._texture = new SFML.Graphics.RenderTexture(Consts.region_size_pixels, Consts.region_size_pixels, false);
		
		//Update the rendering
		if (Consts.has_threads)
		{
			//Add it to the quewe
			this.mother.region_generator.mutex.lock();
			if ((this in this.mother.region_generator.generating_regions) == false)
			{
				this.mother.region_generator.generating_regions.add(this);
				this.mother.region_generator.generating_regions_operation.add("render");
			}
			this.mother.region_generator.mutex.unlock();
		}
		else
		{
			//Straight-off render it
			this.render();
		}
	}
	
	public void render()
	{
		SFML.Graphics.Sprite cellsprite = new SFML.Graphics.Sprite();
		SFML.System.Vector2f position;
		
		SFML.Graphics.Color col;
		
		//Clear it
		this.texture.clear(SFML.Graphics.black);
		
		unowned Cell cell;
		
		//Draw all the cells
		for (int x = 0; x < Consts.region_size; x ++)
		{
			for (int y = 0; y < Consts.region_size; y ++)
			{			
				//Find the cell
				cell = this.cells[x, y];
				GLib.Rand ran = new GLib.Rand.with_seed(cell.seed);
				
				//Set the position in the texture
				position = {(float)(x * Consts.cell_size + Consts.cell_size / 2), (float)(y * Consts.cell_size + Consts.cell_size / 2)};
				cellsprite.set_position(position);
				
				//Set the texture
				cellsprite.set_texture(Textures.types[GroundTypes.types[cell.ground_type].texture_number], true);
				cellsprite.set_origin({Consts.cell_size / 2, Consts.cell_size / 2});
				
				//The default colour, scale and rotation
				col = {255, 255, 255, 255};
				cellsprite.set_scale({1, 1});
				cellsprite.set_rotation(0);
				
				//Give it some variation
				if (Consts.vary_cell_colour && GroundTypes.types[cell.ground_type].vary_texture_colour)
				{
					col.a = uint8.max(col.a + (uint8)uint32.min((int32)cell.temperature, 0), 128);
					col.r = uint8.max(col.r - (uint8)ran.int_range(0, 20), 128);
					col.g = uint8.max(col.g - (uint8)ran.int_range(0, 20), 128);
					col.b = uint8.max(col.b - (uint8)ran.int_range(0, 20), 128);
					
					if (ran.boolean())
					{
						if (Random.boolean())
						cellsprite.set_scale({1, 1});
						else
						cellsprite.set_scale({-1, 1});
					}
					else
					{
						if (ran.boolean())
						cellsprite.set_scale({1, -1});
						else
						cellsprite.set_scale({-1, -1});
					}
					
					cellsprite.set_rotation(Random.int_range(0, 4) * 90);
				}
				
				//Set that colour
				cellsprite.set_color(col);
				
				//Draw the ground finally!
				this._texture.draw_sprite(cellsprite, null);
			}
		}
		
		this._texture.display();
		
		this.renderHasBeenCalled = false;
	}
}

struct Cell
{
	public int16 x;
	public int16 y;
	
	public uint32 seed;
	
	public int16 ground_type;
	public int16 block_type;
	
	public double temperature;
	public double altitude;
}
