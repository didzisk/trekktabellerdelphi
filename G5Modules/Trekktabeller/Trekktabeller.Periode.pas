unit Trekktabeller.Periode;

interface

uses Trekktabeller.Tabellnummer, Trekktabeller.Tabelltype;

type Periode =
    ( PERIODE_1_MAANED = 1,
      PERIODE_14_DAGER = 2,
      PERIODE_1_UKE = 3,
      PERIODE_4_DAGER = 4,
      PERIODE_3_DAGER = 5,
      PERIODE_2_DAGER = 6,
      PERIODE_1_DAG = 7 );

type PeriodeData = record
        inntektsPeriode:double;
        trekkPeriode:double;
        avrunding:integer;
        maxTrekkgrunnlag:integer;
end;

function cpr //cpr means ConstructPeriodeRec
    (aTabell:TTabellnummer;
      inntektsPeriode, trekkPeriode,
      inntektsPeriodePensjon, trekkPeriodePensjon,
      inntektsPeriodeStandardfradrag, trekkPeriodeStandardfradrag:double;
      avrunding, maxTrekkgrunnlag:integer):PeriodeData;

implementation

//cpr means construct period record
function cpr
    (aTabell:TTabellnummer;
      inntektsPeriode, trekkPeriode,
      inntektsPeriodePensjon, trekkPeriodePensjon,
      inntektsPeriodeStandardfradrag, trekkPeriodeStandardfradrag:double;
      avrunding, maxTrekkgrunnlag:integer):PeriodeData;
begin
  //getInntektsPeriode(Tabellnummer tabellnummer)
  case aTabell.tabelltype of
    Tabelltype.PENSJONIST:
      result.inntektsPeriode := inntektsPeriodePensjon;
    Tabelltype.VANLIG:
      result.inntektsPeriode := inntektsPeriode;
    else
      result.inntektsPeriode := inntektsPeriodeStandardfradrag;
  end;
  //getTrekkPeriode(Tabellnummer tabellnummer)
  case aTabell.tabelltype of
    Tabelltype.PENSJONIST:
      result.trekkPeriode := trekkPeriodePensjon;
    Tabelltype.VANLIG:
      result.trekkPeriode := trekkPeriode;
    else
      if aTabell.trekk_i_12_mnd then
        result.trekkPeriode := inntektsPeriodeStandardfradrag
      else
        result.trekkPeriode := trekkPeriodeStandardfradrag;
  end;
  result.avrunding := avrunding;
  result.maxTrekkgrunnlag := maxTrekkgrunnlag;
end;

end.
