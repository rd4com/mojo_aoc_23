from python import Python

def main():
    python_open = Python.evaluate("open")
    handle = python_open("01_input_1.txt", "r")

    total = 0
    for line in handle:
        var digit:String = ""
        for c in line:
            if c.isdigit():
                digit = digit+c.to_string()
        if len(digit)==1:
            total+=atol(digit)
        else:
            total+=atol(digit[0]+digit[len(digit)-1])

    print(total)
    handle.close()
