unit Trekktabeller.Konstanter;

interface

  type TKonstanter = record
    KLASSE1_VANLIG : integer;
    KLASSE2_VANLIG : integer; // Todo: Remove in 2020
    KLASSE1_FINNMARK : integer;
    KLASSE2_FINNMARK : integer; // Todo: Remove in 2020
    TRINN1 : integer;
    TRINN2 : integer;
    TRINN3 : integer;
    TRINN4 : integer;
    AVG_FRI_TRYGDEAVGIFT : integer;
    MAX_STFRADRAG : integer;
    MIN_ANV_MINSTE_FRADRAG : integer;
    MAX_ANV_MINSTE_FRADRAG : integer;
    MAX_ANV_MINSTE_FRADRAG_PENSJ : integer;
    MIN_MINSTE_FRADRAG : integer;
    MAX_MINSTE_FRADRAG : integer;
    LONNSFRADRAG : integer;
    ANV_LONNSFRADRAG : integer;
    MAX_SJO_FRADRAG : integer;

    PROSENT_TRINN1 : double;
    PROSENT_TRINN2 : double;
    PROSENT_TRINN3 : double;
    PROSENT_TRINN3_FINNMARK : double;
    PROSENT_TRINN4 : double;
    FELLES_SKATT_VANLIG : double;
    FELLES_SKATT_FINNMARK : double;
    SKATTORE : double;
    TRYGDE_PROSENT : double;
    LAV_TRYGDEAVG_PROSENT : double;
    HOY_TRYGDEAVG_PROSENT : double;
    ANV_MINSTE_FRAD_PROSENT : double;
    ANV_MINSTE_FRAD_PROSENT_PENSJ : double;
    MINSTE_FRAD_PROSENT : double;
    STFRADRAG_PROSENT : double;
    SJO_PROSENT : double;

    LAV_GRENSE_TRYGDEAVGIFT : integer;
    HOY_GRENSE_TRYGDEAVGIFT : integer;

    OVERSKYTENDE_PROSENT_VANLIG : integer;
    OVERSKYTENDE_PROSENT_PENSJONIST : integer;
    OVERSKYTENDE_PROSENT_7300 : integer;
    OVERSKYTENDE_PROSENT_7350 : integer;
    OVERSKYTENDE_PROSENT_7500 : integer;
    OVERSKYTENDE_PROSENT_7550 : integer;
    OVERSKYTENDE_PROSENT_7700 : integer;
    OVERSKYTENDE_PROSENT_0100 : integer;
    OVERSKYTENDE_PROSENT_0101 : integer;
    OVERSKYTENDE_PROSENT_6300 : integer;
    OVERSKYTENDE_PROSENT_6350 : integer;
    OVERSKYTENDE_PROSENT_6500 : integer;
    OVERSKYTENDE_PROSENT_6550 : integer;
    OVERSKYTENDE_PROSENT_6700 : integer;
    OVERSKYTENDE_PROSENT_7150 : integer;
    OVERSKYTENDE_PROSENT_7160 : integer;
    OVERSKYTENDE_PROSENT_7170 : integer;
  end;

implementation

end.
