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
			while ((data += data_stream.read_line(null)) != null)
			{
				data += "\n";
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
		
	}
}

class NMLParserObject
{
	public string name;
	public List<NMLParserProperty> properties;
}

class NMLParserProperty
{
	public string id;
	public string data;
}
