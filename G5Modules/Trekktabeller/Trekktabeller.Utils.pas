unit Trekktabeller.Utils;

interface

uses DecimalRounding_JH1;

function RoundAwayFromZero(x:Double):integer;

implementation

function RoundAwayFromZero(x:Double):integer;
begin
  result:=Trunc(DecimalRoundExt(x, 0, drHalfUp));
end;

end.
