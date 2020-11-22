unit SkattetabellTests2017;

interface

uses DUnitX.TestFramework, Classes, System.SysUtils, SkattetabellTests;

  type
  [TestFixture]
  TSkattetabellTests2017 = class(TSkattetabellTests)
  public
    [Test]
    [TestCase('', 'C:\dk-hl-vso\Main\Source\SkattetabellerFsharp\HL.Payroll.Tests\Skattetabell\trekk2017.txt, 2017')]
    procedure TestWholeTable(const InputFile:String; Year:integer); override;
  end;

implementation

{ TSkattetabellTests2018 }

procedure TSkattetabellTests2017.TestWholeTable(const InputFile: String;
  Year: integer);
begin
  inherited;

end;

initialization
  TDUnitX.RegisterTestFixture(TSkattetabellTests2017);

end.
