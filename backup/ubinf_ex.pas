unit ubinf_ex;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  bf:file;
  a,b:array of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var k,i:integer;
begin
  setlength(a,Memo1.Lines.Count);
  for i:=0 to high(a) do
  begin
    a[i]:=strtoint(memo1.lines[i]);
  end;

  assignfile(bf,'data.bnf');
  rewrite(bf,1);

  for i:=0 to high(a) do
  begin
    BlockWrite(bf,a[i],SizeOf(integer));
  end;

  closefile(bf);

  assignfile(bf,'data.bnf');
  reset(bf,1);

  while not eof(bf) do
  begin
    BlockRead(bf,k,sizeof(integer));
    setlength(b,length(b)+1);
    b[high(b)]:=k;
  end;

  closefile(bf);

  Memo2.Clear;
  for i:=0 to high(b) do
  begin
    memo2.lines.add(inttostr(b[i]));
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var dudename,dudesurname:string;
    dudeage:integer;

    i,dns,dss:integer;
    c:char;

begin

  dudename   :=edit1.Text;
  dudesurname:=edit2.Text;
  dudeage    :=strtoint(edit3.text);

  assignfile(bf,'dude.bnf');
  rewrite(bf,1);

  dns:=length(dudename);
  dss:=length(dudesurname);

  BlockWrite(bf,dns,sizeof(integer));

  for i:=1 to length(dudename) do
  begin
    c:=dudename[i];
    BlockWrite(bf,c,sizeof(char));
  end;

  BlockWrite(bf,dss,sizeof(integer));

  for i:=1 to length(dudesurname) do
  begin
    c:=dudesurname[i];
    BlockWrite(bf,c,sizeof(char));
  end;

  BlockWrite(bf,dudeage,sizeof(integer));

  closefile(bf);

end;

procedure TForm1.Button3Click(Sender: TObject);
var dudename,dudesurname:string;
    dudeage:integer;
    c:char;

    i,dns,dss:integer;
begin

  dns:=0; dss:=0;

  assignfile(bf,'dude.bnf');
  reset(bf,1);

  BlockRead(bf,dns,sizeof(integer));

  dudename:='';
  for i:=0 to dns-1 do
  begin
    BlockRead(bf,c,sizeof(char));
    dudename:=dudename+c;
  end;

  dudesurname:='';
  for i:=0 to dss-1 do
  begin
    BlockRead(bf,c,sizeof(char));
    dudesurname:=dudesurname+c;
  end;

  BlockRead(bf,dudeage,sizeof(integer));

  closefile(bf);

  edit1.text:=dudename;
  edit2.text:=dudesurname;
  edit3.text:=inttostr(dudeage);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  edit1.Text:='';
  edit2.Text:='';
  edit3.Text:='';
end;

end.

