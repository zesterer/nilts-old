class Inventory : Object
{
	private int32[,] grid;
	
	public Inventory(int width, int height)
	{
		this.grid = new int32[width, height];
	}
	
	public Item getAt(int x, int y)
	{
		return Items.items.nth_data(this.grid[x, y]);
	}
	
	public void setAt(int x, int y, Item item)
	{
		this.grid[x, y] = item.id;
	}
}
