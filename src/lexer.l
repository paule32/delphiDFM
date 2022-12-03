// ------------------------------------------------------------
// lexer.l - Delphi DFM reader
// (c) 2022 by Jens Kallup - paule32
// ------------------------------------------------------------
%{
unit lexer;

interface
uses
  LexLib;

function yylex: Integer;

implementation
uses
  parser;
%}

%%

\n		begin inc(yylineno); end;
.		begin yyerror('unexpected character'); end;
%%

end.
