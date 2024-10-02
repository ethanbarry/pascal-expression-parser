# Pascal Expression Parser

This program parses math expressions from `stdin`. Specifically, it parses all expressions with the operators '\*', '+', and '(' or ')', and all single-digit numbers. This is defined with the formal grammar:

```ebnf
FILE ::= { LINE } <eof>
LINE ::= EXPRESSION <eoln>
EXPRESSION ::= TERM { ‘+’ TERM }
TERM ::= FACTOR { ‘*’ FACTOR }
FACTOR ::= digit | ( ‘(’ EXPRESSION ‘)’ )
```

------

Completed for Dr. Rainwater's course COSC 5340—Comparative Study of Programming Languages, in the Fall 2024 Semester at UT Tyler.
