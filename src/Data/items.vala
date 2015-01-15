namespace Items
{
	Gee.ArrayList<Item?> items;
	Gee.ArrayList<BaseItem> base_items;
	
	Items.BaseItem getBaseItem(int16 num)
	{
		for (int16 x = 0; x < Items.base_items.size; x ++)
		{
			if (Items.base_items[x].id == num)
				return Items.base_items[x];
		}
		return base_items[0];
	}
	
	Items.BaseItem getBaseMaterial(int16 num)
	{
		//TODO - this method isn't done yet.
		for (int16 x = 0; x < Items.base_items.size; x ++)
		{
			if (Items.base_items[x].id == num)
				return Items.base_items[x];
		}
		return base_items[0];
	}
	
	class BaseItem
	{
		public Items.ItemFactors factors;
		public Gee.ArrayList<string> properties;
		public string name;
		public int16 id;
	
		public BaseItem()
		{
			this.properties = new Gee.ArrayList<string>();
			this.factors = ItemFactors.create();
		}
	}
	
	struct ItemFactors
	{
		public double hardness;
		public double flexibility;
		public double mass;
		public double range;
		public double power
		public double flammability;
		public double conductivity;
		public double explosiveness;
		public double nutrition;
	
	
		public void multiply(ItemFactors factors)
		{
			this.hardness *= factors.hardness;
			this.flexibility *= factors.flexibility;
			this.mass *= factors.mass;
			this.range *= factors.range;
			this.power *= factors.power;
			this.flammability *= factors.flammability;
			this.conductivity *= factors.conductivity;
			this.explosiveness *= factors.explosiveness;
			this.nutrition *= factors.nutrition;
			
		}
	
		public static Items.ItemFactors create()
		{
			return {1, 1, 1, 1, 1, 1, 1, 1, 1};
		}
	}
}

struct Item
{
	public int32 id;
	public uint32 seed;
	public string name;
	public int16 base_material;
	public int16 base_item;
	
	public Items.ItemFactors getFactors()
	{
		Items.ItemFactors factors = Items.ItemFactors.create();
		
		//Multiply by the base item factors
		factors.multiply(Items.getBaseItem(this.base_item).factors);
		//...and by the material factors
		factors.multiply(Items.getBaseMaterial(this.base_material).factors);
		
		return factors;
	}
}
