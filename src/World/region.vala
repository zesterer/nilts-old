class Region : Object
{
	public weak World mother;
	
	public uint32 seed;
	public Position pos;
	
	private int64 _update_timeout_counter;
	
	private SFML.Graphics.RenderTexture? _texture;
	
	private Cell[,] cells;
	
	public bool isEmpty;
	private bool generateHasBeenCalled;
	private bool renderHasBeenCalled;
	public bool texture_empty;
	
	public Region(World mother, int32 x, int32 y, bool isEmpty = false)
	{
		this.mother = mother;
		
		this.pos = new Position(x * Consts.region_size_pixels, y * Consts.region_size_pixels);
		this.seed = mother.seed;
		this.updateTimeout();
		
		this.cells = new Cell[Consts.region_size, Consts.region_size];
		this.init();
		
		this.isEmpty = isEmpty;
		this.generateHasBeenCalled = false;
		this.renderHasBeenCalled = false;
		this.texture_empty = true;
		
		//It's nothing at the moment
		//this._texture = null;
	}
	
	public void init() //Set the region up correctly (not generation, just bare-bones)
	{
		for (int8 x = 0; x < Consts.region_size; x ++)
		{
			for (int8 y = 0; y < Consts.region_size; y ++)
			{
				this.cells[x, y] = {0, 0, 0, 0, 0};
			}
		}
	}
	
	//Destructor
	~Region()
	{
		//this._texture.close();
		this._texture = null;
		Consts.output("A region has been unloaded");
	}
	
	//Unload confirm event
	public bool canUnload()
	{
		if (this.isEmpty)
			return false;
		return true;
	}
	
	//The texture value. Can get, but not set.
	public unowned SFML.Graphics.RenderTexture? texture
	{
		get
		{
			if (this.texture_empty)
				this.renderUpdate();
			return this._texture;
		}
		set
		{Consts.output("Error: texture cannot be written to.");}
	}
	
	//Update the timeout counter such that the region will not yet be marked for unloading
	public void updateTimeout()
	{
		this._update_timeout_counter = this.mother.tick_counter;
	}
	
	public bool isOutdated()
	{
		if (this._update_timeout_counter + Consts.region_lifetime < this.mother.tick_counter)
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
		//Update the timeout to prevent dying
		this.updateTimeout();
		
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
						this.cells[x, y].ground_type = 2;
						//this.cells[x, y].altitude = 0;
					}
				}
			}
		
			Consts.output("Generated a region");
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
	}
	
	public void renderUpdate()
	{
		this.updateTimeout();
		
		if (this._texture == null)
			this._texture = new SFML.Graphics.RenderTexture(Consts.region_size_pixels, Consts.region_size_pixels, false);
		
		//Update the rendering
		this.renderHasBeenCalled = true;
		this.render();
	}
	
	public void render()
	{
		SFML.Graphics.Sprite cellsprite = new SFML.Graphics.Sprite();
		SFML.System.Vector2f position;
		
		SFML.Graphics.Color col;
		
		//Clear it
		this._texture.clear(SFML.Graphics.black);
		this._texture.set_active(true);
		
		unowned Cell cell;
		
		//Draw all the cells
		for (int x = 0; x < Consts.region_size; x ++)
		{
			for (int y = 0; y < Consts.region_size; y ++)
			{			
				//Find the cell
				cell = this.cells[x, y];
				GLib.Rand ran = new GLib.Rand.with_seed(this.seed + cell.seed + x * Consts.region_size + y);
				
				//Set the position in the texture
				position = {(float)(x * Consts.cell_size + Consts.cell_size / 2), (float)(y * Consts.cell_size + Consts.cell_size / 2)};
				cellsprite.set_position(position);
				
				//Set the texture
				cellsprite.set_texture(Textures.types.nth_data(GroundTypes.types[cell.ground_type].texture_number), true);
				cellsprite.set_origin({Consts.cell_size / 2, Consts.cell_size / 2});
				
				//The default scale and rotation
				cellsprite.set_scale({1, 1});
				cellsprite.set_rotation(0);
				
				//Give it some variation
				if (Consts.vary_cell_colour && GroundTypes.types[cell.ground_type].vary_texture_colour)
				{
					//The default colour
					col = {255, 255, 255, 255};
					
					//col.a = uint8.max(col.a + (uint8)uint32.min((int32)cell.temperature, 0), 128);
					col.r = (uint8)(col.r * ran.double_range(0.85, 1.0));
					col.g = (uint8)(col.g * ran.double_range(0.85, 1.0));
					col.b = (uint8)(col.b * ran.double_range(0.85, 1.0));
					//col.r = uint8.max(col.r - (uint8)ran.int_range(0, 50), 128);
					//col.g = uint8.max(col.g - (uint8)ran.int_range(0, 50), 128);
					//col.b = uint8.max(col.b - (uint8)ran.int_range(0, 50), 128);
					
					if (ran.boolean())
					{
						if (ran.boolean())
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
					
					//Set that colour
					cellsprite.set_color(col);
				}
				
				//Draw the ground finally!
				this._texture.draw_sprite(cellsprite, null);
				
				//Draw water below z = 0
				if (cell.altitude <= 0)
				{
					//Reset the cellsprite
					cellsprite.set_color({255, 255, 255, (uint8)double.min(double.max(-cell.altitude + 96, 96), 255)});
					cellsprite.set_rotation(0);
				
					//Set to the water texture
					cellsprite.set_texture(Textures.types.nth_data(3), true);
				
					//Draw the water
					this._texture.draw_sprite(cellsprite, null);
				}
			}
		}
		
		this._texture.display();
		this._texture.set_active(false);
		this.renderHasBeenCalled = false;
		this.texture_empty = false;
	}
	
	public void tick()
	{
		if (this.mother.tick_counter - this._update_timeout_counter > Consts.render_lifetime)
		{
			this.texture_empty = true;
			this._texture = null;
		}
	}
}

struct Cell
{
	public uint32 seed;
	
	public int16 ground_type;
	public int16 block_type;
	
	public double temperature;
	public double altitude;
	
	public string saveToString()
	{
		return (@"$(this.seed)|=|$(this.ground_type)|=|$(this.block_type)|=|$(this.temperature)|=|$(this.altitude)");
		//return string.join("|=|", this.seed.to_string(), this.block_type.to_string(), this.temperature.to_string(), this.altitude.to_string());
	}
	
	public void loadFromString(string data)
	{
		string[] values = data.split("|=|");
		//Why the crap do the uint32 and int16 data types not have a .parse() method? It's f*cking stupid...
		this.seed = (uint32)uint64.parse(values[0]);
		this.ground_type = (int16)uint64.parse(values[1]);
		this.block_type = (int16)uint64.parse(values[2]);
		this.temperature = double.parse(values[3]);
		this.altitude = double.parse(values[4]);
	}
}
