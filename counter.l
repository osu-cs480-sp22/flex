%{
    #include <iostream>

    int num_lines = 0;
    int num_words = 0;
    int num_chars = 0;
    int num_ints = 0;
%}

%option noyywrap

%%

\n {
    num_lines++;
    num_chars++;
}

int {
    num_ints++;
    REJECT;
}

[^ \t\n]+ {
    num_words++;
    num_chars += yyleng;
}

. {
   num_chars++;
}

%%

int main() {
    yylex();
    std::cout << "\t" << num_lines << "\t" << num_words
        << "\t" << num_chars << "\t" << num_ints << std::endl;
    return 0;
}
