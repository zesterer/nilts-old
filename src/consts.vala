namespace Consts
{
	public const string name = "NILTS";
	public const string version = "0.0.0";
	public const uint8[] version_values = {0, 0, 0};
	public const string name_full = Consts.name + " " + Consts.version;
	
	public File data_directory;
	
	public const string resource_pack_name = "default";
	public const string resources_location = "resources/" + Consts.resource_pack_name + "/";
	public const string graphics_location = Consts.resources_location + "graphics/";
	public const string groundtypes_location = Consts.graphics_location + "ground/";
	public const string blocktypes_location = Consts.graphics_location + "block/";
	public const string canopy_location = Consts.graphics_location + "canopy/";
	public const string entitytypes_location = Consts.graphics_location + "entity/";
	public const string uielements_location = Consts.graphics_location + "ui/";
	public const string fonts_location = Consts.resources_location + "fonts/";
	
	public const string font_ui = "commodore.ttf";
	
	public const string sprite_location = "nilts-resources";
	
	public int view_width = 800;
	public int view_height = 500;
	public int view_cartesian_width = 0;
	public int view_cartesian_height = 0;
	public int view_max_size = 0;
	public int view_rotation = 0;
	public float view_rotation_radians = 0;
	public double screen_scale = 1.0;
	//Vector screen coordinates - for rotation, scaling, etc.
	public SFML.System.Vector2f view_i;
	public SFML.System.Vector2f view_j;
	public SFML.System.Vector2f view_i_inverse;
	public SFML.System.Vector2f view_j_inverse;
	
	public bool running = false;
	public int64 tick = 0;
	public const bool vsync = true;
	//The FPS timer
	public Timer timer;
	public double fps_target = 60;
	public double fps_current = 60;
	public bool has_threads = false;
	public const bool use_threads = false;
	
	//Game time in seconds
	public int64 game_time = 0;
	public const int day_length = 720;
	public const int light_time = Consts.day_length / 2;
	
	public const bool vary_cell_colour = true;
	public const bool draw_fog = true;
	public const int fog_dist = 40;
	public const double lightening_multiplier = 0.4;
	
	public const int world_size = 256;
	public const int region_size = 32;
	public const int cell_size = 32;
	
	public const int region_lifetime = 600;
	public const int render_lifetime = 300;
	
	public const int region_size_pixels = Consts.region_size * Consts.cell_size;
	public const int32 world_size_cells = Consts.world_size * Consts.region_size;
	public const int32 world_size_pixels = Consts.world_size * Consts.region_size * Consts.cell_size;
	
	public const int pos_frac_part = 256;
	
	public const bool debug = true;
	
	public void init()
	{
		Consts.data_directory = File.new_for_path(GLib.Path.build_filename(GLib.Environment.get_user_config_dir(), Consts.name.down()));
		if (Consts.data_directory.query_exists() != true)
		{
			//Create it since it doesn't exist.
			Consts.output("Creating the data directory since it does not exist.");
			Consts.data_directory.make_directory();
		}
		Consts.output("The data directory is " + Consts.data_directory.get_path());
	}
	
	public void output(string message, string type = "DEBUG")
	{
		if (Consts.debug || type != "DEBUG")
			stdout.printf("[" + type.up() + "] " + message + "\n");
	}
}

namespace Seed
{
	uint32 getSeedFromPos(uint32 seed, uint32 x, uint32 y)
	{
		GLib.Rand ran = new GLib.Rand.with_seed(seed + x);
		seed = ran.next_int();
		ran.set_seed(seed + y);
		return ran.next_int();
	}
}

namespace Maths
{
	public int32 abs(int32 val)
	{
		if (val < 0)
			return -val;
		return val;
	}
	
	public int8 dirToVect_x(int8 dir)
	{
		dir %= 8;
		if (dir < 2 || dir > 6)
			return 1;
		if (dir > 2 && dir < 6)
			return -1;
		return 0;
	}
	
	public int8 dirToVect_y(int8 dir)
	{
		dir %= 8;
		if (dir < 4)
			return -1;
		if (dir > 4)
			return 1;
		return 0;
	}
	
	public int vectorDirection(double x, double y)
	{
		return (int)(Math.atan2(x, -y) * 180 / Math.PI);
	}
	
	public int32 lerpValue(int32 a, int32 b, double x)
	{
		return (int32)(a + (double)(b - a) * x);
	}
	
	public int32 pointDistance(int32 x1, int32 y1, int32 x2, int32 y2)
	{
		return (int32)Math.fabs(Math.sqrt(Math.pow((double)(x1-x2), 2) + Math.pow((double)(y1-y2), 2)));
	}
	
	public int angleDifference(int angle0, int angle1)
	{
    	return ((((angle0 - angle1) % 360) + 540) % 360) - 180;
	}
	
	public int rotateTo(int direction, int target, int rate)
	{
		int diff = Maths.angleDifference(target, direction);
		if ((-rate <= diff && rate >= diff) || (rate <= diff && -rate >= diff))
			return direction + diff;
		else if ((diff <= -rate && rate >= -rate) || (rate <= -rate && diff >= -rate))
			return direction - rate;
		else
			return direction + rate;
	}
	
	public int pointDirection(int32 x0, int32 y0, int32 x1, int32 y1)
	{
		return (int)(-Math.atan2(-(y0 - y1),x0 - x1) * 180 / Math.PI);
	}
	
	public double lerp(double a, double b, double x)
	{
		return a + (b - a) * x;
	}
}
