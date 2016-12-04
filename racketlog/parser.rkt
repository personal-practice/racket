#lang brag
racketlog-program : clause* [query]

clause            : fact | rule
fact              : predicate "."
rule              : predicate ":" "-" predicate-list "."
predicate-list    : predicate ("," predicate)*
query             : "?" predicate-list "."

predicate         : atom | functor
term-list         : term ("," term)*
term              : number | atom | variable | functor

functor           : atom "(" term-list ")"
atom              : ATOM-TOK
variable          : VAR-TOK
number            : NUM-TOK