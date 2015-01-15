namespace Items
{
	Gee.ArrayList<Item?> items;
}

struct Item
{
	public int32 id;
	public uint32 seed;
	public string name;
	public int16 material;
	public int16 base_item;
}

class Inventory : Object
{
	private int32[,] grid;
	
	public Inventory(int width, int height)
	{
		this.grid = new int32[width, height];
	}
	
	public Item getAt(int x, int y)
	{
		return Items.items[this.grid[x, y]];
	}
	
	public void setAt(int x, int y, Item item)
	{
		this.grid[x, y] = item.id;
	}
}
