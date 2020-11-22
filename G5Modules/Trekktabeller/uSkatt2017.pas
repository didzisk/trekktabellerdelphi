unit uSkatt2017;

interface

Uses
  SysUtils,
  Skatt;

TYPE
  TSkatt2017= class(TSkatt)
  private

    Tabelltype            : SmallInt;
    Klasse                : SmallInt;
    Tab_Trekk_Periode     : SmallInt;
    Sum_Trekk             : Extended;
    Parm_Ut_Trekk         : LongInt;

    Ws_Skatte_Prosent     : SmallInt;
    Ws_Tabell_Type        : SmallInt;
    Ws_Tabell_Nr          : SmallInt;

    Aars_Inntekt          : Extended;
    Skattbar_Inntekt      : Extended;
    Overskytende_Trekk    : Extended;
    Sum_Trinnskatt        : Extended;

    Ant_Inntekts_Perioder : Extended;
    Ant_Trekk_Perioder    : Extended;
    Kommune_Skatt         : Extended;
    Felles_Skatt          : Extended;
    Trygde_Avgift         : Extended;

    Procedure InitVars;
    Procedure CalcSkatt;
    Procedure CalcOppgrossing;    { ref id 986 }
    Procedure SettVanlig;
    Procedure SettVanligNetto;    { ref id 986 }
    Procedure SettPensjonist;
    Procedure SettStfradrag;
    Procedure SettSjomann;
    Procedure Avrund;
    Procedure BeregnAarsGrunnlag; { ref id 986 }
    Procedure BeregnOverskTrekk;
    Procedure BeregnFradrag;
    Procedure BeregnNettoskatt;
    Procedure BeregnTrygdeavgift;
    Procedure BeregnTrinnskatt;
    Procedure BeregnAarsTrekk;    { ref id 986 }
    Procedure BeregnTrekk;

  protected
    Function  GetSumSkatt : LongInt; override;
    Function  GetSumSkattNetto : LongInt; override;

  end;

implementation


var
  MAX_TRK_GRLAG                : Tabell8 = ( 0, 79800, 36800, 18400, 15900, 11900, 7900, 3900 );

  ANT_INNT_PERIODER_VANLIG     : Tabell8 = ( 0.0, 12.12, 26.26, 52.52, 60.60, 80.80, 121.20, 242.40 );
  ANT_TRK_PERIODER_VANLIG      : Tabell8 = ( 0.0, 10.5, 23.0, 46.0, 53.0769231 {=AvrundExt((60*46)/52.0, 7), because Cobol uses 7 digits}, (80*46)/52.0, (120*46)/52.0, (240*46)/52.0 );

  ANT_INNT_PERIODER_PENSJONIST : Tabell8 = ( 0.0, 12.0, 26.0, 52.0, 91.0, 122.0, 183.0, 365.0 );
  ANT_TRK_PERIODER_PENSJONIST  : Tabell8 = ( 0.0, 11.0, 24.0, 48.0, (91*11)/12.0, (122*11)/12.0, (183*11)/12.0, (365*11)/12.0 );

  ANT_INNT_PERIODER_STFRADRAG  : Tabell8 = ( 0.0, 12.0, 26.0, 52.0, 91.0, 122.0, 183.0, 365.0 );
  ANT_TRK_PERIODER_STFRADRAG   : Tabell8 = ( 0.0, 10.5, 23.0, 46.0, (91*10.5)/12.0, (122*10.5)/12.0, (183*10.5)/12.0, (365*10.5)/12.0 );

  ANT_INNT_PERIODER_SJO        : Tabell4 = ( 0.0, 12.0, 26.0, 52.0 );
  ANT_TRK_PERIODER_SJO         : Tabell4 = ( 0.0, 12.0, 26.0, 52.0 );

  WS_KLASSE_FRADRAG            : Tabell3 = ( 0, 0, 0 );
const
  KLASSE1_VANLIG               = 53150;
  KLASSE2_VANLIG               = 78300;
  KLASSE1_FINNMARK             = 68650;
  KLASSE2_FINNMARK             = 93800;

const
  TRINNSKATT_GRENSE1 = 164100;
  TRINNSKATT_GRENSE2 = 230950;
  TRINNSKATT_GRENSE3 = 580650;
  TRINNSKATT_GRENSE4 = 934050;

  TRINNSKATT_PROSENT1 = 0.93;
  TRINNSKATT_PROSENT2 = 2.41;
  TRINNSKATT_PROSENT3_VANLIG = 11.52;
  TRINNSKATT_PROSENT3_FINNMARK = 9.52;
  TRINNSKATT_PROSENT4 = 14.52;

