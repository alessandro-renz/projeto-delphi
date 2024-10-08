{*******************************************************}
{                                                       }
{     Delphi VCL Extensions (RX) demo program           }
{                                                       }
{     Copyright (c) 1997, 1998 Master-Bank              }
{                                                       }
{*******************************************************}

unit BdeInfo;

{$I RX.INC}

interface

uses Classes, {$IFNDEF VER80} Windows, BDE, Registry, {$ELSE} IniFiles,
  DbiTypes, DbiProcs, DbiErrs, {$ENDIF} SysUtils, DB, DBTables;

{ TBdeInfo }

type
  TBdeInfo = class
  private
    FDllList: TStrings;
    FDirectory: string;
    FCfgPath: string;
    FVer: SYSVersion;
    FConfig: SYSConfig;
    FInfo: SYSInfo;
    procedure UpdateInformation(OnCreate: Boolean);
    procedure UpdateDllList;
    procedure UpdateRegInfo;
    function GetDllCount: Integer;
    function GetBdeDll(Index: Integer): string;
    function GetVersionDateTime: TDateTime;
    function GetNetworkType: string;
    function GetNetUserName: string;
    function GetLanguageDriver: string;
    function GetLangDriverDesc: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Update;
    property DllCount: Integer read GetDllCount;
    property BdeDll[Index: Integer]: string read GetBdeDll;
    property BdeDllList: TStrings read FDllList;
    property VersionDateTime: TDateTime read GetVersionDateTime; { Version Date }
    property BdeDirectory: string read FDirectory;
    property ConfigPath: string read FCfgPath;                   { CFG File Path }
    property EngineVersion: Word read FVer.iVersion;             { Engine Version }
    property InterfaceLevel: Word read FVer.iIntfLevel;          { Interface Level }
    property NetworkType: string read GetNetworkType;            { Network Type }
    property NetUserName: string read GetNetUserName;            { Net User Name }
    property LanguageDriver: string read GetLanguageDriver;      { Language Driver }
    property LangDriverDesc: string read GetLangDriverDesc;      { LangDriver Description }
    property BufferSpace: Word read FInfo.iBufferSpace;          { Buffer size, in K }
    property HeapSpace: Word read FInfo.iHeapSpace;              { Heap Space, in K }
    property ActiveDrivers: Word read FInfo.iDrivers;            { Active Drivers }
    property ActiveClients: Word read FInfo.iClients;            { Active Clients }
    property ActiveSessions: Word read FInfo.iSessions;          { Active Sessions }
    property ActiveDatabases: Word read FInfo.iDatabases;        { Active Databases }
    property ActiveCursors: Word read FInfo.iCursors;            { Active Cursors }
  end;

function FieldTypeName(AType: Word): string;
function FieldSubtypeName(ASubtype: Word): string;

implementation

uses RxVCLUtils;

{ TBdeInfo }

constructor TBdeInfo.Create;
begin
  inherited Create;
  FDllList := TStringList.Create;
  UpdateInformation(True);
end;

destructor TBdeInfo.Destroy;
begin
  FDllList.Free;
  inherited Destroy;
end;

procedure TBdeInfo.Update;
begin
  UpdateInformation(False);
end;

procedure TBdeInfo.UpdateRegInfo;
var
  I: Integer;
{$IFNDEF VER80}
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
    try
      LazyWrite := False;
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('SOFTWARE\Borland\Database Engine', False);
      try
        FDirectory := ReadString('DLLPATH');
        FCfgPath := ReadString('CONFIGFILE01');
      finally
        CloseKey;
      end;
    finally
      Free;
    end;
{$ELSE}
  Ini: TIniFile;
const
  sIDAPI = 'IDAPI';
begin
  Ini := TIniFile.Create('win.ini');
  with Ini do
    try
      FDirectory := ReadString(sIDAPI, 'DLLPATH', '');
      FCfgPath := ReadString(sIDAPI, 'CONFIGFILE01', '');
    finally
      Free;
    end;
{$ENDIF}
  I := Pos(';', FDirectory);
  if I > 0 then FDirectory := Copy(FDirectory, 1, I - 1);
  I := Pos(';', FCfgPath);
  if I > 0 then FCfgPath := Copy(FCfgPath, 1, I - 1);
  UpdateDllList;
end;

procedure TBdeInfo.UpdateDllList;
var
  Rec: TSearchRec;
  Status: Integer;
