class Nullable2DArray<G> : GLib.Object
{
	//Hello. This class looks horrible. Sorry, but it is. Saving memory isn't easy though.
	//Please, don't even try touching this object. It just WORKS. Use it, sure. But don't
	//edit it. It was painstaking to make, and will probably be far worse to fix.
	
	private List<List<G?>> array;
	
	public Nullable2DArray(int width, int height)
	{
		this.array = new List<List<G?>?>();
		for (int x = 0; x < width; x ++)
		{
			this.array.append(new List<G?>());
			unowned List<G?> arraypart = this.array.nth_data(this.array.length() - 1);
			for (int y = 0; y < height; y ++)
			{
				arraypart.append(null);
			}
		}
	}
	
	public G? getAt(int x, int y)
	{
		if (this.array.length() < x)
			if (this.array.nth_data(x).length() < y)
				return this.array.nth_data(x).nth_data(y);
			else
				return null;
		else
			return null;
		return null;
	}
	
	public void setAt(int x, int y, G? data)
	{
		if (this.array.length() < x)
			if (this.array.nth_data(x).length() < y)
			{
				unowned List<G?> todelete1 = this.array.nth_data(x).nth(y);
				this.array.nth_data(x).delete_link(todelete1);
				this.array.nth_data(x).insert(data, y);
			}
	}
}
