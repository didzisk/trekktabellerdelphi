unit Trekktabeller.Trekktabeller2021.Tabellnummer;

interface

uses Trekktabeller.Konstanter, Trekktabeller.Tabelltype, Trekktabeller.Tabellnummer,
  Trekktabeller.Trekktabeller2020.Tabellnummer;

function InitializeTabellnummerData2021(TabellNr:integer; Pensjonist:boolean; Konstanter:TKonstanter ):TTabellnummer;

implementation

function InitializeTabellnummerData2021(TabellNr:integer; Pensjonist:boolean; Konstanter:TKonstanter ):TTabellnummer;
begin
  result:=InitializeTabellnummerData2020(TabellNr, Pensjonist, Konstanter);
end;

end.

