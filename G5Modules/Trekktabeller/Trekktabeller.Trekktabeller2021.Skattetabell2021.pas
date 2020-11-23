unit Trekktabeller.Trekktabeller2021.Skattetabell2021;

interface

uses Trekktabeller.Tabellnummer, Trekktabeller.Trekktabeller2021.Konstanter,
  Trekktabeller.Periode, Trekktabeller.Trekktabeller2018.Periode,
  Trekktabeller.Skatteberegning, Trekktabeller.Trekkrutine,
  Trekktabeller.Fradrag, Trekktabeller.Konstanter, Trekktabeller.Nettolonn;

function BeregnForskuddstrekk(const Trekkgrunnlag, TabellNr:integer; Pensjonist:boolean; Tabtrekkperiode : integer):integer;
function BeregnNettoskatt(const Trekkgrunnlag, TabellNr:integer; Pensjonist:boolean; Tabtrekkperiode : integer):integer;

implementation

function BeregnForskuddstrekk(const Trekkgrunnlag, TabellNr:integer; Pensjonist:boolean; Tabtrekkperiode : integer):integer;
var
  Konst:TKonstanter;
  Tab:TTabellnummer;
  Perx:PeriodeData;
  Skatt:TSkatteberegning;
  Frad:TFradrag;
begin
  Konst:=InitializeKonstanter2021;
  Skatt:=TSkatteberegning.Create(Konst);
  Frad:=TFradrag.Create(Konst);
  try
    Tab:=InitializeTabellnummerData2021(TabellNr, Pensjonist, Konst);
    Perx:=initializePeriodeData(Periode(Tabtrekkperiode), Tab);
    result:=beregnTabelltrekk(Tab, Perx, Trekkgrunnlag, Skatt, Frad);
  finally
    Frad.Free;
    Skatt.Free;
  end;

end;

function BeregnNettoskatt(const Trekkgrunnlag, TabellNr:integer; Pensjonist:boolean; Tabtrekkperiode : integer):integer;
var
  Konst:TKonstanter;
  Tab:TTabellnummer;
  Perx:PeriodeData;
  Skatt:TSkatteberegning;
  Frad:TFradrag;
begin
  Konst:=InitializeKonstanter2021;
  Skatt:=TSkatteberegning.Create(Konst);
  Frad:=TFradrag.Create(Konst);
  try
    Tab:=InitializeTabellnummerData2021(TabellNr, Pensjonist, Konst);
    Perx:=initializePeriodeData(Periode(Tabtrekkperiode), Tab);
    result:=beregnNettoTabelltrekk(Tab, Perx, Trekkgrunnlag, Skatt, Frad);
  finally
    Frad.Free;
    Skatt.Free;
  end;

end;

end.
