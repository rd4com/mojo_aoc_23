from python import Python
def py_len(arg:PythonObject)->Int: return py_to_int(arg.__len__())
def py_to_int(arg:PythonObject)->Int: return arg.to_float64().to_int()

@value
@register_passable
struct Number:
    var value:Int
    var first:Int
    var last:Int
    var row:Int

def main():
    py_int = Python.evaluate("int")
    var inputs:PythonObject
    with open("03_input.txt","r") as f:
        inputs = f.read()
    splitted = inputs.split("\n")

    array = DynamicVector[Number]()
    row=0
    for l in splitted:
        number = PythonObject("")
        x = 0
        for c in l:
            number_complete = True
            if c.isdigit():
                number = number+c
                number_complete = False
                if x == (py_len(l)-1):
                    number_complete = True #in case it is last c
            
            if number_complete:
                if py_len(number)>0:
                    array.push_back(Number(py_to_int(py_int(number)),x-py_len(number),x-1,row))
                number = PythonObject("")
            x+=1
        row+=1
    
    total=0
    for i in range(len(array)):

        rows_to_check = PythonObject([])
        rows_to_check.append(array[i].row)

        #check above and below too
        if array[i].row > 0:
            rows_to_check.append(array[i].row-1)
        if (array[i].row+1)<py_len(splitted):
            rows_to_check.append(array[i].row+1)

        valid = False

        for row in rows_to_check:
            #check left and right too
            first_x = array[i].first -1
            if first_x<0: first_x=0
            last_x = array[i].last+1
            if last_x>=py_len(splitted[row]): last_x = array[i].last

            for c in range(first_x,last_x+1):
                if (not splitted[row][c].isdigit()) and splitted[row][c]!=".":
                    valid = True
        if valid==True: total+=array[i].value
    
    print(total)
