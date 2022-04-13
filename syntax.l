%{
    #include <iostream>

    void foo();

    int num_chars = 0;
%}

/* Comment? */

DIGIT   [0-9]

%option yylineno
%option noyywrap

%%

c {
    std::cout << "Recognized 'c'" << std::endl;
}

cat {
    std::cout << "Recognized 'cat'" << std::endl;
}

cat|dog {
    std::cout << "Recognized 'cat' or 'dog'" << std::endl;
}

ca*t {
    /* cat, caaaaaat, caaaaaaaaaaaat, ct */
    std::cout << "Matched: " << yytext << std::endl;
    std::cout << "  it's " << yyleng << " characters long" << std::endl;
    std::cout << "  on line number " << yylineno << std::endl;
}

ca {
    /* ca */
}

ca?t {
    /* cat, ct */
}

c.t {
    /* cat, cbt, cct, cdt, etc. */
}

\n {
    /* newline */
}

c\.t {
    /* c.t */
}

[abc] {
    /* a, b, or c */
}

[0-9] {
    /* 0, 1, 2, 3, 4, 5, 6, 7, 8, or 9 */
}

{DIGIT}\.{DIGIT}+ {}

[^abc] {
    /* NOT a, b, or c */
}

[^a] {

}

[^b] {

}

[^c] {}

[^0-9] {
    /* NOT 0, 1, 2, 3, 4, 5, 6, 7, 8, or 9 */
}

^cat {
    /* cat at the beginning of a line */
}

cat$ {
    /* cat at the end of a line */
}

"[.$]" {
    /* The literal string [.$] */
}

(ca)*t {
    /* cat, cacat, cacacat, etc. */
}

ca{1,3}t {

}

<<EOF>> {
    /* end of file */
}

. {
    std::cerr << "Invalid character: " << yytext << " on line "
        << yylineno << std::endl;
}

%%

void foo() {
    return;
}

int main() {
    return yylex();
}
