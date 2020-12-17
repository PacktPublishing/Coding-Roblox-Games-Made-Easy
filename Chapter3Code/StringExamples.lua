local myString = "Hello"
myString = "He said \"I don't like apples!\""
myString = "Separated\tby\ttabs" 
print(myString)


myString = "Separated\nby\nlines" 
print(myString) 


myString = [[This string
can span
multiple lines.]] 


myString = "Hello"
myString = myString.. " World!"
print(myString)


local winnerName = "WinnerWinner"
myString = "Game over! ".. winnerName.. " has won the round!"
print(myString)


myString = "iT iS wARm tOdaY."
print(string.upper(myString))


print("50" + 100) 


--[[
myString = "Hello"
print(tonumber(myString)) ? nil
local myNumber = 100 + myString

"local myNumber = 100 + myString:3: attempt to perform arithmetic (add) on number and string"
]]