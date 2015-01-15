namespace NoiseTypes
{
	NoiseType[] types;
	
	class NoiseType : GLib.Object
	{
		//The generator's seed
		public uint32 seed;
		//The number of layers (octaves)
		public int32 layers;
		//The largest data scale
		public int32 scale;
		//The range of data available
		public int32 range;
		//Are we centre-ing the focus?
		public bool centre;

		public NoiseType(bool centre, uint32 seed, int8 layers, int scale, int32 range)
		{
			this.seed = seed;
			this.layers = layers;
			this.scale = scale;
			this.range = range;
			this.centre = centre;
		}
	
		public int32 getRandomAtPos(int32 x, int32 y, uint32 addseed, uint32 seed2)
		{
			uint32 cseed = this.seed + addseed + seed2;
			GLib.Rand ran = new GLib.Rand.with_seed(x + cseed);
			cseed += ran.next_int();
			ran.set_seed(y + cseed);
			cseed += ran.next_int();
			ran.set_seed(cseed);
		
			int32 val = (int32)(ran.next_int() / 2) % this.range;
		
			return val;
		}
	
		public int32 getLayerAt(int32 x, int32 y, int layer, uint32 seed2)
		{
			/*FUCK. THIS. SHIT.
			Seriously. it's easier to just rewrite this method every time you want to change it.*/
			int cscale = this.scale / (int)Math.pow(2, layer);
		
			int32 square_x = (int32)x / (int32)cscale;
			int32 square_y = (int32)y / (int32)cscale;
		
			int mod_x = (int32)x % (int32)cscale;
			int mod_y = (int32)y % (int32)cscale;
		
			int32 upleft = getRandomAtPos(square_x, square_y, layer, seed2);
			int32 upright = getRandomAtPos(square_x + 1, square_y, layer, seed2);
			int32 downleft = getRandomAtPos(square_x, square_y + 1, layer, seed2);
			int32 downright = getRandomAtPos(square_x + 1, square_y + 1, layer, seed2);
		
			int32 uplerp = this.lerpValue(upleft, upright, mod_x, (int32)cscale);
			int32 downlerp = this.lerpValue(downleft, downright, mod_x, (int32)cscale);
		
			int32 val = this.lerpValue(uplerp, downlerp, mod_y, (int32)cscale);
		
			return val;
		}
	
		public int32 lerpValue(int32 a, int32 b, int32 low, int32 high)
		{
			return (int32)(a + (b * low) / high - (a * low) / high);
		}
	
		public int32 getValueAt(int32 x, int32 y, uint32 seed2)
		{
			int32 total = 0;
		
			for (int layer = 0; layer < this.layers; layer ++)
			{
				total += (this.getLayerAt((int32)x, (int32)y, layer, seed2) - this.range / 2) / ((int32)Math.pow(2, layer));
			}
		
			if (this.centre)
				return (int32)(this.range / 2) - (int32)Math.fabs(total);
		
			return total;
		}
	}
	
	public void define()
	{
		types = new NoiseType[1];
		types[0] = new NoiseType(false, 0, 2, 16, 1024);
	}
}
