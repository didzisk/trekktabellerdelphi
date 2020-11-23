unit uSkattFactory;

interface

uses Skatt, Trekktabeller.Periode;

function BeregnForskuddstrekk(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:boolean; Tabtrekkperiode, AntUker : integer; Year:integer):integer;
function BeregnNettoskatt(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:boolean; Tabtrekkperiode, AntUker : integer; Year:integer):integer;
function IsTolvMndSkatt(const Tabellnummer:integer; Year:integer):boolean;

implementation

uses Trekktabeller.Konstanter,
  Trekktabeller.Trekktabeller2020.Konstanter, Trekktabeller.Trekktabeller2019.Konstanter,
  Trekktabeller.Trekktabeller2020.Skattetabell2020, Trekktabeller.Trekktabeller2019.Skattetabell2019,
  Trekktabeller.Tabellnummer, Trekktabeller.Trekktabeller2019.Tabellnummer;

function BeregnForskuddstrekk(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:boolean; Tabtrekkperiode, AntUker : integer; Year:integer):integer;
var
  AdjustedTrekkGrl, AdjustedTrekkPer, Factor:integer;
begin
  Factor:=1;
  AdjustedTrekkPer:=Tabtrekkperiode;
  if Tabtrekkperiode = integer(PERIODE_1_UKE) then
  begin
    if AntUker = 4 then
    begin
      AdjustedTrekkPer:=integer(PERIODE_14_DAGER);
      Factor:=2;
    end
    else
      Factor:=AntUker;
  end;
  AdjustedTrekkGrl:=Trekkgrunnlag div Factor;
  if Year = 2020 then
    result:=Factor * Trekktabeller.Trekktabeller2020.Skattetabell2020
      .BeregnForskuddstrekk(AdjustedTrekkGrl, Tabellnummer, Pensjonist, AdjustedTrekkPer)
  else
    result:=Factor * Trekktabeller.Trekktabeller2019.Skattetabell2019
      .BeregnForskuddstrekk(AdjustedTrekkGrl, Tabellnummer, Pensjonist, AdjustedTrekkPer);
end;

function BeregnNettoskatt(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:boolean; Tabtrekkperiode, AntUker : integer; Year:integer):integer;
var
  AdjustedTrekkGrl, AdjustedTrekkPer, Factor:integer;
begin
  Factor:=1;
  AdjustedTrekkPer:=Tabtrekkperiode;
  if Tabtrekkperiode = integer(PERIODE_1_UKE) then
  begin
    if AntUker = 4 then
    begin
      AdjustedTrekkPer:=integer(PERIODE_14_DAGER);
      Factor:=2;
    end
    else
      Factor:=AntUker;
  end;
  AdjustedTrekkGrl:=Trekkgrunnlag div Factor;

  if Year = 2020 then
    Result := Factor * Trekktabeller.Trekktabeller2020.Skattetabell2020.
      BeregnNettoskatt(AdjustedTrekkGrl, Tabellnummer, Pensjonist,
      AdjustedTrekkPer)
  else
    Result := Factor * Trekktabeller.Trekktabeller2019.Skattetabell2019.
      BeregnNettoskatt(AdjustedTrekkGrl, Tabellnummer, Pensjonist,
      AdjustedTrekkPer);
end;

function IsTolvMndSkatt(const Tabellnummer: integer; Year: integer): boolean;
begin
  if Year = 2020 then
    Result := InitializeTabellnummerData2020(Tabellnummer, False, InitializeKonstanter2020).trekk_i_12_mnd
  else
    Result := InitializeTabellnummerData2019(Tabellnummer, False, InitializeKonstanter2019).trekk_i_12_mnd;
end;

end.
