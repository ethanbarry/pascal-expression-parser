(*
 * Program Author: Ethan Barry
 * Course: COSC 5340---Fall 2024
 * Due Date: Oct. 1, '24
 * Description: This program reads a series of mathematical expressions from stdin,
 *              and evaluates them, while writing the results to stdout.
 * Suggested Shell Usage: `./assignment < input.txt`
 *)

program Main;
const
	(* Set of valid characters in the mini-calculator-language this program parses. *)
	valChars = ['(', ')', '+', '*', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
var
	CurrentCharacter : char; (* The character currently being examined. *)
	ExprValue	 : integer;  (* The current value of the expression. *)

	(*
	 * This procedure reads a new character from stdin, while skipping over eoln characters, such as ^M and ^C.
	 * Modifies: Token, a reference to CurrentCharacter.
	 * Side Effects: Echoes the valid inputs to stdout.
	 *)
	procedure GetCharacter(var Token: char);
	begin
		if eoln then
		begin
			(* Read the eoln char from the file, & assign '@' to currentCharacter. *)
			read(Token);
			Token := '@';
		end
		else
		begin
			repeat
			begin
				(* read token from input, and write to output. *)
				read(Token);
				write(Token);
			end until (Token in valChars) or (eoln);
			if not (Token in valChars) then
			begin
				Token := '@';
			end;
		end
	end;

	(*
	 * This procedure evaluates an expression.
	 * Modifies: References to CurrentCharacter and ExprValue.
	 * Side Effects: None.
	 *)
	procedure Expression(var CurrentCharacter: char; var ExprValue: integer);
	var TermValue : integer; (* Local variable maintaining the current term's value. *)
		procedure Factor(var CurrentCharacter: char; var FactorValue: integer);
		var Value: integer;
		begin
			if CurrentCharacter in ['0'..'9'] then
			begin
				FactorValue := ord(CurrentCharacter) - ord('0');
				GetCharacter(CurrentCharacter)
			end
			else if CurrentCharacter = '(' then
			begin
				GetCharacter(CurrentCharacter);
				Expression(CurrentCharacter, Value);
				FactorValue := Value;
				if CurrentCharacter = ')' then
					GetCharacter(CurrentCharacter);
			end
		end;

		(*
		 * This procedure evaluates a term.
		 * Modifies: References to CurrentCharacter and TermValue.
		 * Side Effects: None.
		 *)
		procedure Term(var CurrentCharacter : char; var TermValue: integer);
		var FactorValue : integer; (* Local variable maintaining the current factor's value. *)
		begin
			Factor(CurrentCharacter, FactorValue);
			TermValue := FactorValue;
			while CurrentCharacter = '*' do
			begin
				GetCharacter(CurrentCharacter);
				Factor(CurrentCharacter, FactorValue);
				TermValue := FactorValue * TermValue
			end
		end;

	begin
		Term(CurrentCharacter, TermValue); (* Every expression must have at least one term... *)
		ExprValue := TermValue;
		while CurrentCharacter = '+' do    (* ...but more are permitted. *)
		begin
			GetCharacter(CurrentCharacter);
			Term(CurrentCharacter, TermValue);
			ExprValue := ExprValue + TermValue
		end
	end; (* End procedure Expression. *)
begin
	(* While we have input... *)
	while not eof do
	begin
		write('THE VALUE OF ');
		GetCharacter(CurrentCharacter); (* ...echo the input... *)
		Expression(CurrentCharacter, ExprValue); (* ...while parsing & evaluating it... *)
		writeln(' IS ', ExprValue) (* ...and print the result. *)
	end
end.
