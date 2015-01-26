class Position
{
	private double _x = 0;
	private double _y = 0;
	private double _z = 0;
	
	private double _mx = 0;
	private double _my = 0;
	private double _mz = 0;
	
	private double _mass = 0;
	
	public Position(int32 x, int32 y, double z = 0)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	public int32 x
	{
		get
		{return (int32)this._x;}	
		set
		{
			this.checkPosition();
			this._x = (double)value;
		}
	}
	
	public int32 y
	{
		get
		{return (int32)this._y;}	
		set
		{
			this.checkPosition();
			this._y = (double)value;
		}
	}
	
	public double z
	{
		get
		{return this._z;}
		set
		{
			this.checkPosition();
			this._z = value;
		}
	}
	
	public double mx
	{
		get
		{return this._mx;}
		set
		{this._mx = value;}
	}
	
	public double my
	{
		get
		{return this._my;}
		set
		{this._my = value;}
	}
	
	public double mz
	{
		get
		{return this._mz;}
		set
		{this._mz = value;}
	}
	
	public double mass
	{
		get
		{return this._mass;}
		set
		{this._mass = value;}
	}
	
	public int32 regionX
	{
		get
		{return (int32)this._x / Consts.region_size_pixels;}	
		set
		{this._x = (double)value * Consts.region_size_pixels;}
	}
	
	public int32 regionY
	{
		get
		{return (int32)this._y / Consts.region_size_pixels;}	
		set
		{this._y = (double)value * Consts.region_size_pixels;}
	}
	
	public void setPos(int32 x, int32 y, double z = 0)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.checkPosition();
	}
	
	public void add(double x, double y, double z = 0)
	{
		this._x += x;
		this._y += y;
		this._z += z;
		this.checkPosition();
	}
	
	public void accelerate(double x, double y, double z = 0)
	{
		this._mx += x;
		this._my += y;
		this._mz += z;
	}
	
	public void applyForce(double fx, double fy, double fz = 0)
	{
		this._mx += fx / this._mass;
		this._my += fy / this._mass;
		this._mz += fz / this._mass;
	}
	
	public void drag(double amount, bool andz = false)
	{
		//Do we have mass? If so, use it!
		if (this._mass > 0)
			amount /= this._mass;
		
		this._mx -= Math.copysign(amount * Math.pow(Math.fabs(this._mx), 1.2), this._mx);
		this._my -= Math.copysign(amount * Math.pow(Math.fabs(this._my), 1.2), this._my);
		if (andz)
			this._mz -= Math.copysign(amount * Math.pow(Math.fabs(this._mz), 1.2), this._mz);
	}
	
	public void checkPosition()
	{
		if (this._x < 0)
			this._x = 0;
		if (this._y < 0)
			this._y = 0;
		if (this._x > Consts.world_size_pixels)
			this._x = Consts.world_size_pixels;
		if (this._y > Consts.world_size_pixels)
			this._y = Consts.world_size_pixels;
	}
	
	public void tick()
	{
		this.add(this._mx, this._my, this._mz);
	}
}
