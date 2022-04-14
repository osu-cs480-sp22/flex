%{
    #include <iostream>
    #include <vector>

    struct token {
        std::string category;
        std::string lexeme;
    };

    std::vector<struct token> tokens;
    void save_token(std::string category, std::string lexeme) {
        struct token token = {
            .category = category,
            .lexeme = lexeme
        };
        tokens.push_back(token);
    }

    bool have_error = false;
%}

%option noyywrap
%option yylineno

%%

[ \t\n]*  /* Ignore whitespace */

[a-z][0-9]? {
    save_token("IDENTIFIER", yytext);
}

[0-9]+("."[0-9]+)? {
    save_token("NUMBER", yytext);
}

"=" {
    save_token("EQUALS", yytext);
}

"+" {
    save_token("PLUS", yytext);
}

"-" {
    save_token("MINUS", yytext);
}

"*" {
    save_token("TIMES", yytext);
}

"/" {
    save_token("DIVIDEDBY", yytext);
}

"(" {
    save_token("LPAREN", yytext);
}

")" {
    save_token("RPAREN", yytext);
}

";" {
    save_token("SEMICOLON", yytext);
}

. {
    std::cerr << "Invalid symbol on line " << yylineno << ": "
        << yytext << std::endl;
    have_error = true;
}

<<EOF>> {
    if (have_error) {
        return 1;
    }
    return 0;
}

%%

int main() {
    if (!yylex()) {
        for (int i = 0; i < tokens.size(); i++) {
            std::cout << tokens[i].category << "\t"
                << tokens[i].lexeme << std::endl;
        }
    }
}
