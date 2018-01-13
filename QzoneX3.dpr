program QzoneX3;

uses
  FMX.Forms,
  Main in 'Main.pas' {Main_Form},
  Help in 'Help.pas' {Help_Form},
  Donate in 'Donate.pas' {Donate_Form};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(THelp_Form, Help_Form);
  Application.CreateForm(TDonate_Form, Donate_Form);
  Application.Run;
end.
