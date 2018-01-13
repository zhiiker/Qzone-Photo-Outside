{

    Author: Y.A.K.E
    License : MIT
    Date : 2018/01/13

}

unit Help;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects;

type
  THelp_Form = class(TForm)
    Text1: TText;
    ImageControl1: TImageControl;
    Text2: TText;
    Text3: TText;
    ImageControl2: TImageControl;
    Text4: TText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Help_Form: THelp_Form;

implementation

{$R *.fmx}

procedure THelp_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//Action := TCloseAction.caFree;
end;

end.
