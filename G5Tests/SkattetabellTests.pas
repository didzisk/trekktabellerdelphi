unit SkattetabellTests;

interface
uses
  DUnitX.TestFramework, System.SysUtils, uSkattFactory, classes;

type
  SampleRec = record
    TabNr, TrekkPer, Grl, ExpectedTrekk:integer; Pensj:boolean;
  end;

type
  TFilterTableFunction = function(TabNr:integer):boolean of object;
type
  TCalcTrekkFunction = function(
    const Trekkgrunnlag,
    Tabellnummer:integer;
    Pensjonist:boolean;
    Tabtrekkperiode : integer;
    Year:integer;
    ExpectedInput:integer;
    SkattInput:integer):integer of object;
type
  TSkattetabellTests = class(TObject)
  protected
    function ReadOneSampleLine(const s:string):SampleRec;
    function ReadOneSampleLine2019(const s:string):SampleRec;
    function AcceptAll(TabNr:integer):boolean;

  public

//    [Test]
//    [TestCase('','100000, 7100, false, 1, 2017, 42470')]
    procedure TestTabelltrekkCherryPickedValues(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:boolean; const Tabtrekkperiode, Year, Expected:integer);

    procedure TestWholeTable(const InputFile:String; Year:integer); virtual;
    procedure TestWholeFile(const InputFile:String; Year:integer;
      FilterFunction:TFilterTableFunction;
      CalcTrekkFunction:TCalcTrekkFunction;
      CalcExpectedFunction:TCalcTrekkFunction); virtual;
  end;

implementation

function CharArrayToInt(x:array of byte):integer;
var
  i, j:integer;
begin
  j:=1;
  result:=0;
  for i := Length(x)-1 downto 0 do
  begin
    result:=result+(x[i]-byte('0'))*j;
    j:=j*10;
  end;
end;

function TSkattetabellTests.AcceptAll(TabNr: integer): boolean;
begin
  result:=true;
end;

function TSkattetabellTests.ReadOneSampleLine(const s: string): SampleRec;
begin
  result.TabNr:= StrToInt(
     S[2]
    +S[3]
    +S[4]
    +S[5]);
  result.Trekkper:=byte(S[6])-byte('0');
  result.Pensj:=byte(S[7])-byte('0')=1;
  result.Grl:=0
    +(byte(S[8])-byte('0'))*100000
    +(byte(S[9])-byte('0'))*10000
    +(byte(S[10])-byte('0'))*1000
    +(byte(S[11])-byte('0'))*100
    +(byte(S[12])-byte('0'))*10
    +(byte(S[13])-byte('0'));
  result.ExpectedTrekk:=0
    +(byte(S[14])-byte('0'))*100000
    +(byte(S[15])-byte('0'))*10000
    +(byte(S[16])-byte('0'))*1000
    +(byte(S[17])-byte('0'))*100
    +(byte(S[18])-byte('0'))*10
    +(byte(S[19])-byte('0'));

{
    Trekktabellene har 6 kolonner. De inneholder:
   (Kolonne 0 - Dummy, alltid '1')
    Kolonne 1 (A)	Tabellnummer	4 posisjoner
    Kolonne 2 (B)
        Trekkperiode:
        1: måned
        2: 14 dager
        3: uke
        4: 4 dager
        5: 3 dager
        6: 2 dager
        7: 1 dag

        1 posisjon
    Kolonne 3 (C)	Tabelltype
        0: Lønn
        1: Pensjon	1 posisjon
    Kolonne 4 (D)	Trekkgrunnlag	6 posisjoner
    Kolonne 5 (E)	Trekk	6 posisjoner
    }

end;

function TSkattetabellTests.ReadOneSampleLine2019(const s: string): SampleRec;
begin
  result.TabNr:= StrToInt(
     S[1]
    +S[2]
    +S[3]
    +S[4]);
  result.Trekkper:=byte(S[5])-byte('0');
  result.Pensj:= byte(S[6])-byte('0')=1;
  result.Grl:=0
    +(byte(S[7])-byte('0'))*10000
    +(byte(S[8])-byte('0'))*1000
    +(byte(S[9])-byte('0'))*100
    +(byte(S[10])-byte('0'))*10
    +(byte(S[11])-byte('0'));
  result.ExpectedTrekk:=0
    +(byte(S[12])-byte('0'))*10000
    +(byte(S[13])-byte('0'))*1000
    +(byte(S[14])-byte('0'))*100
    +(byte(S[15])-byte('0'))*10
    +(byte(S[16])-byte('0'));

