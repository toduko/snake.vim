def is_valid_level(filename):
    with open(filename) as file:
        level = (file.read().split('\n'))[:-1]
        rows = len(level) - 2
        cols = len(level[0]) - 2

        def helper(line):
            for symbol in line:
                if symbol not in '|+-# ':
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

    return True
