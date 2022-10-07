import std.stdio;
import std.string;
import std.variant;
import std.file;
import std.algorithm: canFind;
import std.conv;


enum TOKEN_TYPE
{
    PRINT,
    FUNC_CALL,
    FUNC_DEF,
    STRING_LITERAL,
    FORMATTED_STRING_LITERAL,
    DECLARATION,
    KIND_DECLARATION,
    PTR_DECLARATION,
    ASSIGNMENT,
    PTR_ASSIGNMENT,
    ARROW,
    DEREF,
    ADDRESS_OF,
    ADDITION,
    POW,
    RETURN_STATEMENT,
    SEMICOLON,
    NAME,
    VALUE,
    LEFT_PAREN,
    RIGHT_PAREN,
    LEFT_CURLY,
    RIGHT_CURLY,
    LEFT_SQUARE_BRACKET,
    RIGHT_SQUARE_BRACKET,
    COMMA,
    DOT,
    DOLLAR,
    COMMENT,
    PERCENT,
    EQUAL,
    GREATER_THAN,
    GREATER_THAN_OR_EQUAL,
    LESS_THAN,
    LESS_THAN_OR_EQUAL,
    NOT_EQUAL,
    PIPE,
    JUMP
}

enum OPERATION_KIND {
    WRITE_STDOUT,
    CREATE_GLOBAL_VAR,
    CREATE_LOCAL_VAR,
    CREATE_GLOBAL_PTR,
    CREATE_LOCAL_PTR,
    ADD
}

enum TYPE_KIND {
    NONE,
    INT,
    STR,
    FLOAT,
    DOUBLE,
    LONG,
    CHR,
    VAR,
    AUTO,
    OBJ
}

struct variable
{
    string name;
    TYPE_KIND kind;
    Variant value;
    long address;
    string block_name;
}

alias operand = variable;
// struct operand
// {
//     string name;
//     TYPE_KIND kind;
//     Variant value;
//     long address;
//     string block_name;
// }

struct operation
{
    operand[] operands;
    string op_name;
    string representation;
    OPERATION_KIND op_kind;
}

// class operation
// {
//     operand[] operands;
//     string op_name;
//     string representation;
//     OPERATION_KIND op_kind;
//     void run() {
//         ...
//     }
// }

struct code_obj {
    operation op;
    bool status;
}

struct LineOfCode
{
    int rowNo;
    string contents;
    int size;
}

struct statement
{
    code_obj[] cobj;
    LineOfCode line_info;
}

struct token_obj
{
    TOKEN_TYPE token_type;
    string contents;
    string block_name;
}

struct name_obj
{
    string name;
    string block_name;
    TYPE_KIND kind;
    long address;
}

name_obj[] name_list;
token_obj[] tokenz;
variable[] vars;

const char[] special_chars = [
    '>',
    '<',
    '|',
    ':',
    ';',
    '.',
    ',',
    '\'',
    '"',
    '!',
    '$',
    '%',
    '&',
    '?',
    '\\',
    '^',
    '~',
    '+',
    '-',
    '*',
    '/',
    '=',
    '(',
    ')',
    '[',
    ']',
    '{',
    '}',
    ' '
];

const string[] special_tokens = [
    "**",
    "->",
    "++",
    "--",
    "//",
    "/*",
    "*/",
    "==",
    "||",
    "|>",
    "|>>",
    "<|",
    "&&",
    "=>",
    "${",
    "$\"",
    "+=",
    "-=",
    "/=",
    "*=",
    "!=",
    "::",
    "~=",
    "..",
    ";;",
    "f\"",
    "-[",
    "-]"
];

const string[] comment_tokens = [
    "//",
    "/*",
    "*/",
];

const string[] declaration_tokens = [
    "const",
    "let",
    "var"
];

const string[] type_tokens = [
    "int",
    "str",
    "float",
    "double",
    "long",
    "chr",
    "auto",
    "void",
    "variant"
];

