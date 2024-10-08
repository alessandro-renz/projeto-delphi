{*******************************************************}
{                                                       }
{     Delphi VCL Extensions (RX) demo program           }
{                                                       }
{     Copyright (c) 1996 AO ROSNO                       }
{     Copyright (c) 1997, 1998 Master-Bank              }
{                                                       }
{*******************************************************}

unit Main;

{$I RX.INC}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, RxDbPrgrss, RxPlacemnt,
  DB, DBTables, DBCtrls, RxSpeedBar, RXDBCtrl, RxDBSecur, RXShell, RxAppEvent,
  RxMRUList, ComCtrls, RXCtrls{$ifdef RX_D15}, UITypes{$endif};

type
  TDBExplorerMainForm = class(TForm)
    DBProgress: TDBProgress;
    SQLFontContainer: TLabel;
    FormPlacement: TFormStorage;
    BottomPanel: TPanel;
    StatusLine: TPanel;
    RightPanel: TPanel;
    StatusPanel: TPanel;
    DBStatusLabel: TDBStatusLabel;
    RecNoPanel: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    UtilitiesMenu: TMenuItem;
    PackTableItem: TMenuItem;
    DeleteTableItem: TMenuItem;
    EmptyTableItem: TMenuItem;
    ReindexItem: TMenuItem;
    RenameTableItem: TMenuItem;
    ExportTableItem: TMenuItem;
    CheckPXSubMenu: TMenuItem;
    CheckPXItem: TMenuItem;
    CheckPXAllItem: TMenuItem;
    Options1: TMenuItem;
    AutoActivateItem: TMenuItem;
    SystemTablesItem: TMenuItem;
    KeepConnectionsItem: TMenuItem;
    N3: TMenuItem;
    OptionsItem: TMenuItem;
    CustomizeSpeedbar: TMenuItem;
    WindowMenu: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    SpeedBar: TSpeedBar;
    SpeedItem1: TSpeedItem;
    CloseButton: TSpeedItem;
    SpeedItem3: TSpeedItem;
    PackBtn: TSpeedItem;
    DeleteBtn: TSpeedItem;
    EmptyBtn: TSpeedItem;
    RenameBtn: TSpeedItem;
    ExportBtn: TSpeedItem;
    RepairBtn: TSpeedItem;
    SpeedItem4: TSpeedItem;
    SpeedItem2: TSpeedItem;
    KeepConnectionsSpd: TSpeedItem;
    OptionsBtn: TSpeedItem;
    SpeedItem5: TSpeedItem;
    SpeedItem6: TSpeedItem;
    DBRecordNo: TDBStatusLabel;
    WindowTileVerticalItem: TMenuItem;
    N2: TMenuItem;
    ImportDataItem: TMenuItem;
    ImportBtn: TSpeedItem;
    StartTransItem: TMenuItem;
    CommitItem: TMenuItem;
    RollbackItem: TMenuItem;
    SQLMonitorItem: TMenuItem;
    N4: TMenuItem;
    TraceSQLItem: TMenuItem;
    ClearTraceItem: TMenuItem;
    TablesSessionMenu: TMenuItem;
    QuerySessionMenu: TMenuItem;
    StartTransQueryItem: TMenuItem;
    CommitQueryItem: TMenuItem;
    RollbackQueryItem: TMenuItem;
    SQLMonitorBtn: TSpeedItem;
    TabPasswordItem: TMenuItem;
    QryPasswordItem: TMenuItem;
    DBNavigator: TDBNavigator;
    N5: TMenuItem;
    BdePropsItem: TMenuItem;
    FlatButtonsItem: TMenuItem;
    ClosedDatabases: TMRUManager;
    ReopenItem: TMenuItem;
    DBGauge: TProgressBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    SpeedbarSection4: TSpeedbarSection;
    AppEvents: TAppEvents;
    HelpList: TMRUManager;
    UserHelpItem: TMenuItem;
    PrintDataItem: TMenuItem;
    PrintBtn: TSpeedItem;
    procedure FormCreate(Sender: TObject);
    procedure WindowCascadeItemClick(Sender: TObject);
    procedure UpdateMenuItems(Sender: TObject);
    procedure WindowTileItemClick(Sender: TObject);
    procedure WindowArrangeItemClick(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure WindowMinimizeItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpAboutItemClick(Sender: TObject);
    procedure FormPlacementSavePlacement(Sender: TObject);
    procedure FormPlacementRestorePlacement(Sender: TObject);
    procedure CustomizeToolbarItemClick(Sender: TObject);
    procedure AutoActivateItemClick(Sender: TObject);
    procedure SystemTablesItemClick(Sender: TObject);
    function DBStatusLabelGetDataName(Sender: TObject): string;
    procedure PackTableClick(Sender: TObject);
    procedure DeleteTableClick(Sender: TObject);
    procedure EmptyTableClick(Sender: TObject);
    procedure RenameTableClick(Sender: TObject);
    procedure CheckPXItemClick(Sender: TObject);
    procedure ReindexItemClick(Sender: TObject);
    procedure ExportClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure KeepConnectionsItemClick(Sender: TObject);
    procedure ImportClick(Sender: TObject);
    procedure StartTransItemClick(Sender: TObject);
    procedure CommitItemClick(Sender: TObject);
    procedure RollbackItemClick(Sender: TObject);
    procedure SQLMonitorItemClick(Sender: TObject);
    procedure TraceSQLItemClick(Sender: TObject);
    procedure DBProgressTrace(Sender: TObject; Flag: TTraceFlag;
      const Msg: string);
    procedure ClearTraceItemClick(Sender: TObject);
    procedure PasswordItemClick(Sender: TObject);
    procedure SpeedBarApplyAlign(Sender: TObject; Align: TAlign;
      var Apply: Boolean);
    procedure SpeedBarResize(Sender: TObject);
    procedure BdePropsItemClick(Sender: TObject);
    procedure FlatButtonsItemClick(Sender: TObject);
    procedure ClosedDatabasesClick(Sender: TObject; const RecentName,
      Caption: string; UserData: Longint);
    procedure AppHint(Sender: TObject);
    procedure AppIdle(Sender: TObject; var Done: Boolean);
    procedure HelpListClick(Sender: TObject; const RecentName,
      Caption: string; UserData: Longint);
    procedure UserHelpItemClick(Sender: TObject);
    procedure DBRecordNoDblClick(Sender: TObject);
    procedure SpeedBarPosChanged(Sender: TObject);
    procedure DBRecordNoGetRecordCount(Sender: TObject; DataSet: TDataSet;
      var Value: Longint);
    procedure PrintDataClick(Sender: TObject);
  private
    { Private declarations }
{$IFDEF RX_D4}
    FPrevClientProc: TFarProc;
    FClientInstance: TFarProc;
    procedure ClientWndProc(var Message: TMessage);
{$ENDIF RX_D4}
    procedure CreateMDIChild(const AName: string);
    procedure DatabaseLogin(Database: TDatabase; LoginParams: TStrings);
  protected
    procedure CreateWnd; override;
  public
    { Public declarations }
    procedure ApplyOptions;
    procedure UpdateMenus;
    procedure SetSQLTrace(Value: Boolean);
    procedure ShowEdge;
  end;

var
  DBExplorerMainForm: TDBExplorerMainForm;

implementation

{$R *.DFM}

uses
  DBCbRest, SQLMon, Bde, RxVCLUtils, ChildWin, OpenDlg,
  RxAppUtils, RxDBUtils, IniFiles, RxLoginDlg, RenDlg, About, Options, OptDlg,
  RxBdeUtils, BdeProp, UserHelp, RxHints;

const
  SEmptyWarning = 'Table %s will be emptied. All data will be lost. Continue?';
  SDeleteWarning = 'Table %s will be deleted. All data will be lost. Continue?';
  SSqlDatabase = 'Cannot perform this operation on a SQL database';

{ TMainForm }

procedure TDBExplorerMainForm.ShowEdge;
begin
  ShowMDIClientEdge(ClientHandle, True);
end;

procedure TDBExplorerMainForm.CreateWnd;
begin
  inherited CreateWnd;
  ShowEdge;
{$IFDEF RX_D4}
  if ClientHandle <> 0 then begin
    FClientInstance := MakeObjectInstance(ClientWndProc);
    FPrevClientProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
    {$IFDEF WIN64}
    SetWindowLongPtr(ClientHandle, GWLP_WNDPROC, LONG_PTR(FClientInstance));
    {$ELSE}
    SetWindowLong(ClientHandle, GWL_WNDPROC, Longint(FClientInstance));
    {$ENDIF}
  end;
{$ENDIF}
end;

{$IFDEF RX_D4} {!! Do not hide MDI client edge }
procedure TDBExplorerMainForm.ClientWndProc(var Message: TMessage);
  procedure Default;
  begin
    with Message do
      Result := CallWindowProc(FPrevClientProc, ClientHandle, Msg, wParam, lParam);
  end;
begin
  if (Message.Msg = $3F) and (FormStyle = fsMDIForm) then begin
    SetDesigning(True);
    FormStyle := fsNormal;
    try
      Default;
    finally
      FormStyle := fsMDIForm;
      SetDesigning(False);
    end;
  end
  else Default;
end;
{$ENDIF}

procedure TDBExplorerMainForm.ApplyOptions;
var
  I: Integer;
begin
  SpeedItem4.Down := AutoActivate;
  AutoActivateItem.Checked := AutoActivate;
  SpeedItem2.Down := SystemTables;
  SystemTablesItem.Checked := SystemTables;
  KeepConnectionsSpd.Down := Session.KeepConnections;
  KeepConnectionsItem.Checked := Session.KeepConnections;
  FlatButtonsItem.Checked := sbFlatBtns in Speedbar.Options;
  DBRecordNo.CalcRecCount := SQLCalcCount;
  DBProgress.TraceFlags := SQLTraceFlags;
  BufSetSize(SQLTraceBuffer);
  for I := MDIChildCount - 1 downto 0 do begin
    if (MDIChildren[I] is TMDIChild) then begin
      if AutoActivate then
        TMDIChild(MDIChildren[I]).SetToCurrentTable;
      TMDIChild(MDIChildren[I]).UpdateSystemTables;
      TMDIChild(MDIChildren[I]).UpdateDataFieldFormats;
      TMDIChild(MDIChildren[I]).UpdateThreadOptions;
      TMDIChild(MDIChildren[I]).SQLMemo.Font := SQLFontContainer.Font;
      TMDIChild(MDIChildren[I]).SetTrace(DBProgress.Trace);
    end;
  end;
end;

procedure TDBExplorerMainForm.FormCreate(Sender: TObject);
begin
  Screen.OnActiveFormChange := UpdateMenuItems;
  Caption := Application.Title + ' ' + SDbxVersion;
  if not NewStyleControls then begin
    with Speedbar do begin
      BevelOuter := bvRaised;
      Height := 29;
      BtnOffsetVert := 3;
      BoundLines := [];
    end;
  end;
  try
    Session.PrivateDir := GetEnvVar('TEMP');
  except
    { ignore }
  end;
  DBProgress.TraceFlags := SQLTraceFlags;
  SetHintStyle(hsRectangle, 0, False, taCenter);
end;

procedure TDBExplorerMainForm.AppHint(Sender: TObject);
begin
  StatusLine.Caption := Application.Hint;
end;

procedure TDBExplorerMainForm.AppIdle(Sender: TObject;
  var Done: Boolean);
begin
{$IFDEF VER90}
  DbiUseIdleTime;
{$ELSE}
  BdeFlushBuffers;
{$ENDIF}
end;

procedure TDBExplorerMainForm.CreateMDIChild(const AName: string);
const
  SQuerySession = '_Query_';
var
  SName: string;
  I: Integer;
  TempDatabase: TDatabase;
  ChildForm: TMDIChild;
begin
  Session.Open;
  Sessions.CurrentSession := Session;
  TempDatabase := Session.FindDatabase(AName);
  if TempDatabase = nil then begin
    TempDatabase := TDatabase.Create(nil);
    with TempDatabase do begin
      DatabaseName := AName;
      Temporary := True;
      OnLogin := DatabaseLogin;
    end;
    TempDatabase.KeepConnection := Session.KeepConnections;
    TempDatabase.SessionName := Session.SessionName;
  end;
  TempDatabase.Session.OpenDatabase(TempDatabase.DatabaseName);
  ChildForm := TMDIChild.Create(Application);
  with ChildForm do begin
    SQLMemo.Font := SQLFontContainer.Font;
    DatabaseName := AName;
    I := 0;
    repeat
      if Session.IsAlias(AName) then SName := AName + SQuerySession + IntToStr(I)
      else SName := 'S' + SQuerySession + IntToStr(I);
      Inc(I);
    until Sessions.FindSession(SName) = nil;
    with QuerySession do begin
      SessionName := SName;
      Open;
    end;
    DBQueryProgress.SessionName := SName;
    DBQueryProgress.Active := True;
    if DBProgress.Trace then SetTrace(True);
    with QueryDB do begin
      SessionName := SName;
      DatabaseName := AName;
      Params.Assign(TempDatabase.Params);
      LoginPrompt := False;
      Open;
    end;
    Query1.SessionName := SName;
    Query1.DatabaseName := QueryDB.DatabaseName;
    UpdateThreadOptions;
  end;
  Sessions.CurrentSession := Session;
  ClosedDatabases.Remove(AName);
  UpdateMenus;
end;

procedure TDBExplorerMainForm.FileOpenItemClick(Sender: TObject);
var
  DBName: string;
begin
  if GetOpenDatabase(DBName) then begin
    Screen.OnActiveFormChange := nil;
    try
      CreateMDIChild(DBName);
    finally
      Screen.OnActiveFormChange := UpdateMenuItems;
    end;
  end;
end;

procedure TDBExplorerMainForm.FileCloseItemClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    ActiveMDIChild.Close;
end;

procedure TDBExplorerMainForm.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TDBExplorerMainForm.WindowCascadeItemClick(Sender: TObject);
begin
  Cascade;
end;

procedure TDBExplorerMainForm.WindowTileItemClick(Sender: TObject);
begin
  if Sender = WindowTileItem then { TileHorizontal } TileMode := tbHorizontal
  else if Sender = WindowTileVerticalItem then TileMode := tbVertical;
  Tile;
end;

procedure TDBExplorerMainForm.WindowArrangeItemClick(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TDBExplorerMainForm.WindowMinimizeItemClick(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TDBExplorerMainForm.UpdateMenuItems(Sender: TObject);
var
  TabEnable: Boolean;
begin
  TabEnable := (MDIChildCount > 0) and (ActiveMDIChild <> nil)
    and (ActiveMDIChild is TMDIChild);
  ImportDataItem.Enabled := TabEnable;
  ImportBtn.Enabled := TabEnable;
  ExportTableItem.Enabled := TabEnable;
  ExportBtn.Enabled := TabEnable;
  PrintDataItem.Enabled := TabEnable;
  PrintBtn.Enabled := TabEnable;
  ReindexItem.Enabled := TabEnable;
  PackTableItem.Enabled := TabEnable;
  PackBtn.Enabled := TabEnable;
  DeleteTableItem.Enabled := TabEnable;
  DeleteBtn.Enabled := TabEnable;
  EmptyTableItem.Enabled := TabEnable;
  EmptyBtn.Enabled := TabEnable;
  RenameTableItem.Enabled := TabEnable;
  RenameBtn.Enabled := TabEnable;
  DBNavigator.Enabled := TabEnable;
  if TabEnable then begin
    DBNavigator.DataSource := (ActiveMDIChild as TMDIChild).DataSource;
    DBStatusLabel.DataSource := (ActiveMDIChild as TMDIChild).DataSource;
    DBRecordNo.DataSource := (ActiveMDIChild as TMDIChild).DataSource;
  end
  else begin
    DBNavigator.DataSource := nil;
    DBStatusLabel.DataSource := nil;
    DBRecordNo.DataSource := nil;
  end;
  { Check and repair commands }
  CheckPXItem.Enabled := TabEnable;
  RepairBtn.Enabled := TabEnable;
  CheckPXAllItem.Enabled := TabEnable;
  CheckPXSubMenu.Enabled := TabEnable;
  { Database commands }
  FileCloseItem.Enabled := TabEnable;
  CloseButton.Enabled := TabEnable;
  { Tables transactions }
  StartTransItem.Enabled := TabEnable and
    (ActiveMDIChild as TMDIChild).TransOperEnabled(tsTables, teStart);
  CommitItem.Enabled := TabEnable and
    (ActiveMDIChild as TMDIChild).TransOperEnabled(tsTables, teCommit);
  RollbackItem.Enabled := TabEnable and
    (ActiveMDIChild as TMDIChild).TransOperEnabled(tsTables, teRollback);
  TablesSessionMenu.Enabled := True;
  { Query transactions }
  StartTransQueryItem.Enabled := TabEnable and
    (ActiveMDIChild as TMDIChild).TransOperEnabled(tsQuery, teStart);
  CommitQueryItem.Enabled := TabEnable and
    (ActiveMDIChild as TMDIChild).TransOperEnabled(tsQuery, teCommit);
  RollbackQueryItem.Enabled := TabEnable and
    (ActiveMDIChild as TMDIChild).TransOperEnabled(tsQuery, teRollback);
  QuerySessionMenu.Enabled := TabEnable and
    (ActiveMDIChild as TMDIChild).QuerySession.Active;
  QryPasswordItem.Enabled := QuerySessionMenu.Enabled;
  { Window commands }
  WindowCascadeItem.Enabled := MDIChildCount > 0;
  WindowTileItem.Enabled := MDIChildCount > 0;
  WindowTileVerticalItem.Enabled := MDIChildCount > 0;
  WindowArrangeItem.Enabled := MDIChildCount > 0;
  WindowMinimizeItem.Enabled := MDIChildCount > 0;
end;

procedure TDBExplorerMainForm.UpdateMenus;
begin
  UpdateMenuItems(nil);
end;

procedure TDBExplorerMainForm.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
end;

procedure TDBExplorerMainForm.HelpAboutItemClick(Sender: TObject);
begin
  ShowAbout;
end;

procedure TDBExplorerMainForm.FormPlacementSavePlacement(Sender: TObject);
begin
  SaveOptions(FormPlacement.IniFile);
end;

procedure TDBExplorerMainForm.FormPlacementRestorePlacement(Sender: TObject);
begin
  LoadOptions(FormPlacement.IniFile);
  ApplyOptions;
end;

procedure TDBExplorerMainForm.CustomizeToolbarItemClick(Sender: TObject);
begin
  Speedbar.Customize(0);
end;

procedure TDBExplorerMainForm.AutoActivateItemClick(Sender: TObject);
begin
  AutoActivate := not AutoActivate;
  ApplyOptions;
end;

procedure TDBExplorerMainForm.SystemTablesItemClick(Sender: TObject);
begin
  SystemTables := not SystemTables;
  ApplyOptions;
end;

function TDBExplorerMainForm.DBStatusLabelGetDataName(
  Sender: TObject): string;
begin
  Result := '';
end;

procedure TDBExplorerMainForm.DBRecordNoGetRecordCount(Sender: TObject;
  DataSet: TDataSet; var Value: Longint);
begin
  if SQLCalcCount or ((DataSet is TDBDataSet) and not 
    TDBDataSet(DataSet).Database.IsSQLBased) then
    Value := DataSetRecordCount(TBDEDataSet(DataSet));
end;

procedure TDBExplorerMainForm.DBRecordNoDblClick(Sender: TObject);
begin
  SQLCalcCount := not SQLCalcCount;
  DBRecordNo.CalcRecCount := SQLCalcCount;
end;

procedure TDBExplorerMainForm.PackTableClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).PackCurrentTable;
end;

procedure TDBExplorerMainForm.DeleteTableClick(Sender: TObject);
var
  Tab: TTable;
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
  begin
    Tab := (ActiveMDIChild as TMDIChild).CurrentTable;
    if Tab <> nil then begin
      if MessageDlg(Format(SDeleteWarning, [Tab.TableName]), mtWarning,
        [mbYes, mbNo], 0) = mrYes then
      begin
        Tab.DisableControls;
        try
          if Tab.Active then Tab.Close;
          Tab.DeleteTable;
          (ActiveMDIChild as TMDIChild).MarkAsDeleted(Tab.TableName);
        finally
          Tab.EnableControls;
        end;
      end;
    end;
  end;
end;

procedure TDBExplorerMainForm.EmptyTableClick(Sender: TObject);
var
  Tab: TTable;
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
  begin
    Tab := (ActiveMDIChild as TMDIChild).CurrentTable;
    if Tab <> nil then begin
      if MessageDlg(Format(SEmptyWarning, [Tab.TableName]), mtWarning,
        [mbYes, mbNo], 0) = mrYes then
      begin
        Tab.DisableControls;
        StartWait;
        try
          if Tab.Active then Tab.Close;
          Tab.EmptyTable;
          Tab.Open;
        finally
          StopWait;
          Tab.EnableControls;
        end;
      end;
    end;
  end;
end;

procedure TDBExplorerMainForm.RenameTableClick(Sender: TObject);
var
  Tab: TTable;
  NewName: string;
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
  begin
    if not (ActiveMDIChild as TMDIChild).CheckStandard then
      DatabaseError(SSqlDatabase);
    Tab := (ActiveMDIChild as TMDIChild).CurrentTable;
    if Tab <> nil then begin
      if RenameTableDialog(Tab.TableName,
        (ActiveMDIChild as TMDIChild).SessionDB(tsTables).Directory, NewName) then
      begin
        Tab.DisableControls;
        try
          if Tab.Active then Tab.Close;
          Tab.RenameTable(NewName);
          with (ActiveMDIChild as TMDIChild) do begin
            RefreshData;
            SetToCurrentTable;
          end;
        finally
          Tab.EnableControls;
        end;
      end;
    end;
  end;
end;

procedure TDBExplorerMainForm.CheckPXItemClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).CheckAndRepairParadoxTable(
      Sender = CheckPXAllItem);
end;

procedure TDBExplorerMainForm.DatabaseLogin(Database: TDatabase;
  LoginParams: TStrings);
var
  DBase: TDatabase;
begin
  DBase := Session.FindDatabase(Database.DatabaseName);
  if (DBase <> nil) and DBase.Connected and
    (Database.Session <> Session) then
    LoginParams.Assign(DBase.Params)
  else OnLoginDialog(Database, LoginParams, 3, True);
  Database.Params.Values['USER NAME'] := LoginParams.Values['USER NAME'];
  Database.Params.Values['PASSWORD'] := LoginParams.Values['PASSWORD'];
end;

procedure TDBExplorerMainForm.ExportClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).ExportCurrentTable;
end;

