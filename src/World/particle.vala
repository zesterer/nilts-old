class Particle : GLib.Object
{
	public Position pos;
	public SFML.Graphics.Color col;
	public int lifetime;
	public float size;

	public Particle(Position pos, SFML.Graphics.Color col = {255, 255, 255, 255}, int lifetime = 60, float size = 8.0f)
	{
		this.pos = pos;
		this.col = col;
		this.lifetime = lifetime;
		this.size = size;
	}
	
	public void tick()
	{
		this.pos.tick();
		this.lifetime -= 1;
		//if (this.lifetime < 127)
			//this.col = {this.col.r, this.col.g, this.col.b, (uint8)this.lifetime * 2};
		while (this.lifetime < this.col.a && this.col.a > 0)
			this.col.a -= 1;
	}
}