string read_file_old() {
    string file_path = "main.wisdom";
    auto f = File(file_path, "r");
    auto contents = f.readln();
    f.close;
    return contents;
}

string read_file() {
    string file_path = "main.wisdom";
    auto contents = readText(file_path);
    return contents;
}

string[] tokenize() {
    string content = read_file();
    ulong count = content.length;
    string token_name;
    string[] tokens;
    char c;
    string comment_str = "";
    string temp_str = "";
    string temp_token = "";
    bool string_literal_flag = false;
    bool comment_flag = false;
    bool multiline_comment_flag = false;
    string temp_str3 = "";
    for (size_t i = 0; i < count; ++i)
    {
        c = content[i];
        // printf("%d.th element => %c \n", i, c);
        if(multiline_comment_flag)
        {
            if(c == ' ')
            {
                comment_str ~= to!string(c);
            }
            if(c == '*' || c == '/') {
                temp_token ~= to!string(c);
                if(comment_tokens.canFind(temp_token) && temp_token.length > 1) {
                    if(multiline_comment_flag && temp_token == "*/")
                    {
                        multiline_comment_flag = false;
                    }
                }       
            } else {
                comment_str ~= to!string(c);
                temp_token = "";
            }
            continue;
        } else if(!multiline_comment_flag && comment_str != "" && temp_token == "*/")
        {
            // writeln("\t temp_token => '", temp_token, "'");
            // writeln("\t comment_str => '", comment_str, "'.");
            comment_str ~= temp_token;
            // tokens ~= comment_str;
            tokens[$ - 1] = comment_str;
            comment_str = "";
            temp_token = "";
            continue;
        }
        if(comment_flag)
        {
            if(c == '\n')
            {
                // tokens ~= comment_str;
                tokens[$ - 1] = comment_str;
                comment_str = "";
                comment_flag = false;
            } else {
                comment_str ~= to!string(c);
                continue;
            }
        }
        if(string_literal_flag && c != '"') {
            temp_str3 ~= to!string(c);
            continue;
        }
        if(c == '"')
        {
            if(string_literal_flag)
            {
                temp_str3 ~= to!string(c);
                string_literal_flag = false;
                if(tokens[$ - 1] == "$\"")
                {
                    tokens[$ - 1] ~= temp_str3;
                } else {
                    tokens ~= temp_str3;
                }
                temp_str3 = "";
            } else {
                string_literal_flag = true;
                temp_str3 = "";
                if(temp_token == "$" && c == '"')
                {
                    tokens[$ - 1] = "$\"";
                } else {
                    temp_str3 ~= to!string(c);
                }
            }
            continue;
        }
        if(special_chars.canFind(c))
        {
            if(c != ' ') {
                temp_token ~= to!string(c);
                // writeln(temp_token);
                if(special_tokens.canFind(temp_token) && temp_token.length > 1) {
                    tokens[$ - 1] = temp_token;
                    if(!comment_flag && temp_token == "/*")
                    {
                        multiline_comment_flag = true;
                        comment_str ~= temp_token;
                    } else if (!multiline_comment_flag && temp_token == "//"){
                        comment_str ~= temp_token;
                        comment_flag = true;
                    }
                    continue;
                }
            } else {
                temp_token = "";
            }
            string temp_str2 = temp_str.strip;
            if(temp_str2 != "" && temp_str2 != " ")
            {
                tokens = tokens ~ temp_str.strip;
                temp_str = "";
            }
            if(c != ' ')
            {
                string tc = to!string(c);
                tokens = tokens ~ tc;
            }
        } else {
            temp_str = temp_str ~ c;
            temp_token = "";
        }
    }
    return tokens;
}

