unit SkattetabellTests2018;

interface

uses DUnitX.TestFramework, Classes, System.SysUtils,
  Trekktabeller.Konstanter, Trekktabeller.Trekktabeller2018.Konstanter,
  Trekktabeller.Skatteberegning, Trekktabeller.Trekktabeller2018.Periode,
  Trekktabeller.Fradrag, Trekktabeller.Tabellnummer, Trekktabeller.Periode,
  Trekktabeller.Trekkrutine, Trekktabeller.Utils, uSkattFactory,
  Trekktabeller.Nettolonn, SkattetabellTests;

  type
  [TestFixture]
  TSkattetabellTests2018 = class(TSkattetabellTests)
  private
    FKonst:TKonstanter;
    FSkatt:TSkatteberegning;
    FFrad:TFradrag;
  protected
    function AcceptNettoTables(TabNr:integer):boolean;
    function CalcSkatt(
      const Trekkgrunnlag,
      Tabellnummer:integer;
      Pensjonist:boolean;
      Tabtrekkperiode : integer;
      Year:integer;
      ExtraInput:integer;
      SkattInput:integer):integer;
    function CalcNettoSkatt(
      const Trekkgrunnlag,
      Tabellnummer:integer;
      Pensjonist:boolean;
      Tabtrekkperiode : integer;
      Year:integer;
      ExtraInput:integer;
      SkattInput:integer):integer;
    function CalcExpectedSimple(
      const Trekkgrunnlag,
      Tabellnummer:integer;
      Pensjonist:boolean;
      Tabtrekkperiode : integer;
      Year:integer;
      ExtraInput:integer;
      SkattInput:integer):integer;
    function CalcExpectedNetto(
      const Trekkgrunnlag,
      Tabellnummer:integer;
      Pensjonist:boolean;
      Tabtrekkperiode : integer;
      Year:integer;
      ExtraInput:integer;
      SkattInput:integer):integer;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestRounding;

    [Test]
    [TestCase('','31200, 7101, 0, 1, 8620')]
    [TestCase('','68700, 7101, 0, 1, 25592')]
    [TestCase('','41667, 7100, 0, 1, 12850')]
    procedure Calc2018Trekk(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:integer; const Tabtrekkperiode, Expected:integer);

    [Test]
    [TestCase('','9400, 7150, 0, 1, 0')]
    procedure Test2018Netto(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:integer; const Tabtrekkperiode, Dummy:integer);

    [Test]
    [TestCase('','833250, 7101, 68326')]
    procedure Calc2018Trygdeavgift(const personInntektAar, Tabellnummer, Expected:integer);

    [Test]
    [TestCase('', '..\..\..\SkattetabellerFsharp\HL.Payroll.Tests\Skattetabell\trekk2018.txt, 2018')]
    procedure TestWholeTable(const InputFile:String; Year:integer); override;

    [Test]
    [TestCase('', '..\..\..\SkattetabellerFsharp\HL.Payroll.Tests\Skattetabell\trekk2018.txt, 2018')]
    procedure TestNettoTable(const InputFile:String; Year:integer);

    [Test]
    procedure Calc2018Nettoskatt;
  end;

implementation

{ TSkattetabellTests2018 }

function TSkattetabellTests2018.AcceptNettoTables(TabNr: integer): boolean;
begin
  case TabNr of 7150, 7250, 7160, 7260, 7170, 7270:
    result:=true;
  else
    result:=false;
  end;

end;

procedure TSkattetabellTests2018.Calc2018Nettoskatt;
var
  Tab:TTabellnummer;
  Perx:PeriodeData;
  Trekk, Nettotrekk:integer;
begin
    Tab:=InitializeTabellnummerData(7300, false, FKonst);
    Perx:=initializePeriodeData(Periode.PERIODE_1_MAANED, Tab);
    Nettotrekk:=beregnNettoTabelltrekk(Tab, Perx, 20000, FSkatt, FFrad);
    Trekk:=beregnTabelltrekk(Tab, Perx, 20000+Nettotrekk, FSkatt, FFrad);
    Assert.AreEqual(Nettotrekk, Trekk);

end;

procedure TSkattetabellTests2018.Test2018Netto(const Trekkgrunnlag,
  Tabellnummer: integer; Pensjonist: integer; const Tabtrekkperiode, Dummy:integer);
var
  Tab:TTabellnummer;
  Perx:PeriodeData;
  Trekk, Nettotrekk:integer;
