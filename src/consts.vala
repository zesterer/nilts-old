namespace Consts
{
	public const string name = "NILTS";
	public const string version = "0.0.0";
	public const uint8[] version_values = {0, 0, 0};
	public const string name_full = Consts.name + " " + Consts.version;
	
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
	public double screen_scale = 1;
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
	public double time_delta = 1.0;
	public bool has_threads = false;
	public const bool use_threads = false;
	
	//Game time in seconds
	public int64 game_time = 0;
	public const int day_length = 720;
	public const int light_time = Consts.day_length / 2;
	
	public const bool vary_cell_colour = true;
	public const bool draw_fog = true;
	public const int fog_dist = 60;
	
	public const int world_size = 256;
	public const int region_size = 32;
	public const int cell_size = 32;
	
	public const int region_lifetime = 600;
	public const int render_lifetime = 10;
	
	public const int region_size_pixels = Consts.region_size * Consts.cell_size;
	public const int32 world_size_cells = Consts.world_size * Consts.region_size;
	public const int32 world_size_pixels = Consts.world_size * Consts.region_size * Consts.cell_size;
	
	public const int pos_frac_part = 256;
	
	public const bool debug = true;
	
	void output(string message)
	{
		stdout.printf("%s\n", message);
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
	
	public int32 lerpValue(int32 a, int32 b, double x)
	{
		return (int32)(a + (double)(b - a) * x);
	}
	
	public uint32 pointDistance(int32 x1, int32 y1, int32 x2, int32 y2)
	{
		return (uint32)Math.sqrt(Math.pow((double)(x1-x2), 2) + Math.pow((double)(y1-y2), 2));
	}
}
