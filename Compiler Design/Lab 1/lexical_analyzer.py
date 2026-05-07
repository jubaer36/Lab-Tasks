import re


keywords = ["int", "float", "if", "else", "while", "for", "return", "var"]
whitespace = [" ", "\n", "\t"]
delimiters = ["(", ")", "{", "}", ";", ","]
operators = ["+", "-", "*", "/", "=", "==", "!=", "<", ">", "<=", ">="]

identifier_pattern = r"[a-zA-Z_][a-zA-Z0-9_]*"
integer_pattern = r"[0-9]+"
float_pattern = r"[0-9]+\.[0-9]+"


def is_keyword(token):
    return token in keywords


def is_delimiter(token):
    return token in delimiters


def is_operator(token):
    return token in operators


def is_identifier(token):
    return re.fullmatch(identifier_pattern, token) is not None


def is_integer(token):
    return re.fullmatch(integer_pattern, token) is not None


def is_float(token):
    return re.fullmatch(float_pattern, token) is not None


def print_token(token_type, lexeme):
    print(f"<{token_type}, {lexeme}>")


def identify_token(lexeme):
    if is_keyword(lexeme):
        print_token("KEYWORD", lexeme)
    elif is_float(lexeme):
        print_token("NUMBER", lexeme)
    elif is_integer(lexeme):
        print_token("NUMBER", lexeme)
    elif is_identifier(lexeme):
        print_token("IDENTIFIER", lexeme)
    else:
        print_token("INVALID", lexeme)


def lexical_analyzer(filename):
    lexeme = ""
    pending_char = ""

    with open(filename, "r") as file:
        while True:
            if pending_char != "":
                char = pending_char
                pending_char = ""
            else:
                char = file.read(1)

            if char == "":
                if lexeme != "":
                    identify_token(lexeme)
                break

            if char in whitespace:
                if lexeme != "":
                    identify_token(lexeme)
                    lexeme = ""
                continue

            if char in delimiters:
                if lexeme != "":
                    identify_token(lexeme)
                    lexeme = ""
                print_token("DELIMITER", char)
                continue

            if char in operators:
                if lexeme != "":
                    identify_token(lexeme)
                    lexeme = ""

                next_char = file.read(1)
                possible_operator = char + next_char

                if possible_operator in operators:
                    print_token("OPERATOR", possible_operator)
                else:
                    if char in operators:
                        print_token("OPERATOR", char)
                    else:
                        print_token("INVALID", char)

                    pending_char = next_char

                continue

            if char.isalnum() or char == "_" or char == ".":
                lexeme += char
                continue

            if lexeme != "":
                identify_token(lexeme)
                lexeme = ""

            print_token("INVALID", char)


if __name__ == "__main__":
    lexical_analyzer("input.txt")
        
