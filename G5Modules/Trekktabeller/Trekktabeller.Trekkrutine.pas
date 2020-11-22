unit Trekktabeller.Trekkrutine;

interface

uses Trekktabeller.Tabellnummer, Trekktabeller.Skatteberegning,
  Trekktabeller.Periode, Trekktabeller.Tabelltype, System.Math,
  Trekktabeller.Utils, Trekktabeller.Fradrag;

function beregnTabelltrekk(aTabellnummer:TTabellnummer; aPeriode:PeriodeData; trekkgrunnlag:integer; Skatt:TSkatteberegning; Frad:TFradrag):integer;

implementation

function beregnSkatt( aTabellnummer:TTabellnummer; Skatt:TSkatteberegning; personInntektAar:double; alminneligInntektAar:double):integer;
begin
        result:=Skatt.beregnKommuneskatt(alminneligInntektAar)
                + Skatt.beregnFelleseskatt(aTabellnummer, alminneligInntektAar)
                + Skatt.beregnTrinnskatt(aTabellnummer, personInntektAar)
                + Skatt.beregnTrygdeavgift(aTabellnummer, personInntektAar);
end;

function beregnTrekk(aTabellnummer:TTabellnummer; aPeriode:PeriodeData; sumSkatt:double) :integer;
var
  trekkMedDesimaler:double;
begin
  trekkMedDesimaler := sumSkatt / aPeriode.trekkPeriode;
  if aTabellnummer.tabelltype = Tabelltype.SJO then
    result := Floor(trekkMedDesimaler)
  else
    result:=RoundAwayFromZero(trekkMedDesimaler);
end;

function finnAvrundetTrekkgrunnlag(aPeriode:PeriodeData; trekkgrunnlag:integer):integer;
begin
  result:=RoundAwayFromZero((trekkgrunnlag div aPeriode.avrunding * aPeriode.avrunding) + (aPeriode.avrunding / 2.0));
end;

function finnAlminneligInntektAar(aTabellnummer:TTabellnummer; personInntektAar:integer; aFradrag:TFradrag):integer;
begin
  result:=
      personInntektAar
      - aFradrag.beregnMinsteFradrag(aTabellnummer, personInntektAar)
      - aTabellnummer.tabellFradrag
      - aFradrag.beregnStandardFradrag(aTabellnummer, personInntektAar)
      - aFradrag.beregnSjoFradrag(aTabellnummer, personInntektAar)
      - aTabellnummer.klasseFradrag;
end;

function beregnTabelltrekk(aTabellnummer:TTabellnummer; aPeriode:PeriodeData; trekkgrunnlag:integer; Skatt:TSkatteberegning; Frad:TFradrag):integer;
var
  avrundetTrekkgrunnlag, overskytendeTrekk, personInntektAar : integer;
  alminneligInntektAar:double;
  sumSkatt:integer;
begin
  avrundetTrekkgrunnlag := finnAvrundetTrekkgrunnlag(aPeriode, trekkgrunnlag);
  overskytendeTrekk := Skatt.beregnOverskytendeTrekk(aTabellnummer, aPeriode, avrundetTrekkgrunnlag);

  if overskytendeTrekk > 0 then
      avrundetTrekkgrunnlag := aPeriode.maxTrekkgrunnlag;
  personInntektAar := RoundAwayFromZero(avrundetTrekkgrunnlag * aPeriode.inntektsPeriode);
  alminneligInntektAar := finnAlminneligInntektAar(aTabellnummer, personInntektAar, Frad);
  sumSkatt := beregnSkatt(aTabellnummer, Skatt, personInntektAar, alminneligInntektAar);
  result := beregnTrekk(aTabellnummer, aPeriode, sumSkatt) + overskytendeTrekk;
  if (result > trekkgrunnlag) and (overskytendeTrekk = 0) then
    result := trekkgrunnlag;

end;

end.
