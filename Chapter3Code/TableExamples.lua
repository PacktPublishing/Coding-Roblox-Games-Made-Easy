local myTable = {"Tofu", "Milk", "Bacon"}
local firstItem = myTable[1]
print(firstItem, myTable[2], myTable[3])


local items = {"Elephant", "Towel", "Turtle"}
table.insert(items, 1, "Rock")
table.insert(items, "Cat")


items = {"Rock", "Elephant", "Towel", "Turtle", "Cat"}
table.remove(items, 1)


table.remove(items, 2)


print(#items == table.getn(items))