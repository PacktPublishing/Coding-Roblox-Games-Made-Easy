local menu = {
	appetizer = "House salad";
	entree = "Ham sandwich";
	dessert = "Ice cream";
}


local meal = menu.entree
print(meal)


menu.entree = "Turkey sandwich"


local prices = {
	[0] = "Free";
	[5] = "Cheap";
	[20] = "Average";
	[50] = "Expensive";
}

print(prices[0])


local units = {
	["Heavy Soldier"] = {
		WalkSpeed = 16;
		Damage = 25;
	};

	Scout = {
		WalkSpeed = 25;
		Damage = 15;
	};
}