unit Trekktabeller.Trekktabeller2018.Periode;

interface

uses Trekktabeller.Periode, Trekktabeller.Tabellnummer;

function initializePeriodeData(per:Periode; aTabell:TTabellnummer):PeriodeData;

implementation

function initializePeriodeData(per:Periode; aTabell:TTabellnummer):PeriodeData;
begin
    case per of
        Periode.PERIODE_1_MAANED: result := cpr (aTabell, 12.12, 10.5,               12.0, 11.0,              12.0, 10.5, 100, 99800 );
        Periode.PERIODE_14_DAGER: result := cpr (aTabell, 26.26, 23.0,               26.0, 24.0,              26.0, 23.0,   50, 46000 );
        Periode.PERIODE_1_UKE   : result := cpr (aTabell, 52.52, 46.0,               52.0, 48.0,              52.0, 46.0,   20, 23000 );
        Periode.PERIODE_4_DAGER : result := cpr (aTabell, 60.60, (60.0*46.0)/52.0,   91.0, (91.0*11.0)/12.0,   91.0, (91.0*10.5)/12.0, 20, 19900 );
        Periode.PERIODE_3_DAGER : result := cpr (aTabell, 80.80, (80.0*46.0)/52.0,  122.0, (122.0*11.0)/12.0, 122.0, (122.0*10.5)/12., 20, 14900 );
        Periode.PERIODE_2_DAGER: result := cpr (aTabell, 121.20, (120.0*46.0)/52.0, 183.0, (183.0*11.0)/12.0, 183.0, (183.0*10.5)/12.0, 20, 9900 );
        Periode.PERIODE_1_DAG  : result := cpr (aTabell, 242.40, (240.0*46.0)/52.0, 365.0, (365.0*11.0)/12.0, 365.0, (365.0*10.5)/12.0, 20, 4900 );
    end;
end;

end.