procedure TDBExplorerMainForm.ImportClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).ImportToCurrentTable;
end;

procedure TDBExplorerMainForm.PrintDataClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).PrintCurrentTable;
end;

procedure TDBExplorerMainForm.OptionsClick(Sender: TObject);
begin
  ShowDialog(TOptionsDialog);
end;

procedure TDBExplorerMainForm.ReindexItemClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).ReindexTable;
end;

procedure TDBExplorerMainForm.KeepConnectionsItemClick(Sender: TObject);
begin
  SetKeepConnections(not Session.KeepConnections);
  KeepConnectionsItem.Checked := Session.KeepConnections;
  KeepConnectionsSpd.Down := Session.KeepConnections;
end;

procedure TDBExplorerMainForm.StartTransItemClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).StartTransaction(TTransSession(
    Sender = StartTransQueryItem));
end;

procedure TDBExplorerMainForm.CommitItemClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).Commit(TTransSession(
    Sender = CommitQueryItem));
end;

procedure TDBExplorerMainForm.RollbackItemClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and (ActiveMDIChild is TMDIChild) then
    (ActiveMDIChild as TMDIChild).Rollback(TTransSession(
    Sender = RollbackQueryItem));
end;

procedure TDBExplorerMainForm.SQLMonitorItemClick(Sender: TObject);
begin
  FindShowForm(TTraceSQL, '');
