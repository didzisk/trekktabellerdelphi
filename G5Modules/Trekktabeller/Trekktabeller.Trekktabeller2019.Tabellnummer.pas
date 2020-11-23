unit Trekktabeller.Trekktabeller2019.Tabellnummer;

interface

uses Trekktabeller.Konstanter, Trekktabeller.Tabelltype, Trekktabeller.Tabellnummer;

function InitializeTabellnummerData2019(TabellNr:integer; Pensjonist:boolean; Konstanter:TKonstanter ):TTabellnummer;

implementation

function InitializeTabellnummerData2019(TabellNr:integer; Pensjonist:boolean; Konstanter:TKonstanter ):TTabellnummer;
var
  NrWithPensjon:integer;
begin
  NrWithPensjon := TabellNr;
  if Pensjonist then
    NrWithPensjon := TabellNr*1000;
  case NrWithPensjon of
  7100:result:=ctr(Tabelltype.VANLIG, 0, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7101:result:=ctr(Tabelltype.VANLIG, 4000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7102:result:=ctr(Tabelltype.VANLIG, 8000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7103:result:=ctr(Tabelltype.VANLIG, 12000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7104:result:=ctr(Tabelltype.VANLIG, 16000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7105:result:=ctr(Tabelltype.VANLIG, 20000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7106:result:=ctr(Tabelltype.VANLIG, 24000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7107:result:=ctr(Tabelltype.VANLIG, 28000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7108:result:=ctr(Tabelltype.VANLIG, 32000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7109:result:=ctr(Tabelltype.VANLIG, 36000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7110:result:=ctr(Tabelltype.VANLIG, 41000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7111:result:=ctr(Tabelltype.VANLIG, 46000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7112:result:=ctr(Tabelltype.VANLIG, 53000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7113:result:=ctr(Tabelltype.VANLIG, 60000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7114:result:=ctr(Tabelltype.VANLIG, 70000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7115:result:=ctr(Tabelltype.VANLIG, 80000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7116:result:=ctr(Tabelltype.VANLIG, 90000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7117:result:=ctr(Tabelltype.VANLIG, 100000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7118:result:=ctr(Tabelltype.VANLIG, 110000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7119:result:=ctr(Tabelltype.VANLIG, 120000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7120:result:=ctr(Tabelltype.VANLIG, -4000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7121:result:=ctr(Tabelltype.VANLIG, -8000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7122:result:=ctr(Tabelltype.VANLIG, -12000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7123:result:=ctr(Tabelltype.VANLIG, -16000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7124:result:=ctr(Tabelltype.VANLIG, -20000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7125:result:=ctr(Tabelltype.VANLIG, -24000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7126:result:=ctr(Tabelltype.VANLIG, -28000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7127:result:=ctr(Tabelltype.VANLIG, -32000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7128:result:=ctr(Tabelltype.VANLIG, -36000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7129:result:=ctr(Tabelltype.VANLIG, -41000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7130:result:=ctr(Tabelltype.VANLIG, -46000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7131:result:=ctr(Tabelltype.VANLIG, -53000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7132:result:=ctr(Tabelltype.VANLIG, -60000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7133:result:=ctr(Tabelltype.VANLIG, -67000, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);

  7200:result:=ctr(Tabelltype.VANLIG, 0, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7201:result:=ctr(Tabelltype.VANLIG, 4000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7202:result:=ctr(Tabelltype.VANLIG, 8000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7203:result:=ctr(Tabelltype.VANLIG, 12000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7204:result:=ctr(Tabelltype.VANLIG, 16000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7205:result:=ctr(Tabelltype.VANLIG, 20000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7206:result:=ctr(Tabelltype.VANLIG, 24000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7207:result:=ctr(Tabelltype.VANLIG, 28000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7208:result:=ctr(Tabelltype.VANLIG, 32000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7209:result:=ctr(Tabelltype.VANLIG, 36000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7210:result:=ctr(Tabelltype.VANLIG, 41000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7211:result:=ctr(Tabelltype.VANLIG, 46000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7212:result:=ctr(Tabelltype.VANLIG, 53000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7213:result:=ctr(Tabelltype.VANLIG, 60000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7214:result:=ctr(Tabelltype.VANLIG, 70000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7215:result:=ctr(Tabelltype.VANLIG, 80000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7216:result:=ctr(Tabelltype.VANLIG, 90000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7217:result:=ctr(Tabelltype.VANLIG, 100000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7218:result:=ctr(Tabelltype.VANLIG, 110000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7219:result:=ctr(Tabelltype.VANLIG, 120000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7220:result:=ctr(Tabelltype.VANLIG, -4000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7221:result:=ctr(Tabelltype.VANLIG, -8000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7222:result:=ctr(Tabelltype.VANLIG, -12000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7223:result:=ctr(Tabelltype.VANLIG, -16000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7224:result:=ctr(Tabelltype.VANLIG, -20000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7225:result:=ctr(Tabelltype.VANLIG, -24000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7226:result:=ctr(Tabelltype.VANLIG, -28000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7227:result:=ctr(Tabelltype.VANLIG, -32000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7228:result:=ctr(Tabelltype.VANLIG, -36000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7229:result:=ctr(Tabelltype.VANLIG, -41000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7230:result:=ctr(Tabelltype.VANLIG, -46000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7231:result:=ctr(Tabelltype.VANLIG, -53000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7232:result:=ctr(Tabelltype.VANLIG, -60000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);
  7233:result:=ctr(Tabelltype.VANLIG, -67000, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_VANLIG);

(*Disse ligger i Java med numre som 7100P etc. Trikset tillater fortsatt bruk av CASE i Delphi*)
  7100000:result:=ctr(Tabelltype.PENSJONIST, 0, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7101000:result:=ctr(Tabelltype.PENSJONIST, 4000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7102000:result:=ctr(Tabelltype.PENSJONIST, 8000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7103000:result:=ctr(Tabelltype.PENSJONIST, 12000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7104000:result:=ctr(Tabelltype.PENSJONIST, 16000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7105000:result:=ctr(Tabelltype.PENSJONIST, 20000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7106000:result:=ctr(Tabelltype.PENSJONIST, 24000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7107000:result:=ctr(Tabelltype.PENSJONIST, 28000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7108000:result:=ctr(Tabelltype.PENSJONIST, 32000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7109000:result:=ctr(Tabelltype.PENSJONIST, 36000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7110000:result:=ctr(Tabelltype.PENSJONIST, 41000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7111000:result:=ctr(Tabelltype.PENSJONIST, 46000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7112000:result:=ctr(Tabelltype.PENSJONIST, 53000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7113000:result:=ctr(Tabelltype.PENSJONIST, 60000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7114000:result:=ctr(Tabelltype.PENSJONIST, 70000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7115000:result:=ctr(Tabelltype.PENSJONIST, 80000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7116000:result:=ctr(Tabelltype.PENSJONIST, 90000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7117000:result:=ctr(Tabelltype.PENSJONIST, 100000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7118000:result:=ctr(Tabelltype.PENSJONIST, 110000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7119000:result:=ctr(Tabelltype.PENSJONIST, 120000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7120000:result:=ctr(Tabelltype.PENSJONIST, -4000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7121000:result:=ctr(Tabelltype.PENSJONIST, -8000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7122000:result:=ctr(Tabelltype.PENSJONIST, -12000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7123000:result:=ctr(Tabelltype.PENSJONIST, -16000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7124000:result:=ctr(Tabelltype.PENSJONIST, -20000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7125000:result:=ctr(Tabelltype.PENSJONIST, -24000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7126000:result:=ctr(Tabelltype.PENSJONIST, -28000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7127000:result:=ctr(Tabelltype.PENSJONIST, -32000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7128000:result:=ctr(Tabelltype.PENSJONIST, -36000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7129000:result:=ctr(Tabelltype.PENSJONIST, -41000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7130000:result:=ctr(Tabelltype.PENSJONIST, -46000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7131000:result:=ctr(Tabelltype.PENSJONIST, -53000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7132000:result:=ctr(Tabelltype.PENSJONIST, -60000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7133000:result:=ctr(Tabelltype.PENSJONIST, -67000, Konstanter.KLASSE1_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);

  7200000:result:=ctr(Tabelltype.PENSJONIST, 0, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7201000:result:=ctr(Tabelltype.PENSJONIST, 4000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7202000:result:=ctr(Tabelltype.PENSJONIST, 8000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7203000:result:=ctr(Tabelltype.PENSJONIST, 12000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7204000:result:=ctr(Tabelltype.PENSJONIST, 16000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7205000:result:=ctr(Tabelltype.PENSJONIST, 20000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7206000:result:=ctr(Tabelltype.PENSJONIST, 24000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7207000:result:=ctr(Tabelltype.PENSJONIST, 28000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7208000:result:=ctr(Tabelltype.PENSJONIST, 32000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7209000:result:=ctr(Tabelltype.PENSJONIST, 36000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7210000:result:=ctr(Tabelltype.PENSJONIST, 41000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7211000:result:=ctr(Tabelltype.PENSJONIST, 46000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7212000:result:=ctr(Tabelltype.PENSJONIST, 53000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7213000:result:=ctr(Tabelltype.PENSJONIST, 60000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7214000:result:=ctr(Tabelltype.PENSJONIST, 70000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7215000:result:=ctr(Tabelltype.PENSJONIST, 80000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7216000:result:=ctr(Tabelltype.PENSJONIST, 90000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7217000:result:=ctr(Tabelltype.PENSJONIST, 100000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7218000:result:=ctr(Tabelltype.PENSJONIST, 110000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7219000:result:=ctr(Tabelltype.PENSJONIST, 120000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7220000:result:=ctr(Tabelltype.PENSJONIST, -4000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7221000:result:=ctr(Tabelltype.PENSJONIST, -8000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7222000:result:=ctr(Tabelltype.PENSJONIST, -12000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7223000:result:=ctr(Tabelltype.PENSJONIST, -16000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7224000:result:=ctr(Tabelltype.PENSJONIST, -20000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7225000:result:=ctr(Tabelltype.PENSJONIST, -24000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7226000:result:=ctr(Tabelltype.PENSJONIST, -28000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7227000:result:=ctr(Tabelltype.PENSJONIST, -32000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7228000:result:=ctr(Tabelltype.PENSJONIST, -36000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7229000:result:=ctr(Tabelltype.PENSJONIST, -41000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7230000:result:=ctr(Tabelltype.PENSJONIST, -46000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7231000:result:=ctr(Tabelltype.PENSJONIST, -53000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7232000:result:=ctr(Tabelltype.PENSJONIST, -60000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);
  7233000:result:=ctr(Tabelltype.PENSJONIST, -67000, Konstanter.KLASSE2_VANLIG, 'Lav', false, Konstanter.OVERSKYTENDE_PROSENT_PENSJONIST);

  7300:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE1_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_7300);
  7400:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE2_VANLIG, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_7300);
  7350:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE1_VANLIG, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_7350);
  7450:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE2_VANLIG, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_7350);
  7500:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE1_VANLIG, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_7500);
  7600:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE2_VANLIG, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_7500);
  7550:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE1_VANLIG, 'Ingen', false, Konstanter.OVERSKYTENDE_PROSENT_7550);
  7650:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE2_VANLIG, 'Ingen', false, Konstanter.OVERSKYTENDE_PROSENT_7550);
  7700:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE1_VANLIG, 'Lav', true, Konstanter.OVERSKYTENDE_PROSENT_7700);
  7800:result:=ctr(Tabelltype.STANDARDFRADRAG, 0, Konstanter.KLASSE2_VANLIG, 'Lav', true, Konstanter.OVERSKYTENDE_PROSENT_7700);

  6300:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE1_FINNMARK, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_6300);
  6400:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE2_FINNMARK, 'Høy', false, Konstanter.OVERSKYTENDE_PROSENT_6300);
  6350:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE1_FINNMARK, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_6350);
  6450:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE2_FINNMARK, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_6350);
  6500:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE1_FINNMARK, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_6500);
  6600:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE2_FINNMARK, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_6500);
  6550:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE1_FINNMARK, 'Ingen', false, Konstanter.OVERSKYTENDE_PROSENT_6550);
  6650:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE2_FINNMARK, 'Ingen', false, Konstanter.OVERSKYTENDE_PROSENT_6550);
  6700:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE1_FINNMARK, 'Lav', true, Konstanter.OVERSKYTENDE_PROSENT_6700);
  6800:result:=ctr(Tabelltype.FINNMARK, 0, Konstanter.KLASSE2_FINNMARK, 'Lav', true, Konstanter.OVERSKYTENDE_PROSENT_6700);

  0100:result:=ctr(Tabelltype.SJO, 0, Konstanter.KLASSE1_VANLIG, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_0100);
  0200:result:=ctr(Tabelltype.SJO, 0, Konstanter.KLASSE2_VANLIG, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_0100);
  0101:result:=ctr(Tabelltype.SJO, 0, Konstanter.KLASSE1_VANLIG, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_0101);
  0201:result:=ctr(Tabelltype.SJO, 0, Konstanter.KLASSE2_VANLIG, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_0101);

  7150:result:=ctr(Tabelltype.SPESIAL, 0, Konstanter.KLASSE1_VANLIG, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_7150);
  7250:result:=ctr(Tabelltype.SPESIAL, 0, Konstanter.KLASSE2_VANLIG, 'Høy', true, Konstanter.OVERSKYTENDE_PROSENT_7150);
  7160:result:=ctr(Tabelltype.SPESIAL, 0, Konstanter.KLASSE1_VANLIG, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_7160);
  7260:result:=ctr(Tabelltype.SPESIAL, 0, Konstanter.KLASSE2_VANLIG, 'Ingen', true, Konstanter.OVERSKYTENDE_PROSENT_7160);
  7170:result:=ctr(Tabelltype.SPESIAL, 0, Konstanter.KLASSE1_VANLIG, 'Ingen', false, Konstanter.OVERSKYTENDE_PROSENT_7170);
  7270:result:=ctr(Tabelltype.SPESIAL, 0, Konstanter.KLASSE2_VANLIG, 'Ingen', false, Konstanter.OVERSKYTENDE_PROSENT_7170);
  end;
end;

end.