token_obj[] create_tree() {
    writeln(" \\|+Tt_- Creating tree +Tt_|/- ");
    token_obj[] tos;
    string prev_token = "";
    string[] tokens = tokenize();
    bool name_flag = false;
    bool arr_name_flag = false;
    bool func_flag = false;
    string block_name = "global";
    string[] names = [];
    name_obj n;
    int curly_count = 0;
    int paren_count = 0;
    int square_bracket_count = 0;
    foreach (token; tokens) {
        write(" '");
        write(token);
        write("' |");

        token_obj t;
        if(token == "print")
        {
            t.token_type = TOKEN_TYPE.PRINT;
        } else if (token[0] == '"') {
            t.token_type = TOKEN_TYPE.STRING_LITERAL;
        } else if (token.length > 1 && token[0..2] == "$\"") {
            t.token_type = TOKEN_TYPE.FORMATTED_STRING_LITERAL;
        } else if (token == ";") {
            t.token_type = TOKEN_TYPE.SEMICOLON;
            name_flag = false;
        } else if (declaration_tokens.canFind(token)) {
            t.token_type = TOKEN_TYPE.DECLARATION;
        } else if (type_tokens.canFind(token)) {
            t.token_type = TOKEN_TYPE.KIND_DECLARATION;
        } else if (token == "~") {
            t.token_type = TOKEN_TYPE.DEREF;
        } else if (token == "&") {
            t.token_type = TOKEN_TYPE.ADDRESS_OF;
        } else if (token == "ptr") {
            t.token_type = TOKEN_TYPE.PTR_DECLARATION;
        } else if (token == "->") {
            t.token_type = TOKEN_TYPE.PTR_ASSIGNMENT;
            name_flag = false;
        } else if (token == "=") {
            t.token_type = TOKEN_TYPE.ASSIGNMENT;
            name_flag = false;
        } else if (token == "==") {
            t.token_type = TOKEN_TYPE.EQUAL;
        } else if (token == "!=") {
            t.token_type = TOKEN_TYPE.NOT_EQUAL;
        } else if (token == ">") {
            t.token_type = TOKEN_TYPE.GREATER_THAN;
        } else if (token == ">=") {
            t.token_type = TOKEN_TYPE.GREATER_THAN_OR_EQUAL;
        } else if (token == "<") {
            t.token_type = TOKEN_TYPE.LESS_THAN;
        } else if (token == "<=") {
            t.token_type = TOKEN_TYPE.LESS_THAN_OR_EQUAL;
        } else if (token == "^") {
            t.token_type = TOKEN_TYPE.POW;
        } else if (token == "$") {
            t.token_type = TOKEN_TYPE.DOLLAR;
        } else if (token.length > 1 && token[0..2] == "/*") {
            t.token_type = TOKEN_TYPE.COMMENT;
        } else if (token.length > 1 && token[0..2] == "//") {
            t.token_type = TOKEN_TYPE.COMMENT;
        } else if (token == "return") {
            t.token_type = TOKEN_TYPE.RETURN_STATEMENT;
        } else if (token == "(") {
            if(name_flag) {
                t.token_type = TOKEN_TYPE.FUNC_DEF;
                t.contents = prev_token;
                tos = tos ~ t;
                func_flag = true;
                name_flag = false;
                n.name = prev_token;
                n.block_name = block_name;
                n.kind = TYPE_KIND.OBJ;
                // n.address = n.name;
                name_list ~= n;
                block_name = prev_token;
            }
            t.token_type = TOKEN_TYPE.LEFT_PAREN;
            paren_count += 1;
        } else if (token == ")") {
            t.token_type = TOKEN_TYPE.RIGHT_PAREN;
            paren_count -= 1;
        } else if (token == "{") {
            t.token_type = TOKEN_TYPE.LEFT_CURLY;
            curly_count += 1;
        } else if (token == "}") {
            t.token_type = TOKEN_TYPE.RIGHT_CURLY;
            curly_count -= 1;
            if(func_flag && curly_count == 0) {
                func_flag = false;
                block_name = "global";
            }
        } else if (token == "[") {
            t.token_type = TOKEN_TYPE.LEFT_SQUARE_BRACKET;
            square_bracket_count += 1;
            if(name_flag) {
                arr_name_flag = true;
                name_flag = false;
            }
        } else if (token == "]") {
            t.token_type = TOKEN_TYPE.RIGHT_SQUARE_BRACKET;
            square_bracket_count -= 1;
        } else if (names.canFind(token)) {
            t.token_type = TOKEN_TYPE.FUNC_CALL;
        } else {
            if(arr_name_flag) {
                names ~= token;
                arr_name_flag = false;
                t.token_type = TOKEN_TYPE.NAME;
                n.name = token;
                n.block_name = block_name;
                if(prev_token == "str") {
                    n.kind = TYPE_KIND.STR;
                } else if(prev_token == "chr") {
                    n.kind = TYPE_KIND.CHR;
                } else if(prev_token == "int") {
                    n.kind = TYPE_KIND.INT;
                } else if(prev_token == "long") {
                    n.kind = TYPE_KIND.LONG;
                } else if(prev_token == "float") {
                    n.kind = TYPE_KIND.FLOAT;
                } else if(prev_token == "double") {
                    n.kind = TYPE_KIND.DOUBLE;
                } else if(prev_token == "auto") {
                    n.kind = TYPE_KIND.AUTO;
                } else {
                    n.kind = TYPE_KIND.VAR;
                }
                // n.address = n.name;
                name_list ~= n;
            } else if (type_tokens.canFind(prev_token) || prev_token == "ptr") {
                name_flag = true;
                if(!special_chars.canFind(token[0])) {
                    names ~= token;
                    t.token_type = TOKEN_TYPE.NAME;
                    n.name = token;
                    n.block_name = block_name;
                    if(prev_token == "str") {
                        n.kind = TYPE_KIND.STR;
                    } else if(prev_token == "chr") {
                        n.kind = TYPE_KIND.CHR;
                    } else if(prev_token == "int") {
                        n.kind = TYPE_KIND.INT;
                    } else if(prev_token == "long") {
                        n.kind = TYPE_KIND.LONG;
                    } else if(prev_token == "float") {
                        n.kind = TYPE_KIND.FLOAT;
                    } else if(prev_token == "double") {
                        n.kind = TYPE_KIND.DOUBLE;
                    } else if(prev_token == "auto") {
                        n.kind = TYPE_KIND.AUTO;
                    } else {
                        n.kind = TYPE_KIND.VAR;
                    }
                    // n.address = n.name;
                    name_list ~= n;
                }
            } else if (!special_chars.canFind(token[0])) {
                t.token_type = TOKEN_TYPE.VALUE;
            } else {
                continue;
            }
        }
        t.contents = token;
        t.block_name = block_name;
        tos = tos ~ t;
        prev_token = token;
    }
    if(curly_count > 0)
    {
        writeln("There are some unclosed curlies");
    }
    if(square_bracket_count > 0)
    {
        writeln("There are some unclosed square brackets");
    }
    if(paren_count > 0)
    {
        writeln("There are some unclosed paranthesis");
    }
    writeln(names);
    return tos;
}

