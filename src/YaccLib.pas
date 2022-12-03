
unit 
	YaccLib;

(* Yacc Library Unit for TP Yacc Version 3.0, 6-17-91 AG *)

interface

uses
	SysUtils, LexLib;
	
const yymaxdepth = 1024;
	(* default stack size of parser *)

type YYSType = Integer;
	(* default value type, may be redefined in Yacc output file *)

var

yychar   : Integer; (* current lookahead character *)
yynerrs  : Integer; (* current number of syntax errors reported by the
											 parser *)
yydebug  : Boolean; (* set to true to enable debugging output of parser *)

procedure yyerror ( msg : ShortString );
  (* error message printing routine used by the parser *)

procedure yyclearin;
  (* delete the current lookahead token *)

procedure yyaccept;
  (* trigger accept action of the parser; yyparse accepts returning 0, as if
     it reached end of input *)

procedure yyabort;
  (* like yyaccept, but causes parser to return with value 1, as if an
     unrecoverable syntax error had been encountered *)

procedure yyerrlab;
  (* causes error recovery to be started, as if a syntax error had been
     encountered *)

procedure yyerrok;
  (* when in error mode, resets the parser to its normal mode of
     operation *)

(* Flags used internally by the parser routine: *)

var

yyflag    : ( yyfnone, yyfaccept, yyfabort, yyferror );
yyerrflag : Integer;

implementation

procedure yyerror ( msg : ShortString );
	var
		s, e: Integer;
		t: string;
	begin
		yyoutput.Add(msg + ': at character # ' + IntToStr(yycolno));
		//
		s := yycolno;
		while (s > 0) and (yyinput_text[s - 1] <> #10) do Dec(s);
		e := yycolno;
		while (e < Length(yyinput_text)) and (yyinput_text[e + 1] <> #13) do Inc(e);
		t := Copy(yyinput_text, s, e - s);
		yyoutput.Add(t);
		//
		FillChar(t[1], yycolno-s, #32);
		t[yycolno - s] := '^';
		SetLength(t, yycolno - s);
		yyoutput.Add(t);
	end(*yyerrmsg*);

procedure yyclearin;
  begin
    yychar := -1;
	end(*yyclearin*);

procedure yyaccept;
  begin
    yyflag := yyfaccept;
  end(*yyaccept*);

procedure yyabort;
  begin
    yyflag := yyfabort;
  end(*yyabort*);

procedure yyerrlab;
  begin
    yyflag := yyferror;
  end(*yyerrlab*);

procedure yyerrok;
  begin
    yyerrflag := 0;
  end(*yyerrork*);

end(*YaccLib*).
