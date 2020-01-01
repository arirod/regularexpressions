program regularexpressions_app;

{$mode objfpc}{$H+}

uses  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  { you can add units after this }
  indylaz,                      { adicionar IndLaz no Project Inspector }
  er.view.regexform,
  er.model.concretephotos,
  er.model.abstractphotos;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TRegularExpressionsForm, RegularExpressionsForm);
  Application.Run;
end.