begin
  FDLLList.BeginUpdate;
  try
    FDLLList.Clear;
    Status := FindFirst(FDirectory + '\*.dll', faAnyFile, Rec);
    try
      while Status = 0 do begin
        FDLLList.Add(AnsiUpperFirstChar(Rec.Name));
        Status := FindNext(Rec);
      end;
    finally
      FindClose(Rec);
    end;
  finally
    FDLLList.EndUpdate;
  end;
end;

function TBdeInfo.GetDllCount: Integer;
begin
  Result := FDllList.Count;
end;

function TBdeInfo.GetBdeDll(Index: Integer): string;
begin
  Result := FDllList[Index];
end;

procedure TBdeInfo.UpdateInformation(OnCreate: Boolean);
begin
  if OnCreate then begin
    UpdateRegInfo;
    Check(DbiGetSysVersion(FVer));
  end;
  Check(DbiGetSysConfig(FConfig));
  Check(DbiGetSysInfo(FInfo));
end;

function TBdeInfo.GetVersionDateTime: TDateTime;
var
  Hour, Min, MSec, M, D: Word;
  Y: SmallInt;
begin
  Check(DbiDateDecode(FVer.dateVer, M, D, Y));
  Check(DbiTimeDecode(FVer.timeVer, Hour, Min, MSec));
  Result := EncodeDate(Y, M, D) + EncodeTime(Hour, Min, 0, 0);
end;

function TBdeInfo.GetNetworkType: string;
begin
  Result := string(StrPas(FConfig.szNetType));
end;

function TBdeInfo.GetNetUserName: string;
begin
  Result := string(StrPas(FConfig.szUserName));
end;

function TBdeInfo.GetLanguageDriver: string;
begin
  Result := StrPas(FConfig.szLangDriver);
end;

function TBdeInfo.GetLangDriverDesc: string;
var
  Cursor: HDBICur;
  Info: LDDesc;
begin
  Result := '';
  Check(DbiOpenLdList(Cursor));
  try
    while DbiGetNextRecord(Cursor, dbiNOLOCK, @Info, nil) = DBIERR_NONE do
      if StrIComp(Info.szName, FConfig.szLangDriver) = 0 then begin
        Result := Format('%s (%d)', [Info.szDesc, Info.iCodePage]);
        Break;
      end;
  finally
    DbiCloseCursor(Cursor);
  end;
end;

function FieldTypeName(AType: Word): string;
const
  Types: array [fldUNKNOWN..MAXLOGFLDTYPES - 1] of PChar =
    ('Unknown', 'String', 'Date', 'Blob', 'Boolean', 'Int16', 'Int32',
     'Float64', 'Decimal', 'Bytes', 'Time', 'DateTime', 'UInt16', 'UInt32',
     'Float80', 'VarBytes', 'LockInfo'
     {$IFDEF RX_D3}, 'Oracle Cursor' {$ENDIF}
     {$IFDEF RX_D4}, 'Int64', 'UInt64', 'Structure', 'Array', 'ADTRef',
     'NestedTable' {$ENDIF}{$IFDEF RX_D7}, 'TimeStamp'{$ENDIF});
begin
  if AType < Low(Types) then AType := Low(Types)
  else if AType > High(Types) then AType := Low(Types);
  Result := StrPas(Types[AType]);
end;

function FieldSubtypeName(ASubtype: Word): string;
const
{$IFDEF RX_D4}
  MaxSubtype = fldstADTDATE;
{$ELSE}
  MaxSubtype = fldstAUTOINC;
{$ENDIF}
  Subtypes: array [Pred(fldstMONEY)..MaxSubtype] of PChar =
    ('Password', 'Money', 'Memo', 'Binary', 'Formatted Memo', 'OLE',
     'Graphic', 'dBase OLE', 'User Typed', 'Auto Increment'
     {$IFDEF RX_D4}, 'Access OLE', 'Char', 'Unicode', 'CLOB', 'BLOB',
     'ADT (nested table)', 'BFILE', 'OCIDate' {$ENDIF});
begin
  Result := '';
  if ASubtype = fldstPASSWORD then ASubtype := Low(Subtypes)
  else begin
    if ASubtype < Low(Subtypes) + 1 then ASubtype := 0
    else if ASubtype > High(Subtypes) then ASubtype := 0;
  end;
  if ASubtype > 0 then Result := StrPas(Subtypes[ASubtype]);
end;

end.