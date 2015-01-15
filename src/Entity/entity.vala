class Entity : Object
{
	public uint32 seed;
	public World mother;
	public string name;
	public Position pos;
	public int rot;
	
	public Entity(uint32 seed, World mother)
	{
		this.seed = seed;
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
		double x, y;
		
		if (Math.fabs(this.mother.player.pos.x - this.pos.x) > 64)
			x = Math.copysign(2, this.mother.player.pos.x - this.pos.x);
		else
			x = 0;
		
		if (Math.fabs(this.mother.player.pos.y - this.pos.y) > 64)
			y = Math.copysign(2, this.mother.player.pos.y - this.pos.y);
		else
			y = 0;
		
		this.pos.accelerate(x, y);
		this.pos.drag(0.3);
		this.pos.z = this.mother.getCell(this.pos.x, this.pos.y).altitude;
		this.pos.tick();
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
		this.pos.drag(0.2);
		this.pos.tick();
	}
}
