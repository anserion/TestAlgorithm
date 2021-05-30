unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  TTestForm = class(TForm)
    AlgoPaint: TPaintBox;
    TimeBar: TProgressBar;
    Label1: TLabel;
    AnswerGroup: TRadioGroup;
    VariantEdit: TEdit;
    Label2: TLabel;
    StartBTN: TButton;
    Label3: TLabel;
    Label4: TLabel;
    ResProc: TEdit;
    ResTXT: TEdit;
    Label5: TLabel;
    Timer1: TTimer;
    NextBTN: TBitBtn;
    Label6: TLabel;
    Q_Num_LBL: TLabel;
    TimeLBL: TLabel;
    Label7: TLabel;
    OK_ans_LBL: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure StartBTNClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NextBTNClick(Sender: TObject);
  private
    { Private declarations }
    CurTime: LongInt;
    variant: LongInt;
    result: LongInt;
    Q_num:LongInt;
    Max_q_num:LongInt;
    Max_time:LongInt;
    OK_answers:LongInt;
    Q_data:array[1..100]of LongInt;
    Good_answers, Real_answers:array [0..10]of LongInt;
    Answer: array[1..10] of TRadioButton;
    procedure Generate_Q_data;
    procedure ShowQuestion;
    procedure ShowAnswers;
    procedure ClearQuestion;
    procedure ShowResult;
    procedure BlockTest;
    procedure UnBlockTest;
    procedure AnswersControl;
    procedure GenerateAnswers;
    procedure AnswerClick(sender: tobject);
    //======================================
    procedure Arrow(x1,y1,x2,y2:LongInt);
    procedure ContStruct(x,y,dx,dy:LongInt; str:string);
    procedure IfStruct(x,y,dx,dy:LongInt; str:string);
    procedure ForStruct(x,y,dx,dy:LongInt; str:string);
    procedure EllipseStruct(x,y,dx,dy:LongInt; str:string);
    //======================================
    procedure DrawQ1;
    procedure DrawQ2;
    procedure DrawQ3;
    procedure DrawQ4;
    procedure DrawQ5;
    procedure DrawQ6;
    procedure DrawQ7;
    procedure DrawQ8;
    procedure DrawQ9;
    procedure DrawQ10;
    //======================================
    function Alg1:LongInt;
    function Alg2:LongInt;
    function Alg3:LongInt;
    function Alg4:LongInt;
    function Alg5:LongInt;
    function Alg6:LongInt;
    function Alg7:LongInt;
    function Alg8:LongInt;
    function Alg9:LongInt;
    function Alg10:LongInt;
  public
    { Public declarations }
  end;

var
  TestForm: TTestForm;

implementation

{$R *.DFM}

procedure TTestForm.ContStruct(x,y,dx,dy:LongInt; str:string);
var tw:LongInt;
begin
     tw:=AlgoPaint.canvas.TextWidth(str);
     AlgoPaint.canvas.TextOut(x - tw div 2, y - 7, str);
     AlgoPaint.canvas.MoveTo(x - dx div 2, y - dy div 2);
     AlgoPaint.canvas.LineTo(x + dx div 2, y - dy div 2);
     AlgoPaint.canvas.LineTo(x + dx div 2, y + dy div 2);
     AlgoPaint.canvas.LineTo(x - dx div 2, y + dy div 2);
     AlgoPaint.canvas.LineTo(x - dx div 2, y - dy div 2);
end;

procedure TTestForm.IfStruct(x,y,dx,dy:LongInt; str:string);
var tw:LongInt;
begin
     tw:=AlgoPaint.canvas.TextWidth(str);
     AlgoPaint.canvas.TextOut(x - tw div 2, y - 7, str);
     AlgoPaint.canvas.MoveTo(x - dx div 2, y);
     AlgoPaint.canvas.LineTo(x, y - dy div 2);
     AlgoPaint.canvas.LineTo(x + dx div 2, y);
     AlgoPaint.canvas.LineTo(x, y + dy div 2);
     AlgoPaint.canvas.LineTo(x - dx div 2, y);