end;

procedure TDBExplorerMainForm.SetSQLTrace(Value: Boolean);
var
  I: Integer;
begin
  if Value <> DBProgress.Trace then begin
    DBProgress.TraceFlags := SQLTraceFlags;
    DBProgress.Trace := Value;
    for I := MDIChildCount - 1 downto 0 do
      if (MDIChildren[I] is TMDIChild) then
        (MDIChildren[I] as TMDIChild).SetTrace(Value);
  end;
end;

procedure TDBExplorerMainForm.TraceSQLItemClick(Sender: TObject);
begin
  SetSQLTrace(not DBProgress.Trace);
  TraceSQLItem.Checked := DBProgress.Trace;
end;

procedure TDBExplorerMainForm.DBProgressTrace(Sender: TObject;
  Flag: TTraceFlag; const Msg: string);
begin
  BufAddLine(Msg);
end;

procedure TDBExplorerMainForm.ClearTraceItemClick(Sender: TObject);
begin
  BufClear(True);
end;

procedure TDBExplorerMainForm.PasswordItemClick(Sender: TObject);
begin
  if Sender = QryPasswordItem then
    (ActiveMDIChild as TMDIChild).QuerySession.GetPassword
  else Session.GetPassword;
end;

procedure TDBExplorerMainForm.SpeedBarApplyAlign(Sender: TObject;
  Align: TAlign; var Apply: Boolean);
