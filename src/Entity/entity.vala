class Entity : Object
{
	public uint32 seed;
	public World mother;
	public string name;
	public Position pos;
	public int rot;
	
	public Entity(uint32 seed, World mother)
	{
		GLib.Rand ran = new GLib.Rand.with_seed(seed);
		this.seed = ran.next_int();
		this.mother = mother;
		this.name = "Entity";
		this.pos = new Position(8, 8, 0);
		this.rot = 20;
	}
	
	public virtual void tick()
	{
		this.pos.tick();
	}
}

class NPC : Entity
{
	public string real_name;
	
	public NPC(uint32 seed, World mother)
	{
		base(seed, mother);
		this.real_name = NameGenerator.generateRandom(this.seed) + " " + NameGenerator.generateRandom(this.seed + 1);
		if (Consts.debug)
			Consts.output("An entity with the name of " + this.real_name.to_string() + " is created.");
	}
	
	public override void tick()
	{
		double x = 0;
		double y = 0;
		
		int32 dist = Maths.pointDistance(this.mother.player.pos.x, this.mother.player.pos.y, this.pos.x, this.pos.y);
		
		if (dist > 200)
		{
			x = 2 * (double)(this.mother.player.pos.x - this.pos.x) / (double)dist;
			y = 2 * (double)(this.mother.player.pos.y - this.pos.y) / (double)dist;
		}
		
		if (dist > 100)
			this.rot = Maths.rotateTo(this.rot, Maths.pointDirection(this.pos.x, this.pos.y, this.mother.player.pos.x, this.mother.player.pos.y) - 90, 5);
		
		this.pos.accelerate(x, y);
		//Friction with the ground
		this.pos.drag(0.3);
		this.pos.z = this.mother.getCell(this.pos.x, this.pos.y).altitude;
		this.pos.tick();
		
		this.createParticles();
	}
	
	public void createParticles()
	{
		if (this.mother.tick_counter % 10 < 2)
		{
			Position pos = new Position(this.pos.x, this.pos.y);
			GLib.Rand ran = new GLib.Rand.with_seed(this.seed + (int32)this.mother.tick_counter);
			//Randomise the position
			pos.add(ran.double_range(-0.4, 0.4), ran.double_range(-0.4, 0.4));
			SFML.Graphics.Color col = {165, 155, 85, 255};
			if (this.pos.z <= 0)
			{
				col = {200, 200, 250, 50};
				pos.accelerate(ran.double_range(-0.6, 0.6), ran.double_range(-0.6, 0.6));
				for (int c = 0; c < 4; c ++)
				{
					Position pos1 = new Position(this.pos.x, this.pos.y);
					pos1.accelerate(ran.double_range(-0.3, 0.3), ran.double_range(-0.3, 0.3));
					pos1.add(ran.double_range(-8, 8), ran.double_range(-8, 8));
					this.mother.particles.append(new Particle(pos1, col, 60, 4));
				}
			}
			else if (GroundTypes.types[this.mother.getCell(this.pos.x, this.pos.y).ground_type].name == "grass")
				col = {15, 55, 15, 255};
			this.mother.particles.append(new Particle(pos, col, 240, 4));
		}
	}
}

class Player : NPC
{
	public Player(uint32 seed, World mother)
	{
		base(seed, mother);
		if (Consts.debug)
			Consts.output("The player is created.");
	}
	
	public override void tick()
	{
		//TODO - Rewrite this whole fucking method. It's horrible. Every last line of it.
		//Seriously, don't even try to fix it. Bin all of it and start over.
		
		int speed = 1;
		int rot = this.rot;
		
		if (this.mother.event_manager.KEY_W)
			this.pos.accelerate(Consts.view_j.multiply(-speed).x, Consts.view_j.multiply(-speed).y);
		if (this.mother.event_manager.KEY_A)
			this.pos.accelerate(Consts.view_i.multiply(-speed).x, Consts.view_i.multiply(-speed).y);
		if (this.mother.event_manager.KEY_S)
			this.pos.accelerate(Consts.view_j.multiply(speed).x, Consts.view_j.multiply(speed).y);
		if (this.mother.event_manager.KEY_D)
			this.pos.accelerate(Consts.view_i.multiply(speed).x, Consts.view_i.multiply(speed).y);
		
		if (this.mother.event_manager.KEY_UP)
			rot = Consts.view_rotation;
		else if (this.mother.event_manager.KEY_LEFT)
			rot = Consts.view_rotation - 90;
		else if (this.mother.event_manager.KEY_DOWN)
			rot = Consts.view_rotation + 180;
		else if (this.mother.event_manager.KEY_RIGHT)
			rot = Consts.view_rotation + 90;
		else if (Math.fabs(this.pos.mx) > 0.1 || Math.fabs(this.pos.my) > 0.1)
			rot = Maths.vectorDirection(this.pos.mx, this.pos.my);
		
		//this.pos.z = this.mother.getCell(this.pos.x, this.pos.y).altitude;
		this.pos.z = double.max(0, this.mother.getAltitude(this.pos.x, this.pos.y));
		this.rot = Maths.rotateTo(this.rot, rot, 5);
		
		//Friction with the ground
		this.pos.drag(0.2);
		this.pos.tick();
		
		this.createParticles();
	}
}
