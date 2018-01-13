unit Donate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs;

type
  TDonate_Form = class(TForm)
    ImageControl1: TImageControl;
    ImageControl2: TImageControl;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure RadioButton2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Donate_Form: TDonate_Form;

implementation

{$R *.fmx}

procedure TDonate_Form.RadioButton2Change(Sender: TObject);
begin

//
ImageControl2.visible := not ImageControl2.visible;
ImageControl1.visible := not ImageControl1.visible;
end;

end.