end;

procedure TTestForm.ForStruct(x,y,dx,dy:LongInt; str:string);
var tw:LongInt;
begin
     tw:=AlgoPaint.canvas.TextWidth(str);
     AlgoPaint.canvas.TextOut(x - tw div 2, y - 7, str);
     AlgoPaint.canvas.MoveTo(x - dx div 2, y);
     AlgoPaint.canvas.LineTo(x - dx div 4, y - dy div 2);
     AlgoPaint.canvas.LineTo(x + dx div 4, y - dy div 2);
     AlgoPaint.canvas.LineTo(x + dx div 2, y);
     AlgoPaint.canvas.LineTo(x + dx div 4, y + dy div 2);
     AlgoPaint.canvas.LineTo(x - dx div 4, y + dy div 2);
     AlgoPaint.canvas.LineTo(x - dx div 2, y);
end;

procedure TTestForm.EllipseStruct(x,y,dx,dy:LongInt; str:string);
var tw:LongInt;
begin
     AlgoPaint.canvas.Ellipse(x - dx div 2, y - dy div 2,x + dx div 2, y + dy div 2);
     tw:=AlgoPaint.canvas.TextWidth(str);
     AlgoPaint.canvas.TextOut(x - tw div 2, y - 7, str);
end;

procedure TTestForm.Arrow(x1,y1,x2,y2:LongInt);
begin
     AlgoPaint.canvas.MoveTo(x1,y1); AlgoPaint.canvas.LineTo(x2,y2);
     if (x1>x2) then
     begin
          AlgoPaint.Canvas.LineTo(x2+3,y2-3);
          AlgoPaint.canvas.MoveTo(x2,y2);
          AlgoPaint.Canvas.LineTo(x2+3,y2+3);
     end;

     if (x1<x2) then
     begin
          AlgoPaint.Canvas.LineTo(x2-3,y2-3);
          AlgoPaint.canvas.MoveTo(x2,y2);
          AlgoPaint.Canvas.LineTo(x2-3,y2+3);
     end;

     if (y1>y2) then
     begin
          AlgoPaint.Canvas.LineTo(x2+3,y2+3);
          AlgoPaint.canvas.MoveTo(x2,y2);
          AlgoPaint.Canvas.LineTo(x2-3,y2+3);
     end;

     if (y1<y2) then
     begin
          AlgoPaint.Canvas.LineTo(x2+3,y2-3);
          AlgoPaint.canvas.MoveTo(x2,y2);
          AlgoPaint.Canvas.LineTo(x2-3,y2-3);
     end;
end;

//=====================================================

function TTestForm.Alg1:LongInt;
var a,b,c:LongInt;
begin
a:=q_data[1]; b:=q_data[2];
c:=a*a+b*b;
Alg1:=c;
end;

procedure TTestForm.DrawQ1;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=80; dy:=25;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a='+IntTostr(q_data[1])+' , b='+IntToStr(q_data[2]));
   arrow(x,y+5*dy2,x,y+6*dy2);
ContStruct(x,y+7*dy2,dx,dy,'c = a*a + b*b');
   arrow(x,y+8*dy2,x,y+9*dy2);
ContStruct(x,y+10*dy2,dx,dy,'Вывод c');
   arrow(x,y+11*dy2,x,y+12*dy2);
EllipseStruct(x,y+13*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg2:LongInt;
var a,b:LongInt;
begin
a:=q_data[11]; b:=q_data[12];
if a>b then Alg2:=a else Alg2:=b;
end;

procedure TTestForm.DrawQ2;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=70; dy:=25;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a='+IntTostr(q_data[11])+' , b='+IntToStr(q_data[12]));
   arrow(x,y+5*dy2,x,y+6*dy2);
IfStruct(x,y+7*dy2,dx,dy,'+    a>b    -');
   arrow(x-dx2,y+7*dy2,x-dx,y+7*dy2);
   arrow(x-dx, y+7*dy2,x-dx,y+8*dy2);
   arrow(x+dx2,y+7*dy2,x+dx,y+7*dy2);
   arrow(x+dx, y+7*dy2,x+dx,y+8*dy2);
   ContStruct(x-dx, y+9*dy2,dx,dy,'вывод a');
   arrow(x-dx, y+10*dy2,x-dx,y+11*dy2);
   arrow(x-dx, y+11*dy2,x,y+11*dy2);
   ContStruct(x+dx, y+9*dy2,dx,dy,'вывод b');
   arrow(x+dx, y+10*dy2,x+dx,y+11*dy2);
   arrow(x+dx, y+11*dy2,x,y+11*dy2);   

   arrow(x,y+11*dy2,x,y+12*dy2);
EllipseStruct(x,y+13*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg3:LongInt;
var a,b,c:LongInt;
begin
a:=q_data[21]; b:=q_data[22]; c:=q_data[23];
if (a>q_data[24])and(b<q_data[25]) then a:=a-c else b:=b+c;
Alg3:=a+b;
end;

procedure TTestForm.DrawQ3;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=85; dy:=25;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a='+IntTostr(q_data[21])+' , b='+IntToStr(q_data[22])+' , c='+IntToStr(q_data[23]));
   arrow(x,y+5*dy2,x,y+6*dy2);
IfStruct(x,y+7*dy2,dx,dy,'+ (a>'+IntToStr(q_data[24])+')и(b<'+IntToStr(q_data[25])+') -');
   arrow(x-dx2,y+7*dy2,x-dx,y+7*dy2);
   arrow(x-dx, y+7*dy2,x-dx,y+8*dy2);
   arrow(x+dx2,y+7*dy2,x+dx,y+7*dy2);
   arrow(x+dx, y+7*dy2,x+dx,y+8*dy2);
ContStruct(x-dx, y+9*dy2,dx,dy,'a=a-c');
   arrow(x-dx, y+10*dy2,x-dx,y+11*dy2);
   arrow(x-dx, y+11*dy2,x,y+11*dy2);
ContStruct(x+dx, y+9*dy2,dx,dy,'b=b+c');
   arrow(x+dx, y+10*dy2,x+dx,y+11*dy2);
   arrow(x+dx, y+11*dy2,x,y+11*dy2);
   arrow(x,y+11*dy2,x,y+12*dy2);
ContStruct(x, y+13*dy2,dx,dy,'вывод a+b');
   arrow(x,y+14*dy2,x,y+15*dy2);
EllipseStruct(x,y+16*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg4:LongInt;
var a,b,n,i:LongInt;
begin
a:=q_data[31]; b:=q_data[32];
n:=q_data[33]; i:=q_data[34];
while i<n do
begin
     a:=a+b;
     i:=i+1;
end;
Alg4:=a;
end;

procedure TTestForm.DrawQ4;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=60; dy:=20;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a='+IntTostr(q_data[31])+' , b='+IntToStr(q_data[32]));
   arrow(x,y+5*dy2,x,y+6*dy2);
ContStruct(x,y+7*dy2,dx,dy,'n='+IntTostr(q_data[33])+' , i='+IntToStr(q_data[34]));
   arrow(x,y+8*dy2,x,y+9*dy2);
IfStruct(x,y+10*dy2,dx,dy,'   i<n   -');
   arrow(x,y+11*dy2,x,y+12*dy2);
ContStruct(x, y+13*dy2,dx,dy,'a=a+b');
   arrow(x,y+14*dy2,x,y+15*dy2);
ContStruct(x, y+16*dy2,dx,dy,'i=i+1');
   arrow(x-dx2,y+16*dy2,x-dx,y+16*dy2);
   arrow(x-dx,y+16*dy2,x-dx,y+9*dy2);
   arrow(x-dx,y+9*dy2,x,y+9*dy2);

   arrow(x+dx2,y+10*dy2,x+dx,y+10*dy2);
   arrow(x+dx,y+10*dy2,x+dx,y+18*dy2);
   arrow(x+dx,y+18*dy2,x,y+18*dy2);
   arrow(x,y+18*dy2,x,y+19*dy2);
ContStruct(x, y+20*dy2,dx,dy,'вывод a');
   arrow(x,y+21*dy2,x,y+22*dy2);
EllipseStruct(x,y+23*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg5:LongInt;
var a,b,i,n:LongInt;
begin
a:=q_data[41]; b:=q_data[42];
n:=q_data[43]; i:=n+q_data[44];
repeat
      b:=a+n-i;
      i:=i-1;
until i<n;
Alg5:=b;
end;

procedure TTestForm.DrawQ5;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=60; dy:=20;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a='+IntTostr(q_data[41])+' , b='+IntToStr(q_data[42]));
   arrow(x,y+5*dy2,x,y+6*dy2);
ContStruct(x,y+7*dy2,dx,dy,'n='+IntTostr(q_data[43])+' , i='+IntToStr(q_data[44]+q_data[44]));
   arrow(x,y+8*dy2,x,y+9*dy2);
ContStruct(x, y+10*dy2,dx,dy,'b=a+n-i');
   arrow(x,y+11*dy2,x,y+12*dy2);
ContStruct(x, y+13*dy2,dx,dy,'i=i-1');
   arrow(x,y+14*dy2,x,y+15*dy2);
IfStruct(x,y+16*dy2,dx,dy,'   i<n   -');
   arrow(x+dx2,y+16*dy2,x+dx,y+16*dy2);
   arrow(x+dx,y+16*dy2,x+dx,y+trunc(8.5*dy2));
   arrow(x+dx,y+trunc(8.5*dy2),x,y+trunc(8.5*dy2));

   arrow(x,y+17*dy2,x,y+18*dy2);
ContStruct(x, y+19*dy2,dx,dy,'вывод b');
   arrow(x,y+20*dy2,x,y+21*dy2);
EllipseStruct(x,y+22*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg6:LongInt;
var a,b,H,i:LongInt;
begin
a:=q_data[51]; b:=q_data[52]; H:=0;
for i:=a to b do H:=H+i;
Alg6:=H;
end;

procedure TTestForm.DrawQ6;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=70; dy:=20;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'H=0');
   arrow(x,y+5*dy2,x,y+6*dy2);
ForStruct(x,y+7*dy2,dx,dy,'i='+IntTostr(q_data[51])+'..'+IntToStr(q_data[52]));
   arrow(x,y+8*dy2,x,y+9*dy2);
ContStruct(x,y+10*dy2,dx,dy,'H=H+i');
   arrow(x-dx2,y+10*dy2,x-dx,y+10*dy2);
   arrow(x-dx,y+10*dy2,x-dx,y+7*dy2);
   arrow(x-dx,y+7*dy2,x-dx2,y+7*dy2);

   arrow(x+dx2,y+7*dy2,x+dx,y+7*dy2);
   arrow(x+dx,y+7*dy2,x+dx,y+12*dy2);
   arrow(x+dx,y+12*dy2,x,y+12*dy2);
   arrow(x,y+12*dy2,x,y+13*dy2);
ContStruct(x, y+14*dy2,dx,dy,'вывод H');
   arrow(x,y+15*dy2,x,y+16*dy2);
EllipseStruct(x,y+17*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg7:LongInt;
var a,b,c:record x,y:LongInt; end;
begin
a.x:=q_data[61]; a.y:=q_data[62];
b.x:=q_data[63]; b.y:=q_data[64];
c.x:=a.x*b.x-a.y*b.y;
c.y:=a.x*b.y+a.y*b.x;
Alg7:=c.x+c.y;
end;

procedure TTestForm.DrawQ7;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=110; dy:=20;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a.x='+IntTostr(q_data[61])+' , a.y='+IntToStr(q_data[62]));
   arrow(x,y+5*dy2,x,y+6*dy2);
ContStruct(x,y+7*dy2,dx,dy,'b.x='+IntTostr(q_data[63])+' , b.y='+IntToStr(q_data[64]));
   arrow(x,y+8*dy2,x,y+9*dy2);
ContStruct(x,y+10*dy2,dx,dy,'c.x = a.x*b.x - a.y*b.y');
   arrow(x,y+11*dy2,x,y+12*dy2);
ContStruct(x,y+13*dy2,dx,dy,'c.y = a.x*b.y + a.y*b.x');
   arrow(x,y+14*dy2,x,y+15*dy2);
ContStruct(x, y+16*dy2,dx,dy,'вывод c.x+c.y');
   arrow(x,y+17*dy2,x,y+18*dy2);
EllipseStruct(x,y+19*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg8:LongInt;
var a:array[1..100] of LongInt; i,n:LongInt;
begin
a[1]:=1; a[2]:=1; n:=q_data[71];
for i:=3 to n do a[i]:=a[i-2]+a[i-1];
Alg8:=a[n];
end;

procedure TTestForm.DrawQ8;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=80; dy:=20;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a[1]=1, a[2]=1');
   arrow(x,y+5*dy2,x,y+6*dy2);
ForStruct(x,y+7*dy2,dx,dy,'i=3..'+IntToStr(q_data[71]));
   arrow(x,y+8*dy2,x,y+9*dy2);
ContStruct(x,y+10*dy2,dx,dy,'a[i]=a[i-2]+a[i-1]');
   arrow(x-dx2,y+10*dy2,x-dx,y+10*dy2);
   arrow(x-dx,y+10*dy2,x-dx,y+7*dy2);
   arrow(x-dx,y+7*dy2,x-dx2,y+7*dy2);

   arrow(x+dx2,y+7*dy2,x+dx,y+7*dy2);
   arrow(x+dx,y+7*dy2,x+dx,y+12*dy2);
   arrow(x+dx,y+12*dy2,x,y+12*dy2);
   arrow(x,y+12*dy2,x,y+13*dy2);
ContStruct(x, y+14*dy2,dx,dy,'вывод a['+IntToStr(q_data[71])+']');
   arrow(x,y+15*dy2,x,y+16*dy2);
EllipseStruct(x,y+17*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg9:LongInt;
var a:array[1..100] of LongInt;
procedure bubble(n:LongInt);
var i,j,h:LongInt;
begin
     for i:=1 to n-1 do
     for j:=i+1 to n do
         if a[i]>a[j] then
         begin
              h:=a[i]; a[i]:=a[j]; a[j]:=h;
         end;
end;
begin
a[1]:=q_data[81]; a[2]:=q_data[82];
a[3]:=q_data[83]; a[4]:=q_data[84];
a[5]:=q_data[85]; a[6]:=q_data[86];
bubble(6);
Alg9:=a[4];
end;

procedure TTestForm.DrawQ9;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=75; dy:=20;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');
x:=AlgoPaint.width div 5;

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a[1]='+IntTostr(q_data[81])+' , a[2]='+IntToStr(q_data[82]));
   arrow(x,y+5*dy2,x,y+6*dy2);
ContStruct(x,y+7*dy2,dx,dy,'a[3]='+IntTostr(q_data[83])+' , a[4]='+IntToStr(q_data[84]));
   arrow(x,y+8*dy2,x,y+9*dy2);
ContStruct(x,y+10*dy2,dx,dy,'a[5]='+IntTostr(q_data[85])+' , a[6]='+IntToStr(q_data[86]));
   arrow(x,y+11*dy2,x,y+12*dy2);
ContStruct(x,y+13*dy2,dx,dy,'bubble(6)');
   arrow(x,y+14*dy2,x,y+15*dy2);
ContStruct(x, y+16*dy2,dx,dy,'вывод a[4]');
   arrow(x,y+17*dy2,x,y+18*dy2);
EllipseStruct(x,y+19*dy2,dx,dy,'Конец');

x:= 2*AlgoPaint.width div 3;
EllipseStruct(x,y+dy2,dx,dy,'bubble(n)');
   arrow(x,y+2*dy2,x,y+3*dy2);
ForStruct(x,y+4*dy2,dx,dy,'i=1..n-1');
   arrow(x,y+5*dy2,x,y+6*dy2);
ForStruct(x,y+7*dy2,dx,dy,'j=i+1..n');
   arrow(x,y+8*dy2,x,y+9*dy2);
IfStruct(x,y+10*dy2,dx,dy,'  a[i]>a[j]  -');
   arrow(x+dx2,y+10*dy2,x+2*dx div 3,y+10*dy2);
   arrow(x,y+11*dy2,x,y+12*dy2);
ContStruct(x,y+13*dy2,dx,dy,'h=a[i]');
   arrow(x,y+14*dy2,x,y+15*dy2);
ContStruct(x,y+16*dy2,dx,dy,'a[i]=a[j]');
   arrow(x,y+17*dy2,x,y+18*dy2);
ContStruct(x,y+19*dy2,dx,dy,'a[j]=h');
   arrow(x+dx2,y+19*dy2,x+2*dx div 3,y+19*dy2);
   arrow(x+2*dx div 3,y+19*dy2,x+2*dx div 3,y+7*dy2);
   arrow(x+2*dx div 3,y+7*dy2,x+dx2,y+7*dy2);
   arrow(x-dx2,y+7*dy2,x- 2*dx div 3,y+7*dy2);
   arrow(x- 2*dx div 3,y+7*dy2,x- 2*dx div 3,y+4*dy2);
   arrow(x- 2*dx div 3,y+4*dy2, x-dx2,y+4*dy2);
   arrow(x+dx2,y+4*dy2, x+dx,y+4*dy2);
   arrow(x+dx,y+4*dy2, x+dx,y+21*dy2);
   arrow(x+dx,y+21*dy2,x,y+21*dy2);

   arrow(x,y+21*dy2,x,y+22*dy2);
EllipseStruct(x,y+23*dy2,dx,dy,'Конец');
end;

//=================================================
function TTestForm.Alg10:LongInt;
var a:array[1..100]of LongInt;
    i,m:LongInt;
begin
a[1]:=q_data[91]; a[2]:=q_data[92];
a[3]:=q_data[93]; a[4]:=q_data[94];
a[5]:=q_data[95]; a[6]:=q_data[96];
m:=a[1];
for i:=2 to 6 do
    if a[i]<m then m:=a[i];
Alg10:=m;
end;

procedure TTestForm.DrawQ10;
var x,y,dx,dy,dx2,dy2:LongInt;
begin
dx:=80; dy:=20;
x:=AlgoPaint.width div 2; y:=dy;
dx2:=dx div 2; dy2:=dy div 2;
ContStruct(x,AlgoPaint.height-dy,200,dy,'Определить выводимое число');

EllipseStruct(x,y+dy2,dx,dy,'Начало');
   arrow(x,y+2*dy2,x,y+3*dy2);
ContStruct(x,y+4*dy2,dx,dy,'a[1]='+IntTostr(q_data[91])+' , a[2]='+IntToStr(q_data[92]));
   arrow(x,y+5*dy2,x,y+6*dy2);
ContStruct(x,y+7*dy2,dx,dy,'a[3]='+IntTostr(q_data[93])+' , a[4]='+IntToStr(q_data[94]));
   arrow(x,y+8*dy2,x,y+9*dy2);
ContStruct(x,y+10*dy2,dx,dy,'a[5]='+IntTostr(q_data[95])+' , a[6]='+IntToStr(q_data[96]));
   arrow(x,y+11*dy2,x,y+12*dy2);
ContStruct(x,y+13*dy2,dx,dy,'m=a[1]');
   arrow(x,y+14*dy2,x,y+15*dy2);
ForStruct(x,y+16*dy2,dx,dy,'i=2..6');
   arrow(x,y+17*dy2,x,y+18*dy2);
IfStruct(x,y+19*dy2,dx,dy,'    a[i]<m    -');
   arrow(x+dx2,y+19*dy2,x+2*dx div 3,y+19*dy2);
   arrow(x,y+20*dy2,x,y+21*dy2);
ContStruct(x,y+22*dy2,dx,dy,'m=a[i]');
   arrow(x+dx2,y+22*dy2,x+2*dx div 3,y+22*dy2);
   arrow(x+2*dx div 3,y+22*dy2,x+2*dx div 3,y+16*dy2);
   arrow(x+2*dx div 3,y+16*dy2,x+dx2,y+16*dy2);
   arrow(x-dx2,y+16*dy2,x-2*dx div 3,y+16*dy2);
   arrow(x-2*dx div 3,y+16*dy2,x-2*dx div 3,y+24*dy2);
   arrow(x-2*dx div 3,y+24*dy2,x,y+24*dy2);

   arrow(x,y+24*dy2,x,y+25*dy2);
ContStruct(x, y+26*dy2,dx,dy,'вывод m');
   arrow(x,y+27*dy2,x,y+28*dy2);
EllipseStruct(x,y+29*dy2,dx,dy,'Конец');
end;

//================================================
procedure TTestForm.Generate_Q_data;
var i:LongInt; rnd_num,alpha,beta,k:extended;
begin
rnd_num:=variant/1000000;
alpha:=Pi;
for i:=1 to 100 do
begin
     //rnd_num:=trunc(rnd_num*100);
     //rnd_num:= rnd_num-trunc(rnd_num/alpha);
     rnd_num:=random;
     Q_data[i]:=trunc(rnd_num*1000000) mod 10 +1;
end;
end;

procedure TTestForm.ShowQuestion;
begin
case Q_num of
1: DrawQ1;
2: DrawQ2;
3: DrawQ3;
4: DrawQ4;
5: DrawQ5;
6: DrawQ6;
7: DrawQ7;
8: DrawQ8;
9: DrawQ9;
10: DrawQ10;
end;
end;

procedure TTestForm.ShowAnswers;
var i,num:LongInt;
begin
for i:=1 to 10 do
begin
     repeat
           num:=random(101)-50;
     until (num<>Alg1)and(num<>Alg2)and(num<>Alg3)and(num<>Alg4)and(num<>Alg5)
        and(num<>Alg6)and(num<>Alg7)and(num<>Alg8)and(num<>Alg9)and(num<>Alg10);
     answer[i].caption:=IntToStr(num);
end;
case Q_num of
1: answer[Good_answers[Q_num]].caption:=IntToStr(Alg1);
2: answer[Good_answers[Q_num]].caption:=IntToStr(Alg2);
3: answer[Good_answers[Q_num]].caption:=IntToStr(Alg3);
4: answer[Good_answers[Q_num]].caption:=IntToStr(Alg4);
5: answer[Good_answers[Q_num]].caption:=IntToStr(Alg5);
6: answer[Good_answers[Q_num]].caption:=IntToStr(Alg6);
7: answer[Good_answers[Q_num]].caption:=IntToStr(Alg7);
8: answer[Good_answers[Q_num]].caption:=IntToStr(Alg8);
9: answer[Good_answers[Q_num]].caption:=IntToStr(Alg9);
10: answer[Good_answers[Q_num]].caption:=IntToStr(Alg10);
end;
end;

//=========================================================

procedure TTestForm.GenerateAnswers;
var i:LongInt; rnd_num,alpha,beta,k:extended;
begin
for i:=1 to max_Q_num do Real_answers[i]:=0;
rnd_num:=variant/1000000;
alpha:=0.3; beta:=0.67; k:=0.44;
for i:=1 to max_Q_num do
    begin
         rnd_num:=k*(power(rnd_num+alpha,beta)+alpha);
         Good_answers[i]:=trunc(rnd_num*1000000) mod 10 +1;
    end;
end;

//=====================================================

procedure TTestForm.AnswerClick(sender: tobject);
var i:LongInt;
begin
for i:=1 to 10 do
    if sender=answer[i] then Real_answers[Q_num]:=i;
end;

procedure TTestForm.AnswersControl;
var i:LongInt;
begin
OK_answers:=0;
for i:=1 to max_Q_num do
     if Good_answers[i]=Real_answers[i] then OK_answers:=OK_answers+1;
end;

procedure TTestForm.ClearQuestion;
var i:LongInt;
begin
     for i:=1 to 100 do q_data[i]:=0;
     for i:=1 to 10 do
     begin
          answer[i].caption:='';
          answer[i].checked:=false;
     end;
     AlgoPaint.Canvas.FillRect(RECT(0,0,AlgoPaint.width,AlgoPaint.height));
end;

procedure TTestForm.BlockTest;
begin
     Timer1.enabled:=false;
     StartBTN.enabled:=true;
     NextBTN.enabled:=false;
end;

procedure TTestForm.UnBlockTest;
begin
     StartBTN.enabled:=false;
     NextBTN.enabled:=true;
end;

procedure TTestForm.ShowResult;
begin
AnswersControl; OK_ans_LBL.caption:=IntToStr(OK_answers);
result:=round(OK_answers/Max_q_num*100);
ResProc.text:=IntToStr(result);
if result<60 then ResTXT.text:='не зачтено' else ResTXT.text:='зачтено'
end;

procedure TTestForm.Timer1Timer(Sender: TObject);
begin
CurTime:=CurTime+1;
TimeBar.position:=trunc(CurTime/(60*Max_time)*100);
TimeLBL.Caption:=IntToStr(CurTime div 60)+' : '+IntToStr(CurTime mod 60);
if (CurTime div 60)>Max_time then
begin
     BlockTest;
     ShowResult;
end;
end;

procedure TTestForm.StartBTNClick(Sender: TObject);
begin
variant:=random(1000000);
VariantEdit.text:=IntToStr(variant);
ResProc.text:=''; ResTXT.text:='';
NextBTN.caption:='Следующий вопрос';

OK_answers:=0; Q_Num:=0; Max_q_num:=10; Max_time:=20;
GenerateAnswers; result:=0;
UnBlockTest;
CurTime:=0; Timer1.enabled:=true;
NextBTNClick(self);
end;

procedure TTestForm.FormCreate(Sender: TObject);
var i:LongInt;
begin
Randomize;
for i:=1 to 10 do
begin
     answer[i]:=TRadioButton.Create(AnswerGroup);
     answer[i].Parent:=AnswerGroup;
     answer[i].left:=10; answer[i].top:=20+i*30;
     answer[i].width:=70; answer[i].height:=20;
     answer[i].OnClick:=AnswerClick;
end;
BlockTest;
end;

procedure TTestForm.NextBTNClick(Sender: TObject);
begin
if Q_num<Max_q_num then
begin
     AnswersControl; OK_ans_LBL.caption:=IntToStr(OK_answers);
     Q_num:=Q_num+1;
     if Q_num=Max_q_num then NextBTN.caption:='Показать результат теста';
     Q_num_LBL.caption:=IntToStr(Q_num);
     ClearQuestion;
     Generate_Q_data;
     ShowQuestion;
     ShowAnswers;
end
   else
begin
     BlockTest;
     ShowResult;
end;
end;

end.
