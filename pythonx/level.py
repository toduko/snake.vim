def is_valid_level(filename):
    try:
        with open(filename) as file:
            level = (file.read().split('\n'))[:-1]
            rows = len(level) - 2
            cols = len(level[0]) - 2
            food_count, snake_count = 0, 0

            for row in range(rows):
                food_count = food_count + level[row+1].count('o')
                snake_count = snake_count + level[row+1].count('*')
            
            if food_count != 1 and snake_count != 1:
                return False

            def helper(line):
                for symbol in line:
                    if symbol not in '|+-#o* ':
                        return False

                return len(line) == cols + 2 and line[0] == '|' and line[-1] == '|'

            if rows < 5 or cols < 5:
                return False

            if level[0] != "".join(['+'] + ['-'] * cols + ['+'])\
                or level[-1] != "".join(['+'] + ['-'] * cols + ['+']):
                return False

            if len(list(filter(helper, level))) != rows:
                return False

            wall_count = sum(map(lambda line: line.count('#'), level))

            if wall_count / (rows * cols) > 0.35:
                return False
    except Exception:
        return False

    return True

def get_level_data(filename):
    with open(filename) as file:
        level = (file.read().split('\n'))[:-1]
        rows = len(level) - 2
        cols = len(level[0]) - 2
        snake = []
        food = [0, 0]
        walls = []
        for row in range(rows):
            for col in range(cols):
                if level[row+1][col+1] == '#': walls.append([col, row])
                elif level[row+1][col+1] == '*': snake.append([col, row])
                elif level[row+1][col+1] == 'o': food = [col, row]

        return [rows, cols, snake, food, walls]

    return []
