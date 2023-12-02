from python import Python

@value
@register_passable
struct game_structure:
    var red :Int
    var green: Int
    var blue: Int
    fn showed_amount_of_colored_cube(inout self,color: String,amount:Int):
        if color == "red":
            if amount >= self.red:
                self.red = amount
            return
        if color == "green":
            if amount >= self.green:
                self.green = amount
            return
        if color == "blue":
            if amount >= self.blue:
                self.blue = amount
            return

fn result_elf_request(games:DynamicVector[game_structure],request:game_structure)->Int:
    var final_result = 0

    for index in range(len(games)):
        let game = games[index]
        if game.red <= request.red:
            if game.green <= request.green:
                if game.green <= request.blue:
                    #+1 because index start at 0 not 1 like games
                    final_result+= (index+1)
    return final_result

fn main() raises:
    var f = open("02_input.txt", "r")
    var all_games = f.read()
    f.close()
    
    var int_conversion = Python.evaluate("int")
    var all_games_py = PythonObject(all_games).split("\n")
    var structured_games = DynamicVector[game_structure]()
    var game_id = 0
    
    for game in all_games_py:
        var splitted = game.split(":")
        var game_sets = splitted[1].split(";")
        var structured_game = game_structure(0,0,0)
        for game_set in game_sets:
            var cubes = game_set.split(",")
            for cube in cubes:
                let color_amount_tuple = cube.split(" ")
                let amount:Int = int_conversion(color_amount_tuple[1]).to_float64().to_int()
                let color:String = color_amount_tuple[2].to_string()
                structured_game.showed_amount_of_colored_cube(color,amount)
        structured_games.push_back(structured_game)
        game_id+=1

    let elf_request = game_structure(12,13,14)
    print(result_elf_request(structured_games,elf_request))
