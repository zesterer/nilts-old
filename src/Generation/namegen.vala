using GLib;

class NameGenerator : GLib.Object
{
	public static string generateRandom(uint32 seed)
	{
		Random.set_seed(seed);
		
		//A selection of un-pronounceables made pronounceable.
		string[] lang_constarts = {"br", "dr", "gr", "kr", "pr", "st", "tr", "bl", "gl", "kl", "ph", "pl", "sc", "sh", "sl", "sm", "sn", "squ", "sw", "tw", "ol", "al", "ad", "or", "os", "ind", "ev", "erd", "ed", "hy", "d'y", "dyl", "ryl", "gl", "o'", "e'", "erd", "h"};
		string[] lang_vowels = {"a", "e", "i", "o", "u", "ia", "ou"};
		string[] lang_rare_vowels = {"oo", "ou", "ua", "ee", "ie"};
		string[] lang_constends = {"c", "f", "h", "j", "l", "m", "n", "w", "x", "y", "z", "b", "d", "g", "k", "p", "r", "s", "t", "v", "gh", "ght", "ck", "st", "sh", "ph", "ry", "mp", "ny", "rst", "ble", "rf"};
		
		string name = "";
		
		bool usingend = false;
		for (int c = 0; c < Random.int_range(1, 2); c ++)
		{
			name += lang_constarts[Random.int_range(0, lang_constarts.length)];
			if (Random.int_range(0, 3) == 1)
			{
				name += lang_rare_vowels[Random.int_range(0, lang_rare_vowels.length)];
			}
			else
			{
				name += lang_vowels[Random.int_range(0, lang_vowels.length)];
			}
			name += lang_constends[Random.int_range(0, lang_constends.length)];
			
			if (Random.int_range(0, 3) == 1)
			{
				name += lang_vowels[Random.int_range(0, lang_vowels.length)];
				usingend = true;
			}
		}
		
		if (usingend == true && Random.int_range(0, 2) > 0)
		{
			name += lang_constends[Random.int_range(0, lang_constends.length)];
		}
		
		return name;
	}
}
