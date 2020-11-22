unit Skatt;

{*****************************************************************************

   Skatt := TSkatt00.Create;
   Skatt.TabellNr := 7300;     Initierer tabeller etc.
   Skatt.Pensjonist := True/False;
   Skatt.TabType := 1;
   Skatt.TrekkGrunnlag := 25000.00;
   Trekk := Skatt.SumSkatt;             Beregner skattetrekk

*****************************************************************************}
interface

Uses
  SysUtils;

TYPE
  Tabell8 = Array [0..7] of Extended;
  Tabell4 = Array [0..3] of Extended;
  Tabell3 = Array [0..2] of Extended;

CONST
  TABTYPE_VANLIG     = 1;  { Tabelltype }
  TABTYPE_PENSJON    = 2;
  TABTYPE_STDFRADRAG = 3;
  TABTYPE_SJOMANN    = 4;

  KLASSE_1 = 1;            { Klasse }
  KLASSE_2 = 2;

  TREKPER_MAANED     = 1;  { Tab_Trekk_Periode }
  TREKPER_14_DAGER   = 2;
  TREKPER_UKE        = 3;
  TREKPER_4_DAGER    = 4;
  TREKPER_3_DAGER    = 5;
  TREKPER_2_DAGER    = 6;
  TREKPER_1_DAGER    = 7;

TYPE
  TSkatt = class
  private
    function GetTrekkGrunnlagAvrundet: Integer;
    function GetMaxTrekkGrunnlag: Integer;
  protected
    FNyBeregning : Boolean;
    Ws_Tabellnr  : SmallInt;
    Ws_Tab_Trekk_Periode : SmallInt;
    Ws_Trekk_Grlag       : Extended;
    Ws_Brutto_Tillegg    : Extended;
    Ws_Pensjonist        : String[1];
    FAntallUker: SmallInt;
    Ws_OppgrossingsGrunnlag: Extended;
    Ws_OppgrossingsTillegg: Extended;
    Ws_TrGrl_Avrundet     : Extended;
    Max_Trekk_Grunnlag    : Extended;

    Function l_runde( X : Extended ) : LongInt;
    Function l2_runde( X : Extended ) : LongInt;

    Procedure SetTabellNr( NyttNr : SmallInt );
    Procedure SetTabType( TypeNr : SmallInt );
    Procedure SetPensjonist( Status : Boolean );
    Function  GetPensjonist : Boolean;
    Procedure SetTrekkGrunnlag( TrekkGrl : Extended );
    procedure SetAntallUker(const Value: SmallInt);
    procedure SetOppgrossingsGrunnlag(Value : Extended);
    function  GetTolvMndSkatt : Boolean;
    Function  GetSumSkatt : LongInt; virtual; abstract;
    Function  GetSumSkattNetto : LongInt; virtual; abstract;

  public
    Property TabellNr : SmallInt read Ws_Tabellnr write SetTabellNr;
    Property TabType : SmallInt read Ws_Tab_Trekk_Periode write SetTabType;
    property AntallUker : SmallInt read FAntallUker write SetAntallUker;
    Property Pensjonist : Boolean read GetPensjonist write SetPensjonist;
    Property TrekkGrunnlag : Extended read Ws_Trekk_Grlag write SetTrekkGrunnlag;
    Property TrekkGrunnlagAvrundet:Integer read GetTrekkGrunnlagAvrundet; //output for test engine
    property MaxTrekkGrunnlag:Integer read GetMaxTrekkGrunnlag;
    Property SumSkatt : LongInt read GetSumSkatt;
    Property SumSkattNetto : LongInt read GetSumSkattNetto;
    Property OppgrossingsGrunnlag : Extended read Ws_OppgrossingsGrunnlag write SetOppgrossingsGrunnlag;
    Property OppgrossingsTillegg  : Extended read Ws_OppgrossingsTillegg;
    Property TolvMndSkatt : Boolean read GetTolvMndSkatt;
  end;

implementation

uses
  Math, DecimalRounding_JH1;

Procedure TSkatt.SetTabellNr( NyttNr : SmallInt );
begin
  Ws_Tabellnr := NyttNr;
  FNyBeregning := True;
end;

Procedure TSkatt.SetTabType( TypeNr : SmallInt );
begin
  Ws_Tab_Trekk_Periode := TypeNr;
  FNyBeregning := True;
end;

Procedure TSkatt.SetTrekkGrunnlag( TrekkGrl : Extended );
begin
  Ws_Trekk_Grlag := TrekkGrl;
  FNyBeregning := True;
end;

Procedure TSkatt.SetOppgrossingsGrunnlag( Value : Extended );
begin
  Ws_OppgrossingsGrunnlag := Value;
  Ws_OppgrossingsTillegg := Value * 0.5;
end;

Function TSkatt.GetPensjonist : Boolean;
begin
  if ( Ws_Pensjonist = 'p' ) or ( Ws_Pensjonist = 'P' ) then
    Result := True
  else
    Result := False
end;

Procedure TSkatt.SetPensjonist( Status : Boolean );
begin
  if Status then
    Ws_Pensjonist := 'P'
  else
    Ws_Pensjonist := '';

  FNyBeregning := True;
end;

procedure TSkatt.SetAntallUker(const Value: SmallInt);
begin
  FAntallUker := Value;
end;

function TSkatt.GetTolvMndSkatt : Boolean; { ref id 986 }
begin

  if ( Ws_Tabellnr = 7350 ) or
     ( Ws_Tabellnr = 7450 ) or
     ( Ws_Tabellnr = 7500 ) or
     ( Ws_Tabellnr = 7600 ) or
     ( Ws_Tabellnr = 7700 ) or
     ( Ws_Tabellnr = 7800 ) then
    result := True
  else
    result := False;

end;

{*** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- ***}
{* AVRUNDE ET DOUBLE TALL, RETURNERE EN LONG                               *}
{*** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- ***}

Function TSkatt.l_runde( X : Extended ) : LongInt;
begin

    Result:=Trunc(DecimalRoundExt(X, 0, drHalfUp ));

end;  { slutt l_runde }

{*** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- ***}
{* AVRUNDE ET DOUBLE TALL MED 0,0001, RETURNERE EN LONG                    *}
{*** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- *** --- ***}

Function TSkatt.l2_runde( X : Extended ) : LongInt;
begin

  if ( x > 0 ) then
  begin

    Result := Trunc( X + 0.0001 );

  end
  else
  begin

    Result := Trunc( X - 0.0001 );

  end;  { slutt if-else x > 0 }

end;  { slutt l2_runde }

function TSkatt.GetTrekkGrunnlagAvrundet: Integer;
begin
  Result:= Round(Ws_TrGrl_Avrundet);
end;

function TSkatt.GetMaxTrekkGrunnlag: Integer;
begin
  Result:=Round(Max_Trekk_Grunnlag);
end;

end.