begin
  Tab:=InitializeTabellnummerData(Tabellnummer, Pensjonist = 1, FKonst);
  Perx:=initializePeriodeData(Periode(Tabtrekkperiode), Tab);
  Nettotrekk:=beregnNettoTabelltrekk(Tab, Perx, Trekkgrunnlag, FSkatt, FFrad);
  Trekk:=beregnTabelltrekk(Tab, Perx, Trekkgrunnlag+Nettotrekk, FSkatt, FFrad);
  Assert.AreEqual(Trekk, Nettotrekk);
end;

procedure TSkattetabellTests2018.Calc2018Trekk(const Trekkgrunnlag,
  Tabellnummer: integer; Pensjonist: integer; const Tabtrekkperiode,
  Expected: integer);
var
  Tab:TTabellnummer;
  Perx:PeriodeData;
  Trekk:integer;
begin
    Tab:=InitializeTabellnummerData(Tabellnummer, (Pensjonist=1), FKonst);
    Perx:=initializePeriodeData(Periode(Tabtrekkperiode), Tab);
    Trekk:=beregnTabelltrekk(Tab, Perx, Trekkgrunnlag, FSkatt, FFrad);
    Assert.AreEqual(Expected, Trekk);
end;

procedure TSkattetabellTests2018.Calc2018Trygdeavgift(const personInntektAar,
  Tabellnummer, Expected: integer);
var
  Tab:TTabellnummer;
  Tryg:integer;
  PersInnt:Double;
begin
  Tab:=InitializeTabellnummerData(Tabellnummer, false, FKonst);
  PersInnt:=68750.0 * 12.12;
  Tryg:=FSkatt.beregnTrygdeavgift(Tab, PersInnt);
  Assert.AreEqual(Expected, Tryg);
end;

function TSkattetabellTests2018.CalcExpectedNetto(const Trekkgrunnlag,
  Tabellnummer: integer; Pensjonist: boolean; Tabtrekkperiode, Year, ExtraInput,
  SkattInput: integer): integer;
begin
  result:=BeregnForskuddstrekk(Trekkgrunnlag + SkattInput, Tabellnummer, Pensjonist, Tabtrekkperiode, 1, Year);
end;

function TSkattetabellTests2018.CalcExpectedSimple(const Trekkgrunnlag,
  Tabellnummer: integer; Pensjonist: boolean; Tabtrekkperiode, Year,
  ExtraInput: integer;
      SkattInput:integer): integer;
begin
  result:=ExtraInput;
end;

function TSkattetabellTests2018.CalcNettoSkatt(const Trekkgrunnlag,
  Tabellnummer: integer; Pensjonist: boolean; Tabtrekkperiode, Year, ExtraInput,
  SkattInput: integer): integer;
begin
  result:=BeregnNettoskatt(Trekkgrunnlag, Tabellnummer, Pensjonist, Tabtrekkperiode, 1, Year);
end;

function TSkattetabellTests2018.CalcSkatt(const Trekkgrunnlag,
  Tabellnummer: integer; Pensjonist: boolean; Tabtrekkperiode, Year,
  ExtraInput, SkattInput: integer): integer;
begin
  result:=BeregnForskuddstrekk(Trekkgrunnlag, Tabellnummer, Pensjonist, Tabtrekkperiode, 1, Year);
end;

procedure TSkattetabellTests2018.Setup;
begin
  FKonst:=InitializeKonstanter2018;
  FSkatt:=TSkatteberegning.Create(FKonst);
  FFrad:=TFradrag.Create(FKonst);
end;

procedure TSkattetabellTests2018.TearDown;
begin
  FFrad.Free;
  FSkatt.Free;
end;

procedure TSkattetabellTests2018.TestNettoTable(const InputFile: String;
  Year: integer);
begin
  TestWholeFile(InputFile, Year, AcceptNettoTables, CalcNettoSkatt, CalcExpectedNetto);
end;

procedure TSkattetabellTests2018.TestRounding;
var
  Avr:Integer;
begin
  Avr:=RoundAwayFromZero(58875.556500000001);
  Assert.AreEqual(58876, Avr);
end;

procedure TSkattetabellTests2018.TestWholeTable(const InputFile: String;
  Year: integer);
begin
  TestWholeFile(InputFile, 2018, AcceptAll, CalcSkatt, CalcExpectedSimple);
end;

initialization
  TDUnitX.RegisterTestFixture(TSkattetabellTests2018);

end.