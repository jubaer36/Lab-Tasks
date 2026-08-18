# Compiler Design Labs — Build & Run

Commands to compile and run each lab. Run `yacc`/`lex` (symlinks to `bison -y`/`flex`
on most Linux systems) from inside each lab's directory so generated files land there.

## Lab 2 — Token counter/classifier (lex only, no yacc)

`210041226_2B_Lab02.l` has its own `main()` and reads `input.txt` → writes `output.txt`.
No grammar needed here.

```bash
cd "Lab 2"
lex 210041226_2B_Lab02.l          # → lex.yy.c
cc lex.yy.c -o lab2 -lfl
./lab2
cat output.txt
```

## Lab 3 — Expression calculator (lex + yacc)

`210041226_2B_Lab03.y`'s `main()` just calls `yyparse()` — it reads from **stdin**,
not a file.

```bash
cd "Lab 3"
yacc -d 210041226_2B_Lab03.y      # → y.tab.c, y.tab.h
lex 210041226_2B_Lab03.l          # → lex.yy.c
cc lex.yy.c y.tab.c -o lab3 -lfl -lm
./lab3
```

Then type an expression and press Enter, e.g. `3 + 4 * 2`, Ctrl+D to quit.
Or feed it from the existing `input.txt`: `./lab3 < input.txt`

## Lab 5 — HTML structure validator

`validator.l` uses `%option noyywrap`, so `-lfl` isn't required. `main()` reads
`input.html` (or `argv[1]`) → writes `output.txt`.

```bash
cd "Lab 5"
yacc -d validator.y                # → y.tab.c, y.tab.h
lex validator.l                    # → lex.yy.c
cc lex.yy.c y.tab.c -o validator -lm
./validator                        # uses input.html by default
# or: ./validator somefile.html
cat output.txt
```

## Lab 6 — Three-address code generator

`lexer.l` also uses `%option noyywrap`. `main()` reads `input.txt` (or `argv[1]`) →
writes `output.txt` with the generated TAC.

```bash
cd "Lab 6"
yacc -d parser.y                   # → y.tab.c, y.tab.h
lex lexer.l                        # → lex.yy.c
cc lex.yy.c y.tab.c -o tac -lm
./tac                              # uses input.txt by default
# or: ./tac somefile.txt
cat output.txt
```

### Notes

- These dirs already contain stale generated artifacts (`lex.yy.c`, `y.tab.c`/`.h`,
  old binaries) from previous runs — the commands above just overwrite them.
- If `yacc`/`lex` aren't found on your system, substitute `bison -d -y file.y` and
  `flex file.l` directly.
