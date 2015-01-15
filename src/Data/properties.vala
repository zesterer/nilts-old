class Properties : Object
{
	private Gee.HashMap<string, Property> properties = new Gee.HashMap<string, Property>();
	
	public string getString(string name)
	{
		if (this.properties.has_key(name))
			return this.properties.get(name).getString();
		return "null";
	}
	
	public void setString(string name, string val)
	{
		var prop = new PropertyString();
		prop.setString(val);
		this.properties.set(name, prop);
	}
	
	public int32 getInt32(string name)
	{
		if (this.properties.has_key(name))
			return this.properties.get(name).getInt32();
		return -1;
	}
	
	public void setInt32(string name, int32 val)
	{
		var prop = new PropertyInt32();
		prop.setInt32(val);
		this.properties.set(name, prop);
	}
}

class Property
{
	public virtual string getString(){return "null";}
	public virtual void setString(string val){}
	public virtual int32 getInt32(){return -1;}
	public virtual void setInt32(int32 val){}
}

class PropertyString : Property
{
	private string val;
	
	public override string getString()
	{
		return this.val;
	}
	
	public override void setString(string val)
	{
		this.val = val;
	}
}

class PropertyInt32 : Property
{
	private int32 val;
	
	public override int32 getInt32()
	{
		return this.val;
	}
	
	public override void setInt32(int32 val)
	{
		this.val = val;
	}
}














class _Properties : Object
{
	private Gee.HashMap<string, int32> map_int = new Gee.HashMap<string, int32>();
	private Gee.HashMap<string, string> map_string = new Gee.HashMap<string, string>();
	
	public int32 getInt(string key)
	{
		return this.map_int[key];
	}
	
	public void setInt(string key, int32 data)
	{
		this.map_int[key] = data;
	}
	
	public string getStr(string key)
	{
		return this.map_string[key];
	}
	
	public void setStr(string key, string data)
	{
		this.map_string[key] = data;
	}
}
