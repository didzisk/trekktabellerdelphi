unit Trekktabeller.Skatteberegning;

interface

uses Trekktabeller.Konstanter, Trekktabeller.Utils, Trekktabeller.Tabellnummer,
  Trekktabeller.Tabelltype, Trekktabeller.Periode;

type TSkatteberegning = class(TObject)
private
  FKonstanter:TKonstanter;
  function beregnTrygdeavgiftLavSats(personInntektAar:double):integer;
  function beregnTrygdeavgiftHoySats(personInntektAar:double):integer;
public
  function beregnKommuneskatt(alminneligInntektAar:double):integer;
  function beregnFelleseskatt(aTabellnummer:TTabellnummer; alminneligInntektAar:double):integer;
  function beregnTrinnskatt(aTabellnummer:TTabellnummer; personInntektAar:double):integer;
  function beregnTrygdeavgift(aTabellnummer:TTabellnummer; personInntektAar:double):integer;
  function beregnOverskytendeTrekk(aTabellnummer:TTabellnummer;per: PeriodeData;avrundetTrekkgrunnlag:double):integer;
  constructor Create(Konst:TKonstanter);
end;

implementation

function TSkatteberegning.beregnKommuneskatt(
  alminneligInntektAar: double): integer;
begin
  if alminneligInntektAar > 0 then
    result:=RoundAwayFromZero(alminneligInntektAar * FKonstanter.SKATTORE / 100)
  else
    result:=0;
end;

function TSkatteberegning.beregnFelleseskatt(aTabellnummer: TTabellnummer;
  alminneligInntektAar: double): integer;
begin
  result:=0;
  if alminneligInntektAar < 0 then
    exit;
  if aTabellnummer.tabelltype = Tabelltype.FINNMARK then
    result:=RoundAwayFromZero(alminneligInntektAar * FKonstanter.FELLES_SKATT_FINNMARK / 100)
  else
    result:=RoundAwayFromZero(alminneligInntektAar * FKonstanter.FELLES_SKATT_VANLIG / 100);
end;

function TSkatteberegning.beregnTrinnskatt(aTabellnummer: TTabellnummer;
  personInntektAar: double): integer;
var
  prosentTrinn3, TRINNSKATT1, TRINNSKATT2, TRINNSKATT3, TRINNSKATT4:double;
begin
  if aTabellnummer.tabelltype = Tabelltype.FINNMARK then
    prosentTrinn3 := FKonstanter.PROSENT_TRINN3_FINNMARK
  else
    prosentTrinn3 := FKonstanter.PROSENT_TRINN3;
  if personInntektAar<FKonstanter.TRINN1 then
    TRINNSKATT1:=0
  else if personInntektAar<FKonstanter.TRINN2 then
    TRINNSKATT1:=(personInntektAar - FKonstanter.TRINN1) * FKonstanter.PROSENT_TRINN1 / 100.0
  else
    TRINNSKATT1:=(FKonstanter.TRINN2 - FKonstanter.TRINN1) * FKonstanter.PROSENT_TRINN1 / 100.0;

  if personInntektAar<FKonstanter.TRINN2 then
    TRINNSKATT2:=0
  else if personInntektAar<FKonstanter.TRINN3 then
    TRINNSKATT2:=(personInntektAar - FKonstanter.TRINN2) * FKonstanter.PROSENT_TRINN2 / 100.0
  else
    TRINNSKATT2:=(FKonstanter.TRINN3 - FKonstanter.TRINN2) * FKonstanter.PROSENT_TRINN2 / 100.0;

  if personInntektAar<FKonstanter.TRINN3 then
    TRINNSKATT3:=0
  else if personInntektAar<FKonstanter.TRINN4 then
    TRINNSKATT3:=(personInntektAar - FKonstanter.TRINN3) * prosentTrinn3 / 100.0
  else
    TRINNSKATT3:=(FKonstanter.TRINN4 - FKonstanter.TRINN3) * prosentTrinn3 / 100.0;

  if personInntektAar<FKonstanter.TRINN4 then
    TRINNSKATT4:=0
  else
    TRINNSKATT4:=(personInntektAar - FKonstanter.TRINN4) * FKonstanter.PROSENT_TRINN4 / 100.0;

  result:=RoundAwayFromZero(TRINNSKATT1 + TRINNSKATT2 + TRINNSKATT3 + TRINNSKATT4);
end;

function TSkatteberegning.beregnTrygdeavgift(aTabellnummer: TTabellnummer;
  personInntektAar: double): integer;
begin
  if (personInntektAar < FKonstanter.AVG_FRI_TRYGDEAVGIFT) then
  begin
    result:=0;
    exit;
  end;
  if aTabellnummer.ikkeTrygdeavgift then
  begin
    result:=0;
    exit;
  end;
  if aTabellnummer.lavSatsTrygdeavgift then
    result:=beregnTrygdeavgiftLavSats(personInntektAar)
  else
    result:=beregnTrygdeavgiftHoySats(personInntektAar);
end;

function TSkatteberegning.beregnTrygdeavgiftLavSats(
  personInntektAar: double): integer;
begin
  if personInntektAar > FKonstanter.LAV_GRENSE_TRYGDEAVGIFT then
    result:=RoundAwayFromZero(personInntektAar * FKonstanter.LAV_TRYGDEAVG_PROSENT / 100)
  else
    result:=RoundAwayFromZero((personInntektAar - FKonstanter.AVG_FRI_TRYGDEAVGIFT) * FKonstanter.TRYGDE_PROSENT / 100);
end;

function TSkatteberegning.beregnTrygdeavgiftHoySats(
  personInntektAar: double): integer;
begin
  if (personInntektAar > FKonstanter.HOY_GRENSE_TRYGDEAVGIFT) then
    result:=RoundAwayFromZero(personInntektAar * FKonstanter.HOY_TRYGDEAVG_PROSENT / 100)
  else
    result:=RoundAwayFromZero((personInntektAar - FKonstanter.AVG_FRI_TRYGDEAVGIFT) * FKonstanter.TRYGDE_PROSENT / 100);
end;

function TSkatteberegning.beregnOverskytendeTrekk(aTabellnummer: TTabellnummer;
  per: PeriodeData; avrundetTrekkgrunnlag: double): integer;
begin
  if per.maxTrekkgrunnlag > avrundetTrekkgrunnlag then
  begin
    result:=0;
    exit;
  end;
  result:=RoundAwayFromZero((avrundetTrekkgrunnlag - per.maxTrekkgrunnlag) * aTabellnummer.overskytendeProsent / 100);
end;

constructor TSkatteberegning.Create(Konst: TKonstanter);
begin
  FKonstanter:=Konst;
end;

end.
