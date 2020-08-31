unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  PParticle = ^TParticle;
  TParticle = record
    x,y:double;
    ttl:integer;
    rad:Word;
    dir_x,dir_y:Real;
  end;
  TForm1 = class(TForm)
    tmr1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure tmr1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Particles:TList;
    OldCoord:TPoint;
    BackBuffer:TBitmap;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Form1.Close;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
 var par:PParticle;L:Real;
 begin
 if ssLeft in Shift then
 if (OldCoord.X<>OldCoord.Y) and (OldCoord.X<>0) then
   begin
    GetMem(par, SizeOf(par^));
    par.x:=x;
    par.y:=y;
    par.ttl:=150;
    par.rad:=random(100);
    L:=Sqrt(sqr(x-OldCoord.x)+sqr(y-OldCoord.y));
    if L<>0 then
    Begin
      par.dir_x:=(x-OldCoord.x)/L;
      par.dir_y:=(y-OldCoord.y)/L;
    End;
    Particles.Add(par);
    OldCoord.x:=x;
    OldCoord.y:=y;
   end else begin
              OldCoord.x:=x;
              OldCoord.y:=y;
            end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
Particles:=TList.Create;
BackBuffer:=TBitmap.Create;
BackBuffer.Width:=1280;
BackBuffer.Height:=1024;
BackBuffer.Canvas.Brush.Color:=clBlack;
BackBuffer.Canvas.Pen.Color:=clLime;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
 var i:Word;Par:PParticle;
begin
 if Particles.Count>0 then Begin
 i:=0;
 BackBuffer.Canvas.Brush.Color:=clBlack;
 BackBuffer.Canvas.FillRect(Rect(0,0,clientwidth,clientheight));
 repeat
    Par:=Particles[i];
    BackBuffer.Canvas.Brush.Color:=RGB(par.ttl,par.ttl,par.ttl);
    BackBuffer.Canvas.Pen.Color:=RGB(par.ttl,par.ttl,par.ttl);
    Par.ttl:=Par.ttl-1;
    Backbuffer.Canvas.Ellipse(round(Par.x)-(150-par.ttl) div 2,round(Par.y)-(150-par.ttl) div 2,round(Par.x)+(150-par.ttl) div 2,round(Par.y)+(150-par.ttl) div 2);
    Par.x:=Par.x+par.dir_x;
    Par.y:=Par.y+par.dir_y;
    if Par.ttl<=0 then Particles.Delete(i) else Inc(i);
 until i>Particles.count-1;
 form1.Canvas.Draw(0,0,backbuffer);
 End;
end;

end.
