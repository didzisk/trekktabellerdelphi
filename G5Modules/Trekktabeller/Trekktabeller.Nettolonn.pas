unit Trekktabeller.Nettolonn;

interface

uses Trekktabeller.Tabellnummer, Trekktabeller.Skatteberegning,
  Trekktabeller.Periode, Trekktabeller.Fradrag, Trekktabeller.Trekkrutine,
  System.Math, System.SysUtils;

function beregnNettoTabelltrekk(aTabellnummer:TTabellnummer; aPeriode:PeriodeData; trekkgrunnlag:integer; Skatt:TSkatteberegning; Frad:TFradrag):integer;

implementation

function beregnNettoTabelltrekk(aTabellnummer:TTabellnummer; aPeriode:PeriodeData; trekkgrunnlag:integer; Skatt:TSkatteberegning; Frad:TFradrag):integer;
var
  BottomX, TopX, MiddleX:integer;
  BottomY, TopY, MiddleY:integer;
  BottomY1, TopY1, MiddleY1:integer;
  Trekk:integer;
begin
  BottomX:=trekkgrunnlag;
  TopX:=trekkgrunnlag * 2;
  repeat
    MiddleX := (BottomX+TopX) div 2;
    BottomY:=beregnTabellTrekk(aTabellnummer, aPeriode, BottomX, Skatt, Frad);
    BottomY1:=beregnTabellTrekk(aTabellnummer, aPeriode, BottomX+BottomY, Skatt, Frad);
    TopY:=beregnTabellTrekk(aTabellnummer, aPeriode, TopX, Skatt, Frad);
    TopY1:=beregnTabellTrekk(aTabellnummer, aPeriode, TopX + TopY, Skatt, Frad);
    MiddleY:=beregnTabellTrekk(aTabellnummer, aPeriode, MiddleX, Skatt, Frad);
    MiddleY1:=beregnTabellTrekk(aTabellnummer, aPeriode, MiddleX+MiddleY, Skatt, Frad);
    if Sign(BottomX+BottomY-BottomY1-trekkgrunnlag)<>Sign(MiddleX+MiddleY-MiddleY1-trekkgrunnlag) then
    begin
      TopX:=MiddleX;
    end
    else if Sign(TopX+TopY-TopY1-trekkgrunnlag)<>Sign(MiddleX+MiddleY-MiddleY1-trekkgrunnlag) then
    begin
      BottomX:=MiddleX;
    end
    else
      raise Exception.Create('Unable to iterate');
  until Abs(TopX-BottomX)<2;
  Trekk:=beregnTabellTrekk(aTabellnummer, aPeriode, Trekkgrunnlag+MiddleY1, Skatt, Frad);
  result:=Trekk;
end;


end.
