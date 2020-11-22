unit Trekktabeller.Trekktabeller2018.Konstanter;

interface

uses Trekktabeller.Utils, Trekktabeller.Konstanter;

function InitializeKonstanter2018:TKonstanter;

implementation

function InitializeKonstanter2018:TKonstanter;
begin
  with result do
  begin
    KLASSE1_VANLIG := 54750;
    KLASSE2_VANLIG := 54750;
    KLASSE1_FINNMARK := 70250;
    KLASSE2_FINNMARK := 70250;
    TRINN1 := 168900;
    TRINN2 := 237900;
    TRINN3 := 598050;
    TRINN4 := 962050;
    AVG_FRI_TRYGDEAVGIFT := 54650;
    MAX_STFRADRAG := 40000;
    MIN_ANV_MINSTE_FRADRAG := 3520;
    MAX_ANV_MINSTE_FRADRAG := 85897;
    MAX_ANV_MINSTE_FRADRAG_PENSJ := 73040;
    MIN_MINSTE_FRADRAG := 4000;
    MAX_MINSTE_FRADRAG := 97610;
    LONNSFRADRAG := 31800;
    ANV_LONNSFRADRAG := 27984;
    MAX_SJO_FRADRAG := 80000;

    PROSENT_TRINN1 := 1.4;
    PROSENT_TRINN2 := 3.3;
    TRINNSKATT_PROSENT3 := 12.4;
    TRINNSKATT_PROSENT3_FINNMARK := 10.4;
    PROSENT_TRINN4 := 15.4;
    FELLES_SKATT_VANLIG := 8.55;
    FELLES_SKATT_FINNMARK := 5.05;
    SKATTORE := 14.45;
    TRYGDE_PROSENT := 25;
    LAV_TRYGDEAVG_PROSENT := 5.1;
    HOY_TRYGDEAVG_PROSENT := 8.2;
    ANV_MINSTE_FRAD_PROSENT := 39.6;
    ANV_MINSTE_FRAD_PROSENT_PENSJ := 27.28;
    MINSTE_FRAD_PROSENT := 45.0;
    STFRADRAG_PROSENT := 10;
    SJO_PROSENT := 30;

    LAV_GRENSE_TRYGDEAVGIFT := Trunc(RoundAwayFromZero((AVG_FRI_TRYGDEAVGIFT * TRYGDE_PROSENT)/(TRYGDE_PROSENT - LAV_TRYGDEAVG_PROSENT)));
    HOY_GRENSE_TRYGDEAVGIFT := Trunc(RoundAwayFromZero((AVG_FRI_TRYGDEAVGIFT * TRYGDE_PROSENT)/(TRYGDE_PROSENT - HOY_TRYGDEAVG_PROSENT)));


    OVERSKYTENDE_PROSENT_VANLIG := 54;
    OVERSKYTENDE_PROSENT_PENSJONIST := 48;
    OVERSKYTENDE_PROSENT_7300_7400 := 54;
    OVERSKYTENDE_PROSENT_7350_7450 := 47;
    OVERSKYTENDE_PROSENT_7500_7600 := 39;
    OVERSKYTENDE_PROSENT_7550_7650 := 44;
    OVERSKYTENDE_PROSENT_7700_7800 := 44;
    OVERSKYTENDE_PROSENT_0100_0200 := 39;
    OVERSKYTENDE_PROSENT_0101_0201 := 47;
    OVERSKYTENDE_PROSENT_6300_6400 := 50;
    OVERSKYTENDE_PROSENT_6350_6450 := 44;
    OVERSKYTENDE_PROSENT_6500_6600 := 35;
    OVERSKYTENDE_PROSENT_6550_6650 := 40;
    OVERSKYTENDE_PROSENT_6700_6800 := 40;
    OVERSKYTENDE_PROSENT_7150_7250 := 47;
    OVERSKYTENDE_PROSENT_7160_7260 := 39;
    OVERSKYTENDE_PROSENT_7170_7270 := 44;
  end;
  end;


end.