var
  TRINNSKATT_PROSENT3:extended;

const
  Skattore                     : Extended = 14.45;


var
  FELLES_SKATT_PROSENT:Currency = 0.00;
const
  FELLES_SKATT_VANLIG          = 9.55;
  FELLES_SKATT_FINNMARK        = 6.05;


  LAV_GRENSE_TRYGDEAVGIFT      = 68656;
  HOY_GRENSE_TRYGDEAVGIFT      = 81324;
  AVG_FRI_TRYGDEAVGIFT         = 54650;

  TRYGDE_PROSENT               = 25;
  LAV_TRYGDEAVG_PROSENT        = 5.1;
  HOY_TRYGDEAVG_PROSENT        = 8.2;

  STFRADRAG_PROSENT            = 10;
  MAX_STFRADRAG                = 40000;

  ANV_MINSTE_FRAD_PROSENT      = 38.72;
  ANV_MINSTE_FRAD_PROSENT_PENSJ= 25.52;
  MIN_ANV_MINSTE_FRADRAG       = 3520;
  MAX_ANV_MINSTE_FRADRAG       = 83380;
  MAX_ANV_MINSTE_FRADRAG_PENSJ = 66000;

  MINSTE_FRAD_PROSENT          = 44.0;

  MIN_MINSTE_FRADRAG           = 4000;
  MAX_MINSTE_FRADRAG           = 94750;

  LONNSFRADRAG                 = 31800;
  ANV_LONNSFRADRAG             = 27984;

  SJO_PROSENT                  = 30;
  MAX_SJO_FRADRAG              = 80000;

Function TSkatt2017.GetSumSkatt : LongInt;
Var
  OrgTrgrl : Extended;
  OrgPer   : SmallInt;
begin

  OrgTrgrl := Ws_Trekk_Grlag;
  OrgPer := Ws_Tab_Trekk_Periode;

  if FNyBeregning then
  begin

    if ( Ws_Tab_Trekk_Periode = TREKPER_UKE ) then
      if ( FAntallUker > 1 ) then
      begin

        if ( FAntallUker <> 4 ) then
          Ws_Trekk_Grlag := OrgTrgrl/FAntallUker
        else
        begin

          Ws_Tab_Trekk_Periode := TREKPER_14_DAGER;
          Ws_Trekk_Grlag := OrgTrgrl/2;

        end;

      end; // if antall uker mer enn  1

    InitVars;
    CalcSkatt;
    FNyBeregning := False;
    Ws_Tab_Trekk_Periode := OrgPer;

    if ( Ws_Tab_Trekk_Periode = TREKPER_UKE ) then
      if ( FAntallUker > 1 ) then
      begin

        Ws_Trekk_Grlag := OrgTrgrl;

        if ( FAntallUker <> 4 ) then
          Parm_Ut_Trekk := Parm_Ut_Trekk*FAntallUker
        else
          Parm_Ut_Trekk := Parm_Ut_Trekk*2;

      end; // if antall uker mer enn  1

  end;

  Result := Parm_Ut_Trekk;

end;

Function TSkatt2017.GetSumSkattNetto : LongInt;
Var
  OrgTrgrl : Extended;
  OrgPer   : SmallInt;
  Tillegg  : Extended;
  Skatt    : Extended;
  Tmp_Ws_Trekk_Grlag : Extended;
  //Tmp_Sum_Trekk : Extended;
  Tmp_Aars_Inntekt : Extended;
  //Netto_Aars_Inntekt : Extended;
  //Brutto_Tillegg_Aar : Extended;
begin

  OrgTrgrl := Ws_Trekk_Grlag;
  OrgPer := Ws_Tab_Trekk_Periode;
  Tillegg := 0.0;
  Skatt := 0.0;

  if FNyBeregning then
  begin

    if ( Ws_Tab_Trekk_Periode = TREKPER_UKE ) then
      if ( FAntallUker > 1 ) then
      begin

        if ( FAntallUker <> 4 ) then
          Ws_Trekk_Grlag := OrgTrgrl/FAntallUker
        else
        begin

          Ws_Tab_Trekk_Periode := TREKPER_14_DAGER;
          Ws_Trekk_Grlag := OrgTrgrl/2;

        end;

      end; // if antall uker mer enn  1

    InitVars;

    Tmp_Ws_Trekk_Grlag := Ws_Trekk_Grlag;
    BeregnAarsGrunnlag;

      Tmp_Aars_Inntekt := Tmp_Ws_Trekk_Grlag * Ant_Inntekts_Perioder;

      // Approksimerer AarsInntekt = Netto_AarsInntekt + Sum_Trekk ved iterasjon
      repeat

        Tmp_Aars_Inntekt := Tmp_Aars_Inntekt + Tillegg;
        Aars_Inntekt := Tmp_Aars_Inntekt;
        Skatt := Skatt + Tillegg;   // samme som: Skatt := Aars_Inntekt - Netto_AarsInntekt;
        CalcOppgrossing;
        Tillegg := Sum_Trekk - Skatt; // Triks for raskere konvergens (i ML3: (Sum_Trekk - Skatt) / 2)

      until ( Abs( Tillegg ) <= 0.5 );
    CalcSkatt;

    FNyBeregning := False;
    Ws_Tab_Trekk_Periode := OrgPer;

    if ( Ws_Tab_Trekk_Periode = TREKPER_UKE ) then
      if ( FAntallUker > 1 ) then
      begin

        Ws_Trekk_Grlag := OrgTrgrl;

        if ( FAntallUker <> 4 ) then
          Parm_Ut_Trekk := Parm_Ut_Trekk*FAntallUker
        else
          Parm_Ut_Trekk := Parm_Ut_Trekk*2;

      end; // if antall uker mer enn  1

  end;

  Result := Parm_Ut_Trekk;

end;

Procedure TSkatt2017.InitVars;
begin

  Aars_Inntekt := 0;
  Skattbar_Inntekt := 0.0;
  Overskytende_Trekk := 0.0;
  Sum_Trinnskatt := 0.0;
  Max_Trekk_Grunnlag := 0;
  Ant_Inntekts_Perioder := 0.0;
  Ant_Trekk_Perioder := 0.0;
  Kommune_Skatt := 0.0;
  Felles_Skatt := 0.0;
  Trygde_Avgift := 0.0;
  Sum_Trekk := 0.0;

  Ws_Skatte_Prosent := Ws_Tabellnr div 1000;
  Ws_Tabell_Type := Ws_Tabellnr mod 1000 div 100;
  Ws_Tabell_Nr := Ws_Tabellnr mod 100;

  if ( Ws_Tabell_Type < TABTYPE_STDFRADRAG ) then
    Tabelltype := TABTYPE_VANLIG
  else
    Tabelltype := TABTYPE_STDFRADRAG;

  if ( Ws_Pensjonist = 'P' ) or ( Ws_Pensjonist = 'p' ) then
    Tabelltype := TABTYPE_PENSJON;

  if ( Ws_Skatte_Prosent = 0 ) then
    Tabelltype := TABTYPE_SJOMANN;

  if Ws_Skatte_Prosent=6 then
  begin
    WS_KLASSE_FRADRAG[1]:=KLASSE1_FINNMARK;
    WS_KLASSE_FRADRAG[2]:=KLASSE2_FINNMARK;
    FELLES_SKATT_PROSENT:=FELLES_SKATT_FINNMARK;
    TRINNSKATT_PROSENT3:=TRINNSKATT_PROSENT3_FINNMARK;
  end
  else
  begin
    WS_KLASSE_FRADRAG[1]:=KLASSE1_VANLIG;
    WS_KLASSE_FRADRAG[2]:=KLASSE2_VANLIG;
    FELLES_SKATT_PROSENT:=FELLES_SKATT_VANLIG;
    TRINNSKATT_PROSENT3:=TRINNSKATT_PROSENT3_VANLIG;
  end;

  Case Ws_Tab_Trekk_Periode of

    TREKPER_MAANED, TREKPER_14_DAGER, TREKPER_UKE,
    TREKPER_4_DAGER, TREKPER_3_DAGER, TREKPER_2_DAGER, TREKPER_1_DAGER :
      Tab_Trekk_Periode := Ws_Tab_Trekk_Periode;

  end;

end;

Procedure TSkatt2017.CalcSkatt;
begin

  Case Tabelltype of

    TABTYPE_VANLIG : SettVanlig;

    TABTYPE_PENSJON : SettPensjonist;

    TABTYPE_STDFRADRAG : SettStfradrag;

    TABTYPE_SJOMANN : SettSjomann;

  end;

  Avrund;
  BeregnFradrag;
  BeregnNettoskatt;
  BeregnTrygdeavgift;
  BeregnTrinnskatt;
  BeregnTrekk;

end;

Procedure TSkatt2017.CalcOppgrossing;           { ref id 986 }
begin

  Ws_Trekk_Grlag := Aars_Inntekt / Ant_Inntekts_Perioder;

  if ( Ws_Trekk_Grlag > Max_Trekk_Grunnlag ) then
    BeregnOverskTrekk;

  Ws_TrGrl_Avrundet := Ws_Trekk_Grlag;
  Aars_Inntekt := (Ws_Trekk_Grlag*Ant_Inntekts_Perioder);

  BeregnFradrag;
  BeregnNettoskatt;
  BeregnTrygdeavgift;
  BeregnTrinnskatt;
  BeregnAarsTrekk;

end;

Procedure TSkatt2017.SettVanlig;
begin

  Klasse := Ws_Tabell_Type;

  Max_Trekk_Grunnlag := MAX_TRK_GRLAG[ Ws_Tab_Trekk_Periode];

  if (Ws_Tabell_Nr in [50,60,70]) then
    Ant_Inntekts_Perioder:=ANT_INNT_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode]
  else
    Ant_Inntekts_Perioder := ANT_INNT_PERIODER_VANLIG[ Ws_Tab_Trekk_Periode];

  if (Ws_Tabell_Nr in [50,60]) then
    Ant_Trekk_Perioder :=ANT_INNT_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode]
  else
    if Ws_Tabell_Nr=70 then
      Ant_Trekk_Perioder :=ANT_TRK_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode]
    else
      Ant_Trekk_Perioder := ANT_TRK_PERIODER_VANLIG[ Ws_Tab_Trekk_Periode];

  if ( Ws_Trekk_Grlag > Max_Trekk_Grunnlag ) then
    BeregnOverskTrekk;
end;  { slutt SettVanlig }

Procedure TSkatt2017.SettVanligNetto;
begin

  Klasse := Ws_Tabell_Type;

  Max_Trekk_Grunnlag := MAX_TRK_GRLAG[ Ws_Tab_Trekk_Periode];

  Ant_Inntekts_Perioder := ANT_INNT_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode]; // NB! Standardfradrag
  Ant_Trekk_Perioder := ANT_TRK_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode]; // NB! Standardfradrag

  if ( Ws_Trekk_Grlag > Max_Trekk_Grunnlag ) then
    BeregnOverskTrekk;

end;  { slutt SettVanligNetto }

Procedure TSkatt2017.SettPensjonist;
begin

  Klasse := Ws_Tabell_Type;

  Max_Trekk_Grunnlag := MAX_TRK_GRLAG[ Ws_Tab_Trekk_Periode];

  Ant_Inntekts_Perioder := ANT_INNT_PERIODER_PENSJONIST[ Ws_Tab_Trekk_Periode];
  Ant_Trekk_Perioder := ANT_TRK_PERIODER_PENSJONIST[ Ws_Tab_Trekk_Periode];

  if ( Ws_Trekk_Grlag > Max_Trekk_Grunnlag ) then
    BeregnOverskTrekk;

end;  { slutt SettPensjonist }

Procedure TSkatt2017.SettStfradrag;
begin

  if ( Ws_Tabell_Type in [ 3, 5, 7 ] ) then
    Klasse := 1
  else
    Klasse := 2;

  Max_Trekk_Grunnlag := MAX_TRK_GRLAG [ Ws_Tab_Trekk_Periode ];

  Ant_Inntekts_Perioder := ANT_INNT_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode ];

  if ( Ws_Tabellnr = 7350 ) or
     ( Ws_Tabellnr = 7450 ) or
     ( Ws_Tabellnr = 7500 ) or
     ( Ws_Tabellnr = 7600 ) or
     ( Ws_Tabellnr = 7700 ) or
     ( Ws_Tabellnr = 7800 ) or
     ( Ws_Tabellnr = 6350 ) or
     ( Ws_Tabellnr = 6450 ) or
     ( Ws_Tabellnr = 6500 ) or
     ( Ws_Tabellnr = 6600 ) or
     ( Ws_Tabellnr = 6700 ) or
     ( Ws_Tabellnr = 6800 ) then
    Ant_Trekk_Perioder := ANT_INNT_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode ]
  else
    Ant_Trekk_Perioder := ANT_TRK_PERIODER_STFRADRAG[ Ws_Tab_Trekk_Periode ];

  if ( Ws_Trekk_Grlag > Max_Trekk_Grunnlag ) then
    BeregnOverskTrekk;

end;  { slutt SettStfradrag() }

Procedure TSkatt2017.SettSjomann;
begin

  if ( Ws_Tabell_Type = 1 ) then
    Klasse := 1
  else
    Klasse := 2;

  Max_Trekk_Grunnlag := MAX_TRK_GRLAG [ Ws_Tab_Trekk_Periode];

  Ant_Inntekts_Perioder := ANT_INNT_PERIODER_SJO[ Ws_Tab_Trekk_Periode];
  Ant_Trekk_Perioder := ANT_TRK_PERIODER_SJO[ Ws_Tab_Trekk_Periode];

  if ( Ws_Trekk_Grlag > Max_Trekk_Grunnlag ) then
    BeregnOverskTrekk;

end;  { Slutt SettSjomann }

Procedure TSkatt2017.Avrund;
begin
  Case Tab_Trekk_Periode of

    TREKPER_MAANED :
    begin
      Ws_TrGrl_Avrundet := ( Trunc( Ws_Trekk_Grlag / 100 ) * 100 );
      Ws_Trekk_Grlag := ( Trunc( Ws_Trekk_Grlag / 100 ) * 100 + 50 );
    end;

    TREKPER_14_DAGER :
    begin
      Ws_TrGrl_Avrundet := ( Trunc( Ws_Trekk_Grlag / 50 ) * 50 );
      Ws_Trekk_Grlag := ( Trunc( Ws_Trekk_Grlag / 50 ) * 50 + 25 );
    end;

    else
    begin
      Ws_TrGrl_Avrundet := ( Trunc( Ws_Trekk_Grlag / 20 ) * 20 );
      Ws_Trekk_Grlag := ( Trunc( Ws_Trekk_Grlag / 20 ) * 20 + 10 );
    end;

  end;  { slutt switch Tab_Trekk_Periode }

  Aars_Inntekt := (Ws_Trekk_Grlag*Ant_Inntekts_Perioder);

end;  { slutt Avrund() }


Procedure TSkatt2017.BeregnAarsGrunnlag;
begin

  Case Tabelltype of

    TABTYPE_VANLIG :
      SettVanligNetto;

    TABTYPE_PENSJON :
     SettPensjonist;

    TABTYPE_STDFRADRAG :
     SettStfradrag;

    TABTYPE_SJOMANN :
     SettSjomann;

  end; { Slutt switch TabellType }

end;  { slutt CalcSkatt() }

Procedure TSkatt2017.BeregnOverskTrekk;
var
  Overskytende_Prosent: Extended; // 2000
begin

  Overskytende_Prosent := 0.0;

  Case Tabelltype of

    TABTYPE_PENSJON :Overskytende_Prosent := 0.48;

    TABTYPE_VANLIG : Overskytende_Prosent := 0.53;


  end;  { slutt case Tabelltype }

  Case Ws_Tabellnr of

    7300, 7400 : Overskytende_Prosent := 0.53;

    7350, 7450 : Overskytende_Prosent := 0.47;

    7500, 7600 : Overskytende_Prosent := 0.39;

    7550, 7650 : Overskytende_Prosent := 0.44;

    7700, 7800 : Overskytende_Prosent := 0.44;

    100, 200 : Overskytende_Prosent := 0.39;

    101, 201 : Overskytende_Prosent := 0.47;

    6300, 6400 : Overskytende_Prosent := 0.49;

    6350, 6450 : Overskytende_Prosent := 0.43;

    6500, 6600 : Overskytende_Prosent := 0.35;

    6550, 6650 : Overskytende_Prosent := 0.40;

    6700, 6800 : Overskytende_Prosent := 0.40;

    7150, 7250 : Overskytende_Prosent := 0.47;

    7160, 7260 : Overskytende_Prosent := 0.39;

    7170, 7270 : Overskytende_Prosent := 0.44;
  end;  { slutt case Ws_Tabellnr }

  Case Tab_Trekk_Periode of

    TREKPER_MAANED :
      Ws_Trekk_Grlag := ( Trunc( Ws_Trekk_Grlag / 100 ) * 100 );

    TREKPER_14_DAGER :
      Ws_Trekk_Grlag := ( Trunc( Ws_Trekk_Grlag / 50 ) * 50 );

    TREKPER_UKE, TREKPER_4_DAGER, TREKPER_3_DAGER, TREKPER_2_DAGER, TREKPER_1_DAGER :
       Ws_Trekk_Grlag := ( Trunc( Ws_Trekk_Grlag / 20 ) * 20 );

  end;  { slutt case Tab_Trekk_Periode }

  Overskytende_Trekk := (Ws_Trekk_Grlag - Max_Trekk_Grunnlag)*Overskytende_Prosent;

  Ws_Trekk_Grlag := Max_Trekk_Grunnlag;

end;  { slutt BeregnOverskTrekk }

Procedure TSkatt2017.BeregnFradrag;
var
  Anv_Minste_Fradrag    : Extended;
  Ws_Lonnsfradrag       : Extended;
  Minste_Fradrag        : Extended;
  Fradrag               : Extended;
  St_Fradrag            : Extended;
  Sjo_Fradrag           : Extended;
  Klasse_Fradrag        : Extended;
begin

  Anv_Minste_Fradrag := 0.0;
  Minste_Fradrag := 0.0;
  Fradrag := 0.0;
  St_Fradrag := 0.0;
  Sjo_Fradrag := 0.0;

  Case Tabelltype of
  TABTYPE_VANLIG, TABTYPE_STDFRADRAG:
    begin
      Anv_Minste_Fradrag := ( Aars_Inntekt * ANV_MINSTE_FRAD_PROSENT ) / 100.0;

      if ( Anv_Minste_Fradrag > MAX_ANV_MINSTE_FRADRAG ) then
         Anv_Minste_Fradrag := MAX_ANV_MINSTE_FRADRAG
      else
         if ( Anv_Minste_Fradrag < MIN_ANV_MINSTE_FRADRAG ) then
            Anv_Minste_Fradrag := MIN_ANV_MINSTE_FRADRAG;

      if ( Aars_Inntekt < ANV_LONNSFRADRAG ) then
        Ws_Lonnsfradrag := Aars_Inntekt
      else
        Ws_Lonnsfradrag := ANV_LONNSFRADRAG;

      if ( Ws_Lonnsfradrag < 0 ) then
        Ws_Lonnsfradrag := 0.0;

      if ( Ws_Lonnsfradrag > Anv_Minste_Fradrag ) then
        Anv_Minste_Fradrag := Ws_Lonnsfradrag;

      if ( Aars_Inntekt < Anv_Minste_Fradrag ) then
        Anv_Minste_Fradrag := Aars_Inntekt;
    end;  { slutt if vanlig eller stdfradrag }
  TABTYPE_PENSJON:
    begin
      Anv_Minste_Fradrag := ( Aars_Inntekt * ANV_MINSTE_FRAD_PROSENT_PENSJ ) / 100.0;

      if ( Anv_Minste_Fradrag > MAX_ANV_MINSTE_FRADRAG_PENSJ ) then
        Anv_Minste_Fradrag := MAX_ANV_MINSTE_FRADRAG_PENSJ
      else
        if ( Anv_Minste_Fradrag < MIN_ANV_MINSTE_FRADRAG ) then
          Anv_Minste_Fradrag := MIN_ANV_MINSTE_FRADRAG;
    end;
  TABTYPE_SJOMANN:
    begin
      Minste_Fradrag := ( Aars_Inntekt * MINSTE_FRAD_PROSENT ) / 100.0;

      if ( Minste_Fradrag > MAX_MINSTE_FRADRAG ) then
         Minste_Fradrag := MAX_MINSTE_FRADRAG
      else
         if ( Minste_Fradrag < MIN_MINSTE_FRADRAG ) then
            Minste_Fradrag := MIN_MINSTE_FRADRAG;
      if ( Aars_Inntekt < LONNSFRADRAG ) then
        Ws_Lonnsfradrag := Aars_Inntekt
      else
        Ws_Lonnsfradrag := LONNSFRADRAG;

      if ( Ws_Lonnsfradrag < 0 ) then
        Ws_Lonnsfradrag := 0.0;

      if ( Ws_Lonnsfradrag > Minste_Fradrag ) then
        Minste_Fradrag := Ws_Lonnsfradrag;

      if ( Aars_Inntekt < Minste_Fradrag ) then
        Minste_Fradrag := Aars_Inntekt;
    end;  { slutt if sjømann }
  end;

  if ( Tabelltype = TABTYPE_VANLIG ) or ( Tabelltype = TABTYPE_PENSJON ) then
  begin

    if ( Ws_Tabell_Nr < 10 ) then
      Fradrag := Ws_Tabell_Nr*4000.0;

    if ( Ws_Tabell_Nr = 10 ) then
      Fradrag := 41000.0;

    if ( Ws_Tabell_Nr = 11 ) then
      Fradrag := 46000.0;

    if ( Ws_Tabell_Nr = 12 ) then
      Fradrag := 53000.0;

    if ( Ws_Tabell_Nr > 12 ) And ( Ws_Tabell_Nr < 20 ) then   { OBS hva med 18 }
      Fradrag := (Ws_Tabell_Nr-7)*10000.0;

    if ( Ws_Tabell_Nr > 19 ) And ( Ws_Tabell_Nr < 29 ) then   { endret i 1996 }
      Fradrag := ((Ws_Tabell_Nr-19)*4000.0) * -1.0;

    if ( Ws_Tabell_Nr = 29 ) then
      Fradrag := -41000.0;

    if ( Ws_Tabell_Nr = 30 ) then
      Fradrag := -46000.0;

    if ( Ws_Tabell_Nr = 31 ) then
      Fradrag := -53000.0;

    if ( Ws_Tabell_Nr = 32 ) then
      Fradrag := -60000.0;

    if ( Ws_Tabell_Nr = 33 ) then
      Fradrag := -67000.0;
  end;  { slutt if vanlig eller pensjonist }

  if ( Tabelltype = TABTYPE_SJOMANN ) or ( Tabelltype = TABTYPE_STDFRADRAG  ) then
    St_Fradrag := ( Aars_Inntekt * STFRADRAG_PROSENT ) / 100.0;

  if St_Fradrag > MAX_STFRADRAG then
    St_Fradrag := MAX_STFRADRAG; //2005

  if ( Tabelltype = TABTYPE_SJOMANN ) then
    Sjo_Fradrag := ( Aars_Inntekt * SJO_PROSENT ) / 100.0;

  if ( Sjo_Fradrag > MAX_SJO_FRADRAG ) then
    Sjo_Fradrag := MAX_SJO_FRADRAG;

  Klasse_Fradrag := WS_KLASSE_FRADRAG[Klasse];

  Skattbar_Inntekt := Aars_Inntekt
                      - Anv_Minste_Fradrag
                      - Minste_Fradrag
                      - Fradrag
                      - St_Fradrag
                      - Sjo_Fradrag
                      - Klasse_Fradrag;

end;  { slutt BeregnFradrag }

Procedure TSkatt2017.BeregnNettoskatt;
begin

  if ( Skattbar_Inntekt >= 0 ) then
  begin
    Kommune_Skatt := ( Skattbar_Inntekt * Skattore ) / 100.0;
    Felles_Skatt := ( Skattbar_Inntekt * FELLES_SKATT_PROSENT ) / 100.0;
  end;

end;  { slutt BeregnNettoskatt }

Procedure TSkatt2017.BeregnTrygdeavgift;
begin

  if ( Ws_Tabellnr = 7500 ) or
     ( Ws_Tabellnr = 7550 ) or
     ( Ws_Tabellnr = 7600 ) or
     ( Ws_Tabellnr = 7650 ) or
     ( Ws_Tabellnr = 0100 ) or
     ( Ws_Tabellnr = 0200 ) or
     ( Ws_Tabellnr = 6500 ) or
     ( Ws_Tabellnr = 6550 ) or
     ( Ws_Tabellnr = 6600 ) or
     ( Ws_Tabellnr = 6650 ) or
     ( Ws_Tabellnr = 7160 ) or
     ( Ws_Tabellnr = 7170 ) or
     ( Ws_Tabellnr = 7260 ) or
     ( Ws_Tabellnr = 7270 ) or
     ( Aars_Inntekt < AVG_FRI_TRYGDEAVGIFT ) then
    exit;

  if ( Ws_Tabellnr = 7700 ) or
     ( Ws_Tabellnr = 7800 ) or
     ( Ws_Tabellnr = 6700 ) or
     ( Ws_Tabellnr = 6800 ) or
     ( Tabelltype = TABTYPE_PENSJON ) then
  begin

    if ( Aars_Inntekt > LAV_GRENSE_TRYGDEAVGIFT ) then
       Trygde_Avgift := ( Aars_Inntekt * LAV_TRYGDEAVG_PROSENT ) / 100.0
    else
       Trygde_Avgift := ( Aars_Inntekt - AVG_FRI_TRYGDEAVGIFT ) * TRYGDE_PROSENT / 100.0;

  end
  else
  begin

    if ( Aars_Inntekt > HOY_GRENSE_TRYGDEAVGIFT ) then
       Trygde_Avgift := ( Aars_Inntekt * HOY_TRYGDEAVG_PROSENT ) / 100.0
    else
       Trygde_Avgift := ( Aars_Inntekt - AVG_FRI_TRYGDEAVGIFT ) * TRYGDE_PROSENT / 100.0;

  end;  { slutt if }