{
    Trekktabellene har 5 kolonner. De inneholder:
    Not 100% sure about this.
   (Kolonne 1 (A)	Tabellnummer	4 posisjoner
    Kolonne 2 (B)
        Trekkperiode:
        1: måned
        2: 14 dager
        3: uke
        4: 4 dager
        5: 3 dager
        6: 2 dager
        7: 1 dag

        1 posisjon
    Kolonne 3 (C)	Tabelltype
        0: Lønn
        1: Pensjon	1 posisjon
    Kolonne 4 (D)	Trekkgrunnlag	5 posisjoner
    Kolonne 5 (E)	Trekk	5 posisjoner
    }

end;

procedure TSkattetabellTests.TestTabelltrekkCherryPickedValues(
  const Trekkgrunnlag, Tabellnummer: integer; Pensjonist: boolean;
  const Tabtrekkperiode, Year, Expected:integer);
var
  Trekk:Integer;
begin
  //1710010010000001443 = 7100, 1 (mnd), 0 (Vanlig), 10000 gives 1443 tax
  //BeregnForskuddstrekk(const Trekkgrunnlag, Tabellnummer:integer; Pensjonist:boolean; Tabtrekkperiode : integer; Year:integer)
  Trekk := BeregnForskuddstrekk(31200, 7101, false, 1, 2018, 1);
  Assert.AreEqual(8620, Trekk);
  Trekk:=BeregnForskuddstrekk(10000, 7100, false, 1, 2017, 1);
  Assert.AreEqual(1443, Trekk);
  Trekk := BeregnForskuddstrekk(31300, 7100, false, 2, 2018, 1);
  Assert.AreEqual(11522, trekk);
end;

procedure TSkattetabellTests.TestWholeTable(const InputFile:String; Year:integer);
begin
//  TestWholeFile(InputFile, Year, AcceptAll);
end;

procedure TSkattetabellTests.TestWholeFile(const InputFile: String;
  Year: integer; FilterFunction: TFilterTableFunction;
      CalcTrekkFunction:TCalcTrekkFunction;
      CalcExpectedFunction:TCalcTrekkFunction);
var
  Trekk:integer;
  S, E:TStringList;
  R:SampleRec;
  i:integer;
  Expected:Integer;
  DiffsEncountered, SignificantDiffsEncountered, MaxDiff:integer;
  IsSignificantDiff:boolean;
begin
  DiffsEncountered:=0;
  SignificantDiffsEncountered:=0;
  MaxDiff:=-1;
  S:=TStringList.Create;
  E:=TStringList.Create;
  try
    S.LoadFromFile(InputFile);
    for i:=1 to S.Count-1 do
    begin
      if Year >= 2019 then
        R:=ReadOneSampleLine2019(S[i])
      else
        R:=ReadOneSampleLine(S[i]);
      if not FilterFunction(R.TabNr) then
        continue;
      Trekk:=CalcTrekkFunction(R.Grl, R.Tabnr, R.Pensj, R.TrekkPer, Year, 0, 0);
      Expected:=CalcExpectedFunction(R.Grl, R.Tabnr, R.Pensj, R.TrekkPer, Year, R.ExpectedTrekk, trekk);
      if Expected<>Trekk then
      begin
        inc(DiffsEncountered);
        if Abs(Expected-Trekk) > MaxDiff then
          MaxDiff:=Abs(Expected-Trekk);
      end;
      if Abs(Expected-Trekk) > 1 then // Comment to get all lines
        E.Add(Format('(%d, %d, %s, %d, %d Expected:%d Actual:%d)', [R.Grl, R.Tabnr, BoolToStr(R.Pensj, false), R.TrekkPer, Year, Expected, Trekk]));
      IsSignificantDiff:=( Abs(Expected-Trekk) > 1) or (Abs(Expected-Trekk)/R.Grl>0.001);
      if IsSignificantDiff then
      begin
        E.Add('^ Look above, this is not good! *************');
        inc(SignificantDiffsEncountered);
      end;
    end;
    Assert.IsTrue(DiffsEncountered=0,
      Format('%d lines, %d diffs, of those %d significant, max %d kroner',
        [S.Count, DiffsEncountered, SignificantDiffsEncountered, MaxDiff]));
  finally
    S.Free;
    E.Free;
  end;

end;

end.
