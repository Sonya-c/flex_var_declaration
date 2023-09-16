/** Definitions */
%{
    int total_declarations = 0;
    int total_errors = 0;
%}

LETTER [a-zA-Z]
DIGIT [0-9]
NUM {DIGIT}+

ALFANUM {LETTER}|{NUM}
ID {LETTER}{ALFANUM}*

DIM {ID}|{NUM}
DIMS "("{DIM}(":"{DIM})*")"
ARR {ID}{DIMS}

ELEMENT {ID}|{ARR}
TYPE_DEC {ELEMENT}(","{ELEMENT})*(":"{ID})?
FULL_DEC ({TYPE_DEC}";")+


/** Rules: pattern  action */
%%
{FULL_DEC} {
    printf( "[Declaración de variables] %s\n", yytext);
    total_declarations++;
} 
[ \t\n]+ /* whitesp */
.* {
    printf("[Desconocido] %s\n", yytext);
    total_errors++;
}
%%

/** User code section */
int yywrap(){}

int main( int argc, char **argv )
    {
    ++argv, --argc; /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;
    yylex();
    printf("Total declarations = %d\n", total_declarations);
    printf("Total errors = %d\n", total_errors);

}