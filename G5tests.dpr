program G5tests;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  SkattetabellTests in 'G5Tests\SkattetabellTests.pas',
  SkattetabellTests2020 in 'G5Tests\SkattetabellTests2020.pas',
  DecimalRounding_JH1 in 'G5Modules\Trekktabeller\DecimalRounding_JH1.pas',
  Trekktabeller.Fradrag in 'G5Modules\Trekktabeller\Trekktabeller.Fradrag.pas',
  Trekktabeller.Konstanter in 'G5Modules\Trekktabeller\Trekktabeller.Konstanter.pas',
  Trekktabeller.Nettolonn in 'G5Modules\Trekktabeller\Trekktabeller.Nettolonn.pas',
  Trekktabeller.Periode in 'G5Modules\Trekktabeller\Trekktabeller.Periode.pas',
  Trekktabeller.Skatteberegning in 'G5Modules\Trekktabeller\Trekktabeller.Skatteberegning.pas',
  Trekktabeller.Tabellnummer in 'G5Modules\Trekktabeller\Trekktabeller.Tabellnummer.pas',
  Trekktabeller.Tabelltype in 'G5Modules\Trekktabeller\Trekktabeller.Tabelltype.pas',
  Trekktabeller.Trekkrutine in 'G5Modules\Trekktabeller\Trekktabeller.Trekkrutine.pas',
  Trekktabeller.Trekktabeller2020.Konstanter in 'G5Modules\Trekktabeller\Trekktabeller.Trekktabeller2020.Konstanter.pas',
  Trekktabeller.Trekktabeller2020.Skattetabell2020 in 'G5Modules\Trekktabeller\Trekktabeller.Trekktabeller2020.Skattetabell2020.pas',
  Trekktabeller.Trekktabeller2021.Konstanter in 'G5Modules\Trekktabeller\Trekktabeller.Trekktabeller2021.Konstanter.pas',
  Trekktabeller.Trekktabeller2021.Skattetabell2021 in 'G5Modules\Trekktabeller\Trekktabeller.Trekktabeller2021.Skattetabell2021.pas',
  Trekktabeller.Utils in 'G5Modules\Trekktabeller\Trekktabeller.Utils.pas',
  uSkattFactory in 'G5Modules\Trekktabeller\uSkattFactory.pas',
  Trekktabeller.Trekktabeller2020.Tabellnummer in 'G5Modules\Trekktabeller\Trekktabeller.Trekktabeller2020.Tabellnummer.pas',
  Trekktabeller.Trekktabeller2021.Tabellnummer in 'G5Modules\Trekktabeller\Trekktabeller.Trekktabeller2021.Tabellnummer.pas',
  Trekktabeller.Trekktabeller2018.Periode in 'G5Modules\Trekktabeller\Trekktabeller.Trekktabeller2018.Periode.pas',
  SkattetabellTests2021 in 'G5Tests\SkattetabellTests2021.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
