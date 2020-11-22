unit Trekktabeller.Fradrag;

interface

uses Trekktabeller.Konstanter, Trekktabeller.Utils, Trekktabeller.Tabellnummer,
  Trekktabeller.Tabelltype;

type TFradrag = class(TObject)
private
  FKonstanter:TKonstanter;
  function beregnMinstefradragVanlig(personInntektAar:integer):integer;
  function beregnMinstefradragPensjon(personInntektAar:integer):integer;
  function beregnMinstefradragSjo(personInntektAar:integer):integer;
public
  function beregnMinsteFradrag(aTabellnummer:TTabellnummer;personInntektAar:integer):integer;
  function beregnSjoFradrag(aTabellnummer:TTabellnummer;personInntektAar:integer):integer;
  function beregnStandardFradrag(aTabellnummer:TTabellnummer;personInntektAar:integer):integer;
  constructor Create(aKonst:TKonstanter);
end;

implementation

{ TFradrag }

function TFradrag.beregnMinsteFradrag(aTabellnummer: TTabellnummer;
  personInntektAar: integer): integer;
begin
  if (aTabellnummer.tabelltype = Tabelltype.PENSJONIST) then
  begin
    result:=beregnMinstefradragPensjon(personInntektAar);
    exit;
  end;
  if (aTabellnummer.tabelltype = Tabelltype.SJO) then
  begin
    result:=beregnMinstefradragSjo(personInntektAar);
    exit;
  end;
  result:=beregnMinstefradragVanlig(personInntektAar);

end;

function TFradrag.beregnMinstefradragPensjon(
  personInntektAar: integer): integer;
begin
  result := RoundAwayFromZero((personInntektAar * FKonstanter.ANV_MINSTE_FRAD_PROSENT_PENSJ) / 100);
  if (result > FKonstanter.MAX_ANV_MINSTE_FRADRAG_PENSJ) then
      result := FKonstanter.MAX_ANV_MINSTE_FRADRAG_PENSJ;
  if (result < FKonstanter.MIN_ANV_MINSTE_FRADRAG) then
      result := FKonstanter.MIN_ANV_MINSTE_FRADRAG;
  if (result > personInntektAar) then
      result := personInntektAar;
end;

function TFradrag.beregnMinstefradragSjo(personInntektAar: integer): integer;
begin
  result :=  RoundAwayFromZero((personInntektAar * FKonstanter.MINSTE_FRAD_PROSENT) / 100);

  if (result > FKonstanter.MAX_MINSTE_FRADRAG) then
      result := FKonstanter.MAX_MINSTE_FRADRAG;
  if (result < FKonstanter.MIN_MINSTE_FRADRAG) then
      result := FKonstanter.MIN_MINSTE_FRADRAG;
  if (result < FKonstanter.LONNSFRADRAG) then
      result := FKonstanter.LONNSFRADRAG;
  if (result > personInntektAar) then
      result := personInntektAar;
end;

function TFradrag.beregnMinstefradragVanlig(personInntektAar: integer): integer;
begin
  result := RoundAwayFromZero((personInntektAar * FKonstanter.ANV_MINSTE_FRAD_PROSENT) / 100);

  if result > FKonstanter.MAX_ANV_MINSTE_FRADRAG then
    result := FKonstanter.MAX_ANV_MINSTE_FRADRAG;

  if result < FKonstanter.MIN_ANV_MINSTE_FRADRAG then
    result := FKonstanter.MIN_ANV_MINSTE_FRADRAG;

  if result < FKonstanter.ANV_LONNSFRADRAG then
    result := FKonstanter.ANV_LONNSFRADRAG;

  if result > personInntektAar then
    result := personInntektAar;

end;

function TFradrag.beregnSjoFradrag(aTabellnummer: TTabellnummer;
  personInntektAar: integer): integer;
begin
  if aTabellnummer.tabelltype <> Tabelltype.SJO then
  begin
    result := 0;
    exit;
  end;
  result := RoundAwayFromZero((personInntektAar * FKonstanter.SJO_PROSENT) / 100);
  if result > FKonstanter.MAX_SJO_FRADRAG then
    result:=FKonstanter.MAX_SJO_FRADRAG;
end;

function TFradrag.beregnStandardFradrag(aTabellnummer: TTabellnummer;
  personInntektAar: integer): integer;
begin
  if not aTabellnummer.isStandardFradrag then
  begin
    result:=0;
    exit;
  end;
  result := RoundAwayFromZero((personInntektAar * FKonstanter.STFRADRAG_PROSENT) / 100);
  if result > FKonstanter.MAX_STFRADRAG then
    result:=FKonstanter.MAX_STFRADRAG;
end;

constructor TFradrag.Create(aKonst: TKonstanter);
begin
  FKonstanter:=aKonst;
end;

end.
