{*******************************************************}
{                                                       }
{     Delphi VCL Extensions (RX) demo program           }
{                                                       }
{     Copyright (c) 1996 AO ROSNO                       }
{     Copyright (c) 1997 Master-Bank                    }
{                                                       }
{*******************************************************}

unit ViewBlob;
{$I RX.INC}
interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons, Dialogs,
  StdCtrls, ExtCtrls, RxPlacemnt, DBCtrls, DB, DBTables, Menus, HexDump{$ifdef RX_D15}, UITypes{$endif};

type
  TBlobViewDlg = class(TForm)
    CancelBtn: TBitBtn;
    Bevel: TBevel;
    DataSource: TDataSource;
    DBNavigator: TDBNavigator;
    HexPanel: TPanel;
    SizeLabel: TLabel;
    ClearBtn: TBitBtn;
    AddressBox: TCheckBox;
    FormStorage: TFormStorage;
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure AddressBoxClick(Sender: TObject);
  private
    FField: TField;
    FData: Pointer;
    FHexDump: THexDump;
  protected
{$IFDEF VER80}
    procedure CreateParams(var Params: TCreateParams); override;
{$ENDIF}
  end;

procedure BlobView(DataSet: TDataSet; const FieldName: string);

implementation

{$R *.DFM}

uses Messages, SysUtils, DBConsts, RxVCLUtils, RxMaxMin;

const
  SBlobSize = 'Blob size: %s byte(s)';
  SClearMsg = 'Field %s will be emptied. All data will be lost. Continue?';

procedure BlobView(DataSet: TDataSet; const FieldName: string);
begin
  with TBlobViewDlg.Create(Application) do
  try
    FField := DataSet.FieldByName(FieldName);
    if not (FField is TBlobField) then
      raise EDatabaseError.CreateFmt(ResStr(SFieldTypeMismatch), [FieldName]);
    Caption := Format('Field: %s', [FieldName]);
    FHexDump := CreateHexDump(HexPanel);
    FHexDump.RelativeAddress := True;
    AddressBoxClick(nil);
    DataSource.DataSet := DataSet;
    ShowModal;
  finally
    Free;
  end;
end;

{$IFDEF VER80}
procedure TBlobViewDlg.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if Application.MainForm <> nil then
    Params.WndParent := Application.MainForm.Handle;
end;
{$ENDIF}

procedure TBlobViewDlg.DataSourceDataChange(Sender: TObject;
  Field: TField);
var
  BlobStream: TBlobStream;
  DataSize: Longint;
begin
  if (Field = nil) or (Field = FField) then begin
    FreeMemo(FData);
    FData := nil;
    BlobStream := TBlobStream.Create(FField as TBlobField, bmRead);
    try
      DataSize := BlobStream.Size;
      SizeLabel.Caption := Format(SBlobSize, [FormatFloat(',0', BlobStream.Size)]);
      if DataSize > 0 then begin
        FData := AllocMemo(DataSize);
        BlobStream.Read(FData^, DataSize);
      end;
      FHexDump.Address := FData;
      FHexDump.DataSize := DataSize;
      ClearBtn.Enabled := DataSize > 0;
      ActiveControl := FHexDump;
    finally
      BlobStream.Free;
    end;
  end;
end;

procedure TBlobViewDlg.FormDestroy(Sender: TObject);
begin
  DataSource.OnDataChange := nil;
  FreeMemo(FData);
  FData := nil;
end;

procedure TBlobViewDlg.ClearBtnClick(Sender: TObject);
var
  WasEdit: Boolean;
begin
  if MessageDlg(Format(SClearMsg, [FField.FieldName]), mtWarning,
    [mbYes, mbNo], 0) = mrYes then
  begin
    WasEdit := DataSource.DataSet.State in [dsEdit, dsInsert];
    if not WasEdit then DataSource.DataSet.Edit;
    try
      with TBlobStream.Create(FField as TBlobField, bmWrite) do
      try
        Truncate;
      finally
        Free;
      end;
      if not WasEdit then DataSource.DataSet.Post;
    except
      if not WasEdit then DataSource.DataSet.Cancel;
      raise;
    end;
  end;
end;

procedure TBlobViewDlg.AddressBoxClick(Sender: TObject);
begin
  if FHexDump <> nil then
    FHexDump.ShowAddress := AddressBox.Checked;
end;

end.