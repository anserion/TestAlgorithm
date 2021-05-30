program Test;

uses
  Forms,
  Unit1 in 'Unit1.pas' {TestForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TTestForm, TestForm);
  Application.Run;
end.
