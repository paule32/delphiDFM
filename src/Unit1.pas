// ----------------------------------------------------------------
// unit1.pas - GUI pascal source for delphiDFM v1.0
// (c) 2022 by Jens Kallup - paule32
// all rights reserved.
// ----------------------------------------------------------------
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, JvImageList, Menus, AdvMenus, AdvGlowButton,
  AdvToolBar, AdvToolBarStylers, AdvOfficeStatusBar, AdvMenuStylers,
  JvProgressBar, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  JvExControls, JvOutlookBar, JvGradientCaption, JvArrowButton, JvSplitter,
  JvSyncSplitter, JvPageList, JvDialogs, SynEdit;

type
  TForm1 = class(TForm)
    AdvOfficeStatusBar1: TAdvOfficeStatusBar;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    AdvGlowButton1: TAdvGlowButton;
    AdvMainMenu1: TAdvMainMenu;
    FileMenu: TMenuItem;
    AdvGlowButton2: TAdvGlowButton;
    ExitMenu: TMenuItem;
    N1: TMenuItem;
    OpenMenu: TMenuItem;
    SaveMenu: TMenuItem;
    SaveAsMenu: TMenuItem;
    ProcessMenu: TMenuItem;
    ProcessStartMenu: TMenuItem;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    JvImageList1: TJvImageList;
    AdvDockPanel2: TAdvDockPanel;
    AdvDockPanel3: TAdvDockPanel;
    AdvDockPanel4: TAdvDockPanel;
    JvOutlookBar1: TJvOutlookBar;
    JvPanel1: TJvPanel;
    JvGradientProgressBar1: TJvGradientProgressBar;
    JvGradientCaption1: TJvGradientCaption;
    JvPageList1: TJvPageList;
    AddObjectsPage: TJvStandardPage;
    JvPanel2: TJvPanel;
    JvPanel3: TJvPanel;
    JvSyncSplitter1: TJvSyncSplitter;
    JvPanel4: TJvPanel;
    JvPanel5: TJvPanel;
    InputArrowButton: TJvArrowButton;
    OutputArrowButton: TJvArrowButton;
    JvOpenDialog1: TJvOpenDialog;
    JvOpenDialog2: TJvOpenDialog;
    AdvPopupMenu1: TAdvPopupMenu;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    JvPanel6: TJvPanel;
    SynEdit1: TSynEdit;
    SynEdit2: TSynEdit;
    AdvGlowButton5: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    AdvPopupMenu2: TAdvPopupMenu;
    SelectAllButton: TAdvGlowButton;
    CopyButton: TAdvGlowButton;
    PasteButton: TAdvGlowButton;
    AdvGlowButton7: TAdvGlowButton;
    JvPanel7: TJvPanel;
    AdvGlowButton8: TAdvGlowButton;
    procedure ExitMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AdvGlowButton3Click(Sender: TObject);
    procedure AdvGlowButton4Click(Sender: TObject);
    procedure InputArrowButtonClick(Sender: TObject);
    procedure OutputArrowButtonClick(Sender: TObject);
    procedure SelectAllButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure AdvGlowButton2Click(Sender: TObject);
    procedure AdvGlowButton7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses parser;

resourcestring
selectFileStr        = 'Please Select a File ...';
noInputFileStr       = 'no input file selected.';
noOutputFileStr      = 'no output file selected.';
opAbortedStr         = 'operation aborted.';
opOverWriteOutputStr = 'Overwrite output file ?';
sInformationStr      = 'Information';

procedure TForm1.ExitMenuClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SynEdit1.Text := '';
  SynEdit2.Text := '';
end;

procedure TForm1.AdvGlowButton3Click(Sender: TObject);
var
  menuItem : TMenuItem;
begin
  if not JvOpenDialog1.Execute then
  begin
     ShowMessage('error at input file.');
     Exit;
  end;

  InputArrowButton.Caption := JvOpenDialog1.FileName;

  menuItem := TMenuItem.Create(AdvPopupMenu1);
  menuItem.Caption := JvOpenDialog1.FileName;
  menuItem.OnClick := InputArrowButtonClick;

  AdvPopupMenu1.Items.Add(menuItem);
  InputArrowButtonClick(menuitem);
end;

procedure TForm1.AdvGlowButton4Click(Sender: TObject);
var
  menuItem : TMenuItem;
begin
  if not JvOpenDialog2.Execute then
  begin
     ShowMessage('error at output file.');
     Exit;
  end;

  OutputArrowButton.Caption := JvOpenDialog2.FileName;

  menuItem := TMenuItem.Create(AdvPopupMenu2);
  menuItem.Caption := JvOpenDialog2.FileName;
  menuItem.OnClick := OutputArrowButtonClick;

  AdvPopupMenu2.Items.Add(menuItem);
end;

procedure TForm1.InputArrowButtonClick(Sender: TObject);
var
  stream: TMemoryStream;
  astr: string;
begin
  stream := nil;
  try
    stream := TMemoryStream.Create;
    try
      if (Sender is TMenuItem) then
      begin
        astr := (Sender as TMenuItem).Caption;
        astr := StringReplace(astr,'&','',[rfReplaceAll]);
        stream.LoadFromFile(astr);
      end else
      if (Sender is TJvArrowButton) then
      begin
        astr := (Sender as TJvArrowButton).Caption;
        stream.LoadFromFile(astr);
      end;
      SynEdit1.Lines.LoadFromStream(stream);
    except
      on E: Exception do
      begin
         ShowMessage('Exception occur:' + #13#10 +
         E.Message);
      end;
    end;
  finally
    stream.Clear;
    stream.Free;
  end;
end;

procedure TForm1.OutputArrowButtonClick(Sender: TObject);
var
  stream: TMemoryStream;
  astr: string;
begin
  stream := nil;
  try
    stream := TMemoryStream.Create;
    try
      if (Sender is TMenuItem) then
      begin
        astr := (Sender as TMenuItem).Caption;
        astr := StringReplace(astr,'&','',[rfReplaceAll]);
        stream.LoadFromFile(astr);
      end else
      if (Sender is TJvArrowButton) then
      begin
        astr := (Sender as TJvArrowButton).Caption;
        stream.LoadFromFile(astr);
      end;
      SynEdit2.Lines.LoadFromStream(stream);
    except
      on E: Exception do
      begin
         ShowMessage('Exception occur:' + #13#10 +
         E.Message);
      end;
    end;
  finally
    stream.Clear;
    stream.Free;
  end;
end;

procedure TForm1.SelectAllButtonClick(Sender: TObject);
begin
  if SynEdit1.Focused then begin
     SynEdit1.SelectAll;
  end else
  if SynEdit2.Focused then begin
     SynEdit2.SelectAll;
  end;
end;

procedure TForm1.CopyButtonClick(Sender: TObject);
begin
  if SynEdit1.Focused then begin
     SynEdit1.CopyToClipboard;
  end else
  if SynEdit2.Focused then begin
     SynEdit2.CopyToClipboard;
  end;
end;

procedure TForm1.PasteButtonClick(Sender: TObject);
begin
  if SynEdit1.Focused then begin
     SynEdit1.PasteFromClipboard;
  end else
  if SynEdit2.Focused then begin
     SynEdit2.PasteFromClipboard;
  end;
end;

procedure TForm1.AdvGlowButton2Click(Sender: TObject);
var
  processed: Boolean;
begin
  processed := False;

  if (InputArrowButton.Caption = selectFileStr)
  or (InputArrowButton.Caption = 'Please Select a File ...') then
  begin
    ShowMessage(noInputFileStr);
    Exit;
  end;

  if (OutputArrowButton.Caption = selectFileStr)
  or (OutputArrowButton.Caption = 'Please Select a File ...') then
  begin
    ShowMessage(noOutputFileStr);
    Exit;
  end;

  if (ExtractFileExt(OutputArrowButton.Caption) = '.pas')
  or (ExtractFileExt(OutputArrowButton.Caption) = '.dfm') then
  begin
    if FileExists(OutputArrowButton.Caption) then
    begin
       if Application.MessageBox(
          PChar(opOverWriteOutputStr),
          PChar(sInformationStr),MB_YESNO) = IDNO then
       begin
          ShowMessage(opAbortedStr);
          Exit;
       end;
    end;
    try
      myparser(
        InputArrowButton .Caption,
        OutputArrowButton.Caption
      );
      processed := True;
    except
      on E: Exception do
      begin
         ShowMessage(E.Message);
         Exit;
      end;
    end;
  end;

  if not processed then
  begin
    ShowMessage('error, not processed right.');
  end;
end;

procedure TForm1.AdvGlowButton7Click(Sender: TObject);
begin
  ShowMessage(JvOpenDialog1.FileName);
  SynEdit1.Lines.SaveToFile(JvOpenDialog1.FileName);
end;

end.