begin
  Apply := Align in [alTop, alBottom];
end;

procedure TDBExplorerMainForm.SpeedBarResize(Sender: TObject);
begin
  DBNavigator.Left := Speedbar.Width - DBNavigator.Width - 8;
end;

procedure TDBExplorerMainForm.BdePropsItemClick(Sender: TObject);
begin
  ShowDialog(TBdePropertyDlg);
end;

procedure TDBExplorerMainForm.FlatButtonsItemClick(Sender: TObject);
begin
  if sbFlatBtns in Speedbar.Options then
    Speedbar.Options := Speedbar.Options - [sbFlatBtns]
  else
    Speedbar.Options := Speedbar.Options + [sbFlatBtns];
  FlatButtonsItem.Checked := sbFlatBtns in Speedbar.Options;
end;

procedure TDBExplorerMainForm.ClosedDatabasesClick(Sender: TObject;
  const RecentName, Caption: string; UserData: Longint);
begin
  Screen.OnActiveFormChange := nil;
  try
    CreateMDIChild(RecentName);
  finally
    Screen.OnActiveFormChange := UpdateMenuItems;
  end;
end;

procedure TDBExplorerMainForm.UserHelpItemClick(Sender: TObject);
begin
  CustomizeHelp(HelpList.Strings);
end;

procedure TDBExplorerMainForm.HelpListClick(Sender: TObject;
  const RecentName, Caption: string; UserData: Longint);
begin
  if GetLongHint(RecentName) <> '' then begin
    FileExecute(GetLongHint(RecentName), '', '', esNormal);
  end;
end;

procedure TDBExplorerMainForm.SpeedBarPosChanged(Sender: TObject);
begin
  if NewStyleControls then
    with SpeedBar do begin
      if Align = alTop then BoundLines := [blTop]
      else BoundLines := [];
    end;
end;

end.