unit Trekktabeller.Tabellnummer;

interface

uses Trekktabeller.Konstanter, Trekktabeller.Tabelltype;

type TTabellnummer=record
  tabelltype:Tabelltype;
  tabellFradrag:integer;
  klasseFradrag:integer;
  trekk_i_12_mnd:boolean;
  overskytendeProsent:integer;
  isStandardFradrag:boolean;
  ikkeTrygdeavgift:boolean;
  lavSatsTrygdeavgift:boolean;
end;

function ctr(tabelltype:Tabelltype; tabellFradrag:integer;
  klasseFradrag:integer; const trygdeavgiftstype:string; trekk_i_12_mnd:boolean;
  overskytendeProsent:integer):TTabellnummer;

implementation
//ctr means ConstructTabellnummerRecord
function ctr(tabelltype:Tabelltype; tabellFradrag:integer;
  klasseFradrag:integer; const trygdeavgiftstype:string; trekk_i_12_mnd:boolean;
  overskytendeProsent:integer):TTabellnummer;
begin
  result.tabelltype:=tabelltype;
  result.tabellFradrag:=tabellFradrag;
  result.klasseFradrag:=klasseFradrag;
  result.trekk_i_12_mnd:=trekk_i_12_mnd;
  result.overskytendeProsent:=overskytendeProsent;
  result.isStandardFradrag:=tabelltype in [STANDARDFRADRAG, SJO, FINNMARK];
  result.ikkeTrygdeavgift:=trygdeavgiftstype='Ingen';
  result.lavSatsTrygdeavgift:=trygdeavgiftstype='Lav';
end;


end.

