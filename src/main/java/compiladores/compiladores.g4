grammar compiladores;

@header {
package compiladores;
}

/* 
declaracion -> int x;
               double y;
               int z = 0;
               double w, q, t;
               int a = 5, b, c = 10;

asignacion -> x = 1;
              z = y;

iwhile -> while (x comp y) { instrucciones } 
*/


fragment DIGIT : '0'..'9';
fragment LETTER : 'a'..'z' | 'A'..'Z';
fragment DOUBLE : 'double';
fragment INT : 'int';


/*
CA : '[';
CC : ']';
*/

PA : '(';
PC : ')';
LA : '{';
LC : '}';
END : ';';
COMA : ',';
ASSIGN : '=';
WS : [ \t\n\r]+ -> skip;

VARTYPE: INT | DOUBLE;
VARNAME : ('_' | LETTER) (LETTER | DIGIT | '_')* ;
NUMBER : DIGIT+;
COMP : '==' | '!=' | '<' | '>' | '>=' | '<=';


programa : instrucciones EOF;

instrucciones : instruccion instrucciones | ;

instruccion : inst_simple
            | bloque
            | iwhile
            ;

inst_simple : asignacion END
             | declaracion END
             ;

bloque : LA instrucciones LC;

declaracion : VARTYPE variables;
variables : VARNAME COMA variables | VARNAME | asignacion COMA variables | asignacion;

asignacion : VARNAME '=' (NUMBER | VARNAME);

iwhile : 'while' PA condicion PC;
condicion : VARNAME COMP (NUMBER | VARNAME);