end;  { slutt BeregnFradrag }

Procedure TSkatt2017.BeregnTrinnskatt;
var
  T1, T2, T3, T4     : Extended;
begin

  T1 := 0.0;
  T2 := 0.0;
  T3 := 0.0;
  T4 := 0.0;

  if ( Aars_Inntekt > TRINNSKATT_GRENSE1 ) then
  begin
    if ( Aars_Inntekt < TRINNSKATT_GRENSE2) then
      T1:= ( Aars_Inntekt - TRINNSKATT_GRENSE1 )* TRINNSKATT_PROSENT1 / 100.0
    else
      T1:= ( TRINNSKATT_GRENSE2 - TRINNSKATT_GRENSE1 )* TRINNSKATT_PROSENT1 / 100.0
  end;
  if ( Aars_Inntekt > TRINNSKATT_GRENSE2 ) then
  begin
    if ( Aars_Inntekt < TRINNSKATT_GRENSE3) then
      T2:= ( Aars_Inntekt - TRINNSKATT_GRENSE2 )* TRINNSKATT_PROSENT2 / 100.0
    else
      T2:= ( TRINNSKATT_GRENSE3 - TRINNSKATT_GRENSE2 )* TRINNSKATT_PROSENT2 / 100.0
  end;
  if ( Aars_Inntekt > TRINNSKATT_GRENSE3 ) then
  begin
    if ( Aars_Inntekt < TRINNSKATT_GRENSE4) then
      T3:= ( Aars_Inntekt - TRINNSKATT_GRENSE3 )* TRINNSKATT_PROSENT3 / 100.0
    else
      T3:= ( TRINNSKATT_GRENSE4 - TRINNSKATT_GRENSE3 )* TRINNSKATT_PROSENT3 / 100.0
  end;
  if ( Aars_Inntekt > TRINNSKATT_GRENSE4 ) then
  begin
      T4:= ( Aars_Inntekt - TRINNSKATT_GRENSE4 )* TRINNSKATT_PROSENT4 / 100.0
  end;

  Sum_Trinnskatt:=T1+T2+T3+T4;
end;

Procedure TSkatt2017.BeregnTrekk;
var
  Trekk     : LongInt;
begin

  Trekk := 0;
  Sum_Trekk := Kommune_Skatt + Felles_Skatt + Trygde_Avgift + Sum_Trinnskatt;

  if ( Tabelltype = TABTYPE_SJOMANN ) then
  begin

    if Ant_Trekk_Perioder > 0 then
      Trekk := l2_runde( Sum_Trekk / Ant_Trekk_Perioder ); { 1996 }

  end
  else
  begin

    if Ant_Trekk_Perioder > 0 then
      Trekk := l_runde( Sum_Trekk / Ant_Trekk_Perioder );

  end;  { slutt if-else sjømann }

  if ( Trekk < 0 ) then
    Trekk := 0;

  if ( Trekk > Ws_TrGrl_Avrundet ) then
    Trekk := l_runde(Ws_TrGrl_Avrundet);

  Trekk := Trekk + l2_runde( Overskytende_Trekk );
  Parm_Ut_Trekk := Trekk;

end;  { slutt BeregnTrekk }

Procedure TSkatt2017.BeregnAarsTrekk;
begin

  Sum_Trekk := Kommune_Skatt + Felles_Skatt + Trygde_Avgift + Sum_Trinnskatt +
               (Overskytende_Trekk * Ant_Trekk_Perioder);

end;  { slutt BeregnTrekk }

end.
