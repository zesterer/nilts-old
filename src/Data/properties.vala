public class ObjectProperties : Object
{
	private Gee.HashMap<string, int32> map_int;
	private Gee.HashMap<string, string> map_string;
	
	public ObjectProperties()
	{
		this.map_int = new Gee.HashMap<string, int32>();
		this.map_string =  new Gee.HashMap<string, string>();
	}
	
	public int32 getInt(string key)
	{
		if (key in this.map_int)
			return this.map_int[key];
		return -1;
	}
	
	public void setInt(string key, int32 data)
	{
		this.map_int[key] = data;
	}
	
	public string getStr(string key)
	{
		if (key in this.map_string)
			return this.map_string[key];
		return "NULL";
	}
	
	public void setStr(string key, string data)
	{
		this.map_string[key] = data;
	}
	
	public void setFromNMLObject(NMLObject object, string [] convert_format = {""})
	{
		string[] properties_list = object.getPropertyList();
		for (int count = 0; count < properties_list.length; count ++)
		{
			this.setStr(properties_list[count], object.getProperty(properties_list[count]));
		}
	}
}
