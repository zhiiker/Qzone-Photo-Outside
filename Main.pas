{

    Author: Y.A.K.E
    License : MIT
    Date : 2018/01/13

}
unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Edit, FMX.Layouts,
  FMX.Memo,System.RegularExpressions, FMX.Objects, FMX.StdCtrls, FMX.ScrollBox, FMX.Controls.Presentation,
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows,
{$ENDIF MSWINDOWS}
 {$IFDEF POSIX}
  Posix.SysTypes,
  Posix.Stdlib,
  Posix.UniStd,
  Posix.Signal,
{$IFDEF MACOS}
  Macapi.CoreServices,
{$ENDIF MACOS}
{$IFDEF ANDROID}
  Posix.Fcntl,
{$ENDIF ANDROID}
{$IFDEF LINUX}
  System.SyncObjs,
{$ENDIF LINUX}
{$ENDIF POSIX}
  FMX.ExtCtrls;


type
  TMain_Form = class(TForm)
    StyleBook1: TStyleBook;
    Label1: TLabel;
    Edit_old_src: TEdit;
    Button_input: TButton;
    GroupBox1: TGroupBox;
    RadioButton_src: TRadioButton;
    RadioButton_HTML: TRadioButton;
    GroupBox2: TGroupBox;
    CheckBox_https: TCheckBox;
    GroupBox3: TGroupBox;
    Edit_addClass: TEdit;
    CheckBox_addClass: TCheckBox;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    CheckBox_addAlt: TCheckBox;
    Edit_addAlt: TEdit;
    Memo_out: TMemo;
    Label3: TLabel;
    Button_copy: TButton;
    CheckBox_autoCopy: TCheckBox;
    Button1: TButton;
    Text1: TText;
    Text2: TText;
    Err_Tips: TText;
    procedure FormCreate(Sender: TObject);
    procedure Button_inputClick(Sender: TObject);
    procedure Button_copyClick(Sender: TObject);
    procedure Edit_old_srcChangeTracking(Sender: TObject);
    procedure RadioButton_HTMLChange(Sender: TObject);
    procedure Edit_addClassChangeTracking(Sender: TObject);
    procedure Edit_addAltChangeTracking(Sender: TObject);
    procedure Memo_outChangeTracking(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
  private
    { Private declarations }

    procedure Test_URL;
    procedure get_Code;
  public
    { Public declarations }
  end;

var
  Main_Form: TMain_Form;
  newurl :string;  //ͼƬ��ַ

const
pattern = 'http\w?:\/\/.*?/ps(\w)\?\/(.*?)\/(.*?)\/\w\/(.*?)$' ;
pattern2 = 'http\w?:\/\/.*?/psc\?\/(.*?)$' ;

implementation

uses
Help,Donate;

{$R *.fmx}

procedure TMain_Form.Button_inputClick(Sender: TObject);
begin
//ճ��
  Edit_old_src.text:='';
  Edit_old_src.PasteFromClipboard;
end;




procedure TMain_Form.Button1Click(Sender: TObject);
begin
  Donate_Form.Show;
end;

procedure TMain_Form.Button_copyClick(Sender: TObject);
begin
    Memo_out.SelectAll;
    Memo_out.CopyToClipboard;
    Memo_out.SetFocus;
end;

procedure TMain_Form.Edit_old_srcChangeTracking(Sender: TObject);
begin
   Test_URL;
end;




procedure TMain_Form.Edit_addClassChangeTracking(Sender: TObject);
begin
  if RadioButton_HTML.IsChecked then get_Code;
end;

procedure TMain_Form.Edit_addAltChangeTracking(Sender: TObject);
begin
  if RadioButton_HTML.IsChecked then get_Code;
end;

procedure TMain_Form.FormCreate(Sender: TObject);
begin
//
end;

//���봦��
procedure TMain_Form.get_Code;
var
  out_html:string;
  out_img_url :string;
const
htmlcode = '<img src="#IMGSRCURL#" class="#ADDCLASS#" alt="#ADDALT#" >';

begin
    if Length(newurl) <= 10 then  exit;  //��ַ���Ȳ��Բ�����

    //����ӦЭ�� ����
    out_img_url := newurl;
    if not CheckBox_https.IsChecked then out_img_url :=  'https:' +  out_img_url;

    // ��ַ����HTML����ģʽ
    if RadioButton_src.IsChecked then
      begin
       //ֱ�ӵ�ַģʽ
        Memo_out.Text:= out_img_url;
      end
       else
        begin
        //HTMLģʽ
          //url ����
          out_html:=StringReplace (htmlcode, '#IMGSRCURL#', out_img_url, []);

          //Class ����
          if CheckBox_addClass.IsChecked then
            begin
               out_html:=StringReplace (out_html, '#ADDCLASS#', Edit_addClass.Text, []);
            end else
              begin
                 out_html:=StringReplace (out_html, 'class="#ADDCLASS#"', '', []);
              end;

          //ALT ����
          if CheckBox_addAlt.IsChecked then
            begin
               out_html:=StringReplace (out_html, '#ADDALT#', Edit_addAlt.Text, []);
            end else
              begin
                 out_html:=StringReplace (out_html, 'alt="#ADDALT#"', '', []);
              end;
           Memo_out.Text:= out_html;  //������������ʾ��memo��
        end;


end;

procedure TMain_Form.Label7Click(Sender: TObject);
//var
//ChildForm: TForm1;
begin

  Help_Form.Show;

end;

procedure TMain_Form.Memo_outChangeTracking(Sender: TObject);
begin
//��memo���ݱ䶯ʱ���Զ�����
 if CheckBox_autoCopy.IsChecked  AND (length (Memo_out.Text)>10) then
   begin
    Memo_out.SelectAll;
    Memo_out.CopyToClipboard;
    Memo_out.SetFocus;
   end;

end;

procedure TMain_Form.RadioButton_HTMLChange(Sender: TObject);
begin
   get_Code;
end;

//url����
procedure TMain_Form.Test_URL;
var
  match: TMatch;
  test_old_url:PwideChar;
  test_new_url:bool; //��url
begin

  Memo_out.Text := '' ;  //��
  newurl :=   '' ;  //��

  test_old_url:=StrPos(PwideChar(Edit_old_src.Text),'yake_qzoneimgout'); //���ұ��
  if test_old_url <> '' then
    begin
      Err_Tips.Visible := true;
      exit ; //�б�ǵı�ʾ�Ѿ�������ĵ�ַ,�˳�procedure
    end;



  test_new_url:= false;
  match := TRegEx.Match(trim(Edit_old_src.Text), pattern);

  if not match.Success  then
  begin
      test_new_url:= true;
      match := TRegEx.Match(trim(Edit_old_src.Text), pattern2);
  end;



if  match.Success then
  begin

    if  test_new_url then
    begin
      newurl :=   '//r.photo.store.qq.com/psc?/' +
                  match.Groups[1].Value  +  '/r/' + '_yake_qzoneimgout.png';
    end
      else
      begin
        newurl :=   '//r.photo.store.qq.com/ps'+ match.Groups[1].Value + '?/' +
                    match.Groups[2].Value  +  '/' +
                    match.Groups[3].Value  + '/r/'+
                    match.Groups[4].Value  + '_yake_qzoneimgout.png';
      end;





    Err_Tips.Visible := false;
    get_Code;
  end
    else
    begin
      Err_Tips.Visible := true;
    end;

end;

procedure TMain_Form.Text1Click(Sender: TObject);
begin
 Help_Form.Show;
end;

procedure TMain_Form.Text2Click(Sender: TObject);
const
sCommand = 'https://www.yge.me/';

var
lCommand :Char;
begin

{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(sCommand), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}



 {$IFDEF POSIX}

{$IFDEF MACOS}
  _system(PAnsiChar('open -a Safari ' + AnsiString(sCommand)));
{$ENDIF MACOS}
{$IFDEF ANDROID}

{$ENDIF ANDROID}
{$IFDEF LINUX}
  _system('firefox ' + sCommand);
{$ENDIF LINUX}
{$ENDIF POSIX}

end;

end.
