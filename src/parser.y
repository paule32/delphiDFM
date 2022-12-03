%{
{$undef  yydebug}  // no debug session
{$define paule32}  // YYSTYPE hack
// ------------------------------------------------------------
// parser.y - Delphi DFM reader
// (c) 2022 by Jens Kallup - paule32
// ------------------------------------------------------------
unit parser;

interface
uses
  Dialogs, SysUtils, lexer, LexLib, YaccLib;

procedure yyerror(s: String);
function  myparser(fileName: String) : Integer;

var
  yyinput : TextFile;
  yyoutput: TextFile;

implementation

// ------------------------------------------------------------
// get feedback for the user ...
// ------------------------------------------------------------
procedure yyerror(s: String);
begin
  ShowMessage(Format('Error: %s', [s]));
end;

%}

%start program
%token <String> ID

%{
{ i have modified the original yyparse.cod - see line: 8. }
{ dont forget to modified this file, if you have not done }
{$IFDEF PAULE32}
type
  YYSTYPE = record
    yyString: String;
  end;
{$ELSE}
{ the YYSTYPE below is the orginal source output.      }
{ i don't test it with FPC or other Pascal Compiler's. }
%}

%%

program
	: /* empty */
	| program object
	;
	
object
	: ID { ShowMessage($1); }
	;

%%

// ------------------------------------------------------------
// object parser entry point ...
// ------------------------------------------------------------
function  myparser(fileName: String) : Integer;
var
  srcFile: TextFile;
begin
  result := 0;
  try
    try
      Close(srcFile);
	  
	  if not FileExists(fileName) then
	  begin
	    yyerror('can not open: ' + fileName);
		result := -1;
		exit;
	  end;
	  
      Assign(yyinput,fileName);
      Reset (yyinput);

      yyparse;
	  
	except
	  on E: Exception do
	  begin
	    yyerror(E.Message);
		result := -1;
		exit;
	  end;
	end;
	
  finally
    Close(srcFile);
  end;
  result := 0;
end;

end.
