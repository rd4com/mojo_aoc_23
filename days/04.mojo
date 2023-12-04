def main():
    var input: PythonObject
    with open("04_input.txt","r") as f:
        input = f.read()
    games = input.split("\n")
    total = PythonObject(0)
    for g in games:
        splitted = g.split(":")
        winning_numbers = splitted[1].split("|")[0].split(" ")
        numbers = splitted[1].split("|")[1].split(" ")
        shift = PythonObject(0)
        for n in numbers:
            if n.isdigit():
                shift+=winning_numbers.count(n)
        total += ((1<<shift)>>1)
    print(total)
