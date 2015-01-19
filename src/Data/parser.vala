class NMLParser : Object
{
	private List<NMLParserObject> data;
	private string filename;
	
	public NMLParser()
	{
		this.data = new List<NMLParserObject>();
	}
	
	public void parseFile(string filename)
	{
		this.filename = filename;
		
		File file = File.new_for_path(this.filename);
		
		if (!file.query_exists())
		{
			Consts.output("The file '" + this.filename + "' does not exist.");
			return;
		}
		
		string data = "";
		
		//Check for errors
		try
		{
			DataInputStream data_stream = new DataInputStream(file.read());
		
			//The reading loop
			int count = 0;
			string line = "";
			while ((line = data_stream.read_line(null)) != null)
			{
				data += line + "\n";
				count += 1;
			}
			
			Consts.output("Read an NML file of length " + count.to_string() + " lines");
		}
		catch (Error error)
		{
			Consts.output(error.message, "ERROR");
			Consts.output("There was an error when trying to parse an NML file", "ERROR");
		}
		
		this.parseString(data);
	}
	
	public void parseString(string data)
	{
		this.data = new List<NMLParserObject>();
		
		string[] lines = data.split("\n");
		
		Consts.output("The string to parse is:\n" + data, "INFO");
		
		NMLParserObject object = new NMLParserObject("null");;
		for (int count = 0; count < lines.length; count ++)
		{
			string legal_string = this.findLegalLineSegment(lines[count]);
			
			if (legal_string.length > 0)
			{
				Consts.output("Segment: " + legal_string);
				
				if (legal_string == "{")
				{
					object = new NMLParserObject("");
				}
				else if (legal_string == "}")
				{
					this.data.append(object);
				}
				else if (legal_string[0].to_string() == "$")
				{
					object.name = legal_string[1:legal_string.length];
					Consts.output("The object name is set to " + object.name);
				}
				else if ("=" in legal_string)
				{
					string[] elements = this.propertyGetElements(legal_string);
					object.properties.append(new NMLParserProperty(elements[0], elements[1]));
					Consts.output("The property with name " + elements[0] + " is set to " + elements[1] + " in the object " + object.name);
				}
				else
				{
					Consts.output("Invalid line in NML. Ignoring.", "ERROR");
				}
			}
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
	
	public NMLParserObject? getObject(string name)
	{
		for (int x = 0; x < this.data.length(); x ++)
		{
			if (this.data.nth_data(x).name == name)
				return this.data.nth_data(x);
		}
		
		return null;
	}
}

class NMLParserObject
{
	public string name;
	public List<NMLParserProperty> properties;
	
	public NMLParserObject(string name)
	{
		this.name = name;
		this.properties = new List<NMLParserProperty>();
	}
	
	public string getProperty(string id)
	{
		for (int x = 0; x < this.properties.length(); x ++)
		{
			if (this.properties.nth_data(x).id == id)
				return this.properties.nth_data(x).data;
		}
		
		return "null";
	}
}

class NMLParserProperty
{
	public string id;
	public string data;
	
	public NMLParserProperty(string id, string data)
	{
		this.id = id;
		this.data = data;
	}
}
