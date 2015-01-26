//NML Parser - pronounced 'enamel'
public class NMLParser : Object
{
	public signal void objectAdded(NMLObject object);
	
	public void parseFile(string filename)
	{
		File file = File.new_for_path(filename);
		string data = "";
		
		//Read the file and all of it's data
		try
		{
			DataInputStream data_stream = new DataInputStream(file.read());
		
			//Read each line, then add it to the data string until every line in the file is added.
			string line = "";
			for (int count = 0; (line = data_stream.read_line(null)) != null; count ++)
				data += line + "\n";
		}
		catch (Error error)
		{
			Consts.output(error.message, "ERROR");
			Consts.output("There was an error when trying to parse an NML file", "ERROR");
			return;
		}
		
		this.parseString(data);
	}
	
	public void parseString(string data)
	{
		string[] lines = data.split("\n");;
		
		NMLObject object = new NMLObject();
		for (int count = 0; count < lines.length; count ++)
		{
			string legal_string = this.findLegalLineSegment(lines[count]);
			
			if (legal_string.length == 0) //Don't accept illegal strings with no data
				break;
			
			if (legal_string == "{") //Reset the object
				object = new NMLObject();
			else if (legal_string == "}") //Ended the object
				this.objectAdded(object);
			else if (legal_string[0].to_string() == "$") //Settings the object name
				object.name = legal_string[1:legal_string.length];
			else if ("=" in legal_string) //It's a property
			{
				string[] elements = this.propertyGetElements(legal_string);
				object.addProperty(elements[0], elements[1]);
			}
			else //If all else fails, it must be invalid
				Consts.output("Invalid line in NML. Ignoring.", "ERROR");
		}
	}
	
	private string findLegalLineSegment(string line)
	{
		int start_count = 0;
		while (line[start_count].to_string() in "	 " && start_count < line.length)
			start_count ++;
		
		int end_count = 0;
		while (line[end_count].to_string() != ";" && end_count < line.length)
			end_count ++;
		
		return line[start_count:end_count];
	}
	
	private string[] propertyGetElements(string line)
	{
		int equals_count = 0;
		while (line[equals_count].to_string() != "=" && equals_count < line.length)
			equals_count += 1;
		
		int first_count = equals_count - 1;
		while (line[first_count].to_string() in "	 " && first_count > 0)
			first_count --;
		
		int last_count = equals_count + 1;
		while (line[last_count].to_string() in "	 " && last_count < line.length)
			last_count += 1;
		
		return {line[0:first_count + 1], line[last_count:line.length]};
	}
}



//The NML object class. For each NML object in an NML file
public class NMLObject
{
	private string _name;
	private List<NMLProperty> properties;
	
	public NMLObject()
	{
		this.name = "null";
		this.properties = new List<NMLProperty>();
	}
	
	public string name
	{
		get
		{return this._name;}
		set
		{this._name = value;}
	}
	
	public void addProperty(string id, string data)
	{
		this.properties.append(new NMLProperty(id, data));
	}
	
	public string[] getPropertyList()
	{
		string[] list = new string[this.properties.length()];
		
		for (int count = 0; count < this.properties.length(); count ++)
			list[count] = this.properties.nth_data(count).id;
		
		return list;
	}
	
	public string getProperty(string id)
	{
		for (int count = 0; count < this.properties.length(); count ++)
		{
			unowned NMLProperty property = this.properties.nth_data(count);
			if (property.id == id)
				return property.data;
		}
		return "";
	}
}



//The NML property class. For each NML property in an NML object
public class NMLProperty
{
	public string id;
	public string data;
	
	public NMLProperty(string id, string data)
	{
		this.id = id;
		this.data = data;
	}
}
