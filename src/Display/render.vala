namespace Render
{	
	void drawMap(SFML.Graphics.RenderWindow window, World world, Position pos)
	{
		float regionx;
		float regiony;
		
		SFML.Graphics.Sprite sprite = new SFML.Graphics.Sprite();
		SFML.System.Vector2f draw_position;
		
		//The TOTAL width - including rotation, since the view width shown changes through rotation.
		int regions_in_window_x = Consts.view_cartesian_width / Consts.region_size_pixels + 4;
		int regions_in_window_y = Consts.view_cartesian_height / Consts.region_size_pixels + 4;
		
		for (int x = -regions_in_window_x / 2; x < regions_in_window_x / 2; x ++)
		{
			for (int y = -regions_in_window_x / 2; y < regions_in_window_x / 2; y ++)
			{
				unowned SFML.Graphics.Texture? tex = null;
				Region? region;
				
				//Grab the bloody texture from the region and set it
				region = world.getRegion((int)pos.regionX + x, (int)pos.regionY + y);
				if (region.isEmpty || region.texture == null) //We're outside the world
				{
					if (region.texture == null)
						region.update();
					tex = null;
				}
				else
					tex = region.texture.get_texture();
				
				//We've got the texture, so keep it from unloading!
				region.updateTimeout();
				if (tex != null)
					sprite.set_texture(tex, false);
				
				//In what position are we drawing this crap? And set.
				regionx = -(float)(pos.x % Consts.region_size_pixels) + x * Consts.region_size_pixels;
				regiony = -(float)(pos.y % Consts.region_size_pixels) + y * Consts.region_size_pixels;
				draw_position = {regionx + Consts.view_width / 2, regiony + Consts.view_height / 2};
				sprite.set_position(draw_position);
				
				//Draw it! Finally!
				if (tex != null)
					window.draw_sprite(sprite, null);
			}
		}
	}
	
	void drawFog(SFML.Graphics.RenderWindow window, World world, Position pos)
	{
		if (Consts.draw_fog)
		{
			int32 regionx;
			int32 regiony;
		
			SFML.System.Vector2f draw_position;
		
			SFML.System.Vector2f shadingrect = {(float)(Consts.cell_size), (float)(Consts.cell_size)};;
			SFML.Graphics.RectangleShape shadingcell = new SFML.Graphics.RectangleShape();
			shadingcell.set_size(shadingrect);
		
			SFML.Graphics.Color sky_colour;
			SFML.Graphics.Color darkness;
			//The sky colour - sunset or sunrise?
			sky_colour = {100, 30, 150, 255};
			sky_colour = {255, 255, 255, 255};
		
			Region region;
			double alt;
			SFML.Graphics.Color col;
		
			draw_position = {0.0f, 0.0f};
		
			//The TOTAL width - including rotation, since the view width shown changes through rotation.
			int regions_in_window_x = Consts.view_cartesian_width / Consts.region_size_pixels + 4;
			int regions_in_window_y = Consts.view_cartesian_height / Consts.region_size_pixels + 4;
			
			for (int x = -regions_in_window_x / 2; x < regions_in_window_x / 2; x ++)
			{
				for (int y = -regions_in_window_x / 2; y < regions_in_window_x / 2; y ++)
				{
					//Grab the bloody texture from the region and set it
					region = world.getRegion((int)pos.regionX + x, (int)pos.regionY + y);
					//tex = region.texture.get_texture();
					//We've got the texture, so keep it from unloading!
					region.updateTimeout();
				
					//In what position are we drawing this? And set.
					regionx = -(int)(pos.x % Consts.region_size_pixels) + x * Consts.region_size_pixels;
					regiony = -(int)(pos.y % Consts.region_size_pixels) + y * Consts.region_size_pixels;
				
					for (int xx = 0; xx < Consts.region_size; xx ++)
					{
						for (int yy = 0; yy < Consts.region_size; yy ++)
						{
							draw_position = {(float)(regionx + xx * Consts.cell_size) + Consts.view_width / 2, (float)(regiony + yy * Consts.cell_size) + Consts.view_height / 2};
							//draw_position = {regionx, regiony};
							shadingcell.set_position(draw_position);
							
							//Use the inverse vectors to convert it back to a screen coordinate
							//It requires the plussing and minussing because the i and j vectors are designed for rotation about the centre of the view
							//Since the drawing of large textures is so large, we didn't do this in drawMap().
							draw_position.x -= Consts.view_width / 2;
							draw_position.y -= Consts.view_height / 2;
							draw_position = Consts.view_i_inverse.multiply(draw_position.x).add(Consts.view_j_inverse.multiply(draw_position.y));
							draw_position.x += Consts.view_width / 2;
							draw_position.y += Consts.view_height / 2;
							
							if (!(draw_position.x < -Consts.cell_size * 2 || draw_position.x > Consts.view_width + Consts.cell_size * 2 || draw_position.y < -Consts.cell_size * 2 || draw_position.y > Consts.view_height + Consts.cell_size * 2))
							{
								alt = region.getCell(xx, yy).altitude;
							
								//What colour are we using? Let's find out:
								if (alt > pos.z + Consts.fog_dist)
								{
									//Wow. It's higher. Make it brown.
									col = {32, 20, 10, (int8)Math.fabs(Math.fmax(0, Math.fmin(Consts.lightening_multiplier * (alt - pos.z) - Consts.fog_dist, 255)))};
								}
								else if (alt < pos.z - Consts.fog_dist)
								{
									//Wow. It's lower. Make it white. Is this racist?
									col = {sky_colour.r, sky_colour.g, sky_colour.b, (int8)Math.fabs(Math.fmax(0, Math.fmin(Consts.lightening_multiplier * (pos.z - alt) - Consts.fog_dist, 255)))};
								}
								else
								{
									//Default colour - TRANSPARENT :D
									col = {0, 0, 0, 0};
								}
						
								if (col.a != 0)
								{
									//Duh
									shadingcell.set_fill_color(col);
									window.draw_rectangle_shape(shadingcell, null);
								}
							}
						}
					}
					
					//Reset the colour
					shadingcell.set_fill_color({255, 255, 255, 255});
				}
			}
		}
	}
		
	void drawEntities(SFML.Graphics.RenderWindow window, World world, Position pos)
	{
		SFML.Graphics.Sprite cellsprite = new SFML.Graphics.Sprite();
		SFML.System.Vector2f draw_position;
		
		Entity entity;
		
		for (int x = 0; x < world.entities.length(); x ++)
		{
			//define the entity for convenience
			entity = world.entities.nth_data(x);
			
			//Set the position
			float posx = (float)(entity.pos.x - pos.x);
			float posy = (float)(entity.pos.y - pos.y);
			draw_position = {posx + Consts.view_width / 2, posy + Consts.view_height / 2};
			cellsprite.set_position(draw_position);
			
			//Set the rotation
			cellsprite.set_rotation(entity.rot);
			
			//Set the origin
			draw_position = {(float)(Consts.cell_size / 2), (float)(Consts.cell_size / 2)};
			cellsprite.set_origin(draw_position);
			
			cellsprite.set_texture(Textures.types[5], true);
			
			window.draw_sprite(cellsprite, null);
		}
	}
	
	void drawUIElements(SFML.Graphics.RenderWindow window, World world, Display display)
	{
		SFML.Graphics.Sprite cellsprite = new SFML.Graphics.Sprite();
		SFML.System.Vector2f draw_position;
		unowned SFML.Graphics.Texture tex;
		
		UIElement element;
		
		for (int x = 0; x < display.ui_elements.length(); x ++)
		{
			//define the entity for convenience
			element = display.ui_elements.nth_data(x);
			
			//Set the position
			draw_position = {element.anim_x, element.anim_y};
			
			draw_position = Consts.view_i.multiply(draw_position.x).add(Consts.view_j.multiply(draw_position.y));
			draw_position.x += Consts.view_width / 2;
			draw_position.y += Consts.view_height / 2;
			cellsprite.set_position(draw_position);
			
			//Set the rotation
			cellsprite.set_rotation(element.rot + Consts.view_rotation);
			
			//Set the texture
			tex = element.texture.get_texture();
			cellsprite.set_texture(tex, true);
			
			window.draw_sprite(cellsprite, null);
		}
	}
}