void run_code() {
    token_obj[] tos;
    tos = create_tree();
    bool print_flag = false;
    bool func_flag = false;
    bool declaration_flag = false;
    bool assignment_flag = false;
    bool value_flag = false;
    TYPE_KIND temp_type;
    Variant temp_var;
    string temp_value;
    variable v;
    operand o;
    operation op;
    code_obj co;
    code_obj[] cl;
    writeln(" ******** Running Code ******** ");
    foreach(t; tos) {
        writeln("\t · ");
        writeln("\t +--- type: ", t.token_type);
        writeln("\t | contents: ", t.contents);
        writeln("\t | scope: ", t.block_name);
        writeln("\t +-----------------------");
        if(t.token_type == TOKEN_TYPE.PRINT) {
            print_flag = true;
            op.op_name = "print";
            op.op_kind = OPERATION_KIND.WRITE_STDOUT;
            op.representation = ">>>";
        } else if(t.token_type == TOKEN_TYPE.COMMENT) {
            // writeln(" Ur comments: ", t.contents);
        } else if(t.token_type == TOKEN_TYPE.FUNC_DEF) {
            func_flag = true;
        } else if(t.token_type == TOKEN_TYPE.KIND_DECLARATION) {
            if(t.contents == "str") {
                temp_type = TYPE_KIND.STR;
            } else if(t.contents == "chr") {
                temp_type = TYPE_KIND.CHR;
            } else if(t.contents == "int") {
                temp_type = TYPE_KIND.INT;
            } else if(t.contents == "long") {
                temp_type = TYPE_KIND.LONG;
            } else if(t.contents == "float") {
                temp_type = TYPE_KIND.FLOAT;
            } else if(t.contents == "double") {
                temp_type = TYPE_KIND.DOUBLE;
            } else if(t.contents == "auto") {
                temp_type = TYPE_KIND.AUTO;
            } else {
                temp_type = TYPE_KIND.VAR;
            }
            v.kind = temp_type;
            declaration_flag = true;
        } else if(t.token_type == TOKEN_TYPE.NAME) {
            v.name = t.contents;
            v.block_name = t.block_name;
        } else if(t.token_type == TOKEN_TYPE.ASSIGNMENT) {
            assignment_flag = true;
        } else if(t.token_type == TOKEN_TYPE.PTR_ASSIGNMENT) {
            assignment_flag = true;
        } else if(t.token_type == TOKEN_TYPE.VALUE) {
            value_flag = true;
            if(assignment_flag) {
                temp_value = t.contents;
                v.value = t.contents;
                // temp_var = to!int(temp_value);
                // v.address = ???;
            }
        // } else if(t.token_type == TOKEN_TYPE.SEMICOLON) {
        }
        if(assignment_flag && value_flag) {
            if (t.token_type == TOKEN_TYPE.SEMICOLON) {
                op.op_name = "declaration with assigment";
                op.op_kind = OPERATION_KIND.CREATE_GLOBAL_VAR;
                op.representation = "n/a";
                o.name = v.name;
                o.kind = v.kind;
                o.value = v.value;
                op.operands ~= o;
                co.op = op;
                co.status = true;
                cl ~= co;
                assignment_flag = false;
                value_flag = false;
                op = operation();
                o = operand();
                v = variable();
            }
        } else if(print_flag) {
            if(t.token_type == TOKEN_TYPE.STRING_LITERAL)
            {
                o.name = "string_literal";
                o.value = t.contents;
                op.operands ~= o;
                co.op = op;
            } else if(t.token_type == TOKEN_TYPE.FORMATTED_STRING_LITERAL) {
                o.name = "formatted string_literal";
                o.value = t.contents;
                // TODO: find curlies in the contents and replace it with the name
                op.operands ~= o;
                co.op = op;
            } else if (t.token_type == TOKEN_TYPE.SEMICOLON) {
                co.status = true;
                cl ~= co;
                print_flag = false;
                op = operation();
                o = operand();
                v = variable();
            }
        } else if (declaration_flag){
            // declaration_flag = false;
        } else if (func_flag){
            // func_flag = false;
        // } else {
        //     op = operation();
        //     o = operand();
        //     v = variable();
        }
    }
    foreach(c; cl)
    {
        run_op(c.op);
    }
    writeln("--------");
    writeln("Stack:");
    foreach(elem; vars)
    {
        writeln(elem);   
    }
}

void run_op(operation o) {
    if(o.op_kind == OPERATION_KIND.WRITE_STDOUT)
    {
        foreach(k; o.operands)
        {
            writeln("\n\t [PRINT]", k.value, "·");
        }
    } else if(o.op_kind == OPERATION_KIND.CREATE_GLOBAL_VAR)
    {
        foreach(k; o.operands)
        {
            writeln("\n\t [STACK_PUSH] Variable globally created! => ", k.name, "='", k.value, "'");
            stack_push(k);
        }
    }
}

void stack_push(variable v) {
    vars ~= v;
}

void main(string[] args)
{
    // writeln("hello wise person!");
    // writeln(tokens[1..$]);
    run_code();
    writeln("--------");
    writeln("Names:");
    writeln(name_list);
}
