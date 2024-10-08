{*******************************************************}
{                                                       }
{     Delphi VCL Extensions (RX) demo program           }
{                                                       }
{     Copyright (c) 1997 Master-Bank                    }
{                                                       }
{*******************************************************}

{$I RX.INC}

unit GIFMain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, RxPlacemnt, RxSpeedBar, Grids, RxCtrls,
  ComCtrls {$IFDEF RX_D3}, ExtDlgs {$IFNDEF CBUILDER}, Jpeg {$ENDIF} {$ENDIF},
  {$IFDEF RX_D7}Types, {$ENDIF}
  {$IFDEF RX_D16}System.UITypes, {$ENDIF}
  RxGIF, Mask, RxSpin, RxToolEdit, ImgList, RxConst;

type
  TAnimatorForm = class(TForm)
    SpeedBar: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    NewBtn: TSpeedItem;
    OpenBtn: TSpeedItem;
    SaveBtn: TSpeedItem;
    SaveAsBtn: TSpeedItem;
    InsertBtn: TSpeedItem;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    Storage: TFormStorage;
    CutBtn: TSpeedItem;
    CopyBtn: TSpeedItem;
    PasteBtn: TSpeedItem;
    DeleteBtn: TSpeedItem;
    SpeedbarSection4: TSpeedbarSection;
    AboutBtn: TSpeedItem;
    UpBtn: TSpeedItem;
    DownBtn: TSpeedItem;
    PreviewBtn: TSpeedItem;
    Pages: TPageControl;
    OptionsTab: TTabSheet;
    AnimationTab: TTabSheet;
    ImageTab: TTabSheet;
    Progress: TProgressBar;
    Bevel: TBevel;
    ImageScroll: TScrollBar;
    Frame1: TPanel;
    Frame2: TPanel;
    Frame3: TPanel;
    Frame4: TPanel;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    PaintBox4: TPaintBox;
    No1: TLabel;
    No2: TLabel;
    No3: TLabel;
    No4: TLabel;
    Status: TLabel;
    ColorDepthCombo: TComboBox;
    Label1: TLabel;
    ThumbnailsBox: TCheckBox;
    ThumbnailsLabel: TRxLabel;
    Frame1Lbl: TLabel;
    Frame2Lbl: TLabel;
    Frame3Lbl: TLabel;
    Frame4Lbl: TLabel;
    TrailingComment: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    FrameComment: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ScreenW: TLabel;
    ScreenH: TLabel;
    Label6: TLabel;
    ImageCount: TLabel;
    Bevel3: TBevel;
    BackColor: TComboEdit;
    Label7: TLabel;
    Label8: TLabel;
    FrameW: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    FrameH: TLabel;
    Label11: TLabel;
    ImageLeft: TRxSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    ImageTop: TRxSpinEdit;
    Label12: TLabel;
    DelayTime: TRxSpinEdit;
    DisposalCombo: TComboBox;
    Label13: TLabel;
    TransColor: TComboEdit;
    TransBox: TCheckBox;
    TransColorLabel: TRxLabel;
    Label14: TLabel;
    GIFVersion: TLabel;
    Bevel6: TBevel;
    FlatBtns: TCheckBox;
    AlwaysOnTop: TCheckBox;
    AlwaysOnTopLabel: TRxLabel;
    GrayscaleBtn: TSpeedItem;
    ToolbarImages: TImageList;
    RepeatCnt: TRxSpinEdit;
    LoopBox: TCheckBox;
    LoopLbl: TRxLabel;
    RepeatForever: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure ImageScrollChange(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NewBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SaveAsBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure CutBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure PasteBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ThumbnailsBoxClick(Sender: TObject);
    procedure ColorDepthComboChange(Sender: TObject);
    procedure CommentChange(Sender: TObject);
    procedure BackColorButtonClick(Sender: TObject);
    procedure TopLeftChange(Sender: TObject);
    procedure DelayTimeChange(Sender: TObject);
    procedure DisposalComboChange(Sender: TObject);
    procedure TransColorButtonClick(Sender: TObject);
    procedure TransBoxClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpeedBarDblClick(Sender: TObject);
    procedure FlatBtnsClick(Sender: TObject);
    procedure AlwaysOnTopClick(Sender: TObject);
    procedure CheckLabelMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GrayscaleBtnClick(Sender: TObject);
    procedure LoopChange(Sender: TObject);
  private
    { Private declarations }
    FImage: TGIFImage;
    FTopIndex: Integer;
    FFileName: string;
    FModified: Boolean;
    FLoading: Boolean;
    FUpdating: Boolean;
    FAborting: Boolean;
    FProgressPos: Integer;
{$IFDEF RX_D3}
    FOpenDlg: TOpenPictureDialog;
    FSaveDlg: TSavePictureDialog;
{$ELSE}
    FOpenDlg: TOpenDialog;
    FSaveDlg: TSaveDialog;
{$ENDIF}
    procedure GraphicProgress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
    procedure SetSelectedIndex(Index: Integer; Force: Boolean);
    procedure ImageChanged(Sender: TObject);
    procedure EnableButtons;
    procedure EnableTabs;
    procedure UpdateControls;
    procedure UpdateCaption;
    procedure SelectBackColor;
    procedure SelectTransColor;
    procedure ConfirmSave;
    procedure GrayscaleImage;
    procedure InvalidateImage(UpdateAll: Boolean);
  protected
    function GetPalette: HPALETTE; override;
  public
    { Public declarations }
  end;

var
  AnimatorForm: TAnimatorForm;

implementation

uses Clipbrd, RxVclUtils, RxAppUtils, RxMaxMin, RxProps, RxGraph, RxHints,
  GIFPrvw, GIFPal, About;

{$R *.DFM}

const
  SReady = 'Ready';

function EnablePaste: Boolean; near;
begin
  Result := Clipboard.HasFormat(CF_GIF) or Clipboard.HasFormat(CF_BITMAP);
end;

{ TAnimatorForm }

procedure TAnimatorForm.GraphicProgress(Sender: TObject;
  Stage: TProgressStage; PercentDone: Byte; RedrawNow: Boolean;
  const R: TRect; const Msg: string);
begin
  if Stage in [psStarting, psEnding] then begin
    FProgressPos := 0;
    Progress.Position := 0;
    Application.ProcessMessages;
  end
  else if Stage = psRunning then begin
    if PercentDone >= FProgressPos + 10 then begin
      Progress.Position := PercentDone;
      FProgressPos := PercentDone;
    end;
  end;
  if Msg <> '' then begin
    Status.Caption := Msg;
    Status.Update;
  end;
  if FLoading and FAborting then begin
    FAborting := False;
    Abort;
  end;
end;

procedure TAnimatorForm.UpdateCaption;
begin
  Caption := Application.Title;
  if (FFileName <> '') then
    Caption := Caption + ' - ' + ExtractFileName(FFileName);
end;

procedure TAnimatorForm.UpdateControls;
begin
  FUpdating := True;
  try
    ScreenW.Caption := IntToStr(FImage.ScreenWidth);
    ScreenH.Caption := IntToStr(FImage.ScreenHeight);
    ImageCount.Caption := IntToStr(FImage.Count);
    BackColor.Color := PaletteColor(FImage.BackgroundColor);
    LoopBox.Checked := FImage.Looping;
    RepeatForever.Checked := FImage.RepeatCount = 0;
    RepeatCnt.AsInteger := FImage.RepeatCount;
    TrailingComment.Lines := FImage.Comment;
    GIFVersion.Caption := string(GIFVersionName(FImage.Version));
    if FImage.FrameIndex >= 0 then begin
      with FImage.Frames[FImage.FrameIndex] do begin
        FrameComment.Lines := Comment;
        FrameW.Caption := IntToStr(Width);
        FrameH.Caption := IntToStr(Height);
        ImageLeft.AsInteger := Origin.X;
        ImageTop.AsInteger := Origin.Y;
        DelayTime.AsInteger :=
          FImage.Frames[FImage.FrameIndex].AnimateInterval div 10;
        if DisposalMethod in [dmUndefined..dmRestorePrevious] then
          DisposalCombo.ItemIndex := Ord(DisposalMethod)
        else DisposalCombo.ItemIndex := 0;
        TransBox.Checked := TransparentColor <> clNone;
        TransColor.Enabled := TransBox.Checked;
        TransColorLabel.Enabled := TransBox.Checked;
        TransColor.Color := PaletteColor(TransparentColor);
      end;
    end
    else begin
      FrameComment.Lines.Clear;
      FrameW.Caption := '';
      FrameH.Caption := '';
    end;
  finally
    FUpdating := False;
  end;
end;

function TAnimatorForm.GetPalette: HPALETTE;
begin
  Result := FImage.Palette;
  if Result = 0 then Result := inherited GetPalette;
end;

procedure TAnimatorForm.EnableButtons;
var
  IsSelected: Boolean;
begin
  IsSelected := not FImage.Empty and (FImage.FrameIndex >= 0);
  SaveBtn.Enabled := (FFileName <> '') and IsSelected;
  SaveAsBtn.Enabled := IsSelected;
  CutBtn.Enabled := IsSelected;
  CopyBtn.Enabled := IsSelected;
  DeleteBtn.Enabled := IsSelected;
  GrayscaleBtn.Enabled := not FImage.Empty;
  PasteBtn.Enabled := EnablePaste;
  UpBtn.Enabled := IsSelected and (FImage.FrameIndex > 0);
  DownBtn.Enabled := IsSelected and (FImage.FrameIndex < FImage.Count - 1);
  PreviewBtn.Enabled := IsSelected;
end;

procedure TAnimatorForm.GrayscaleImage;
begin
  if not FImage.Empty then begin
    FImage.Grayscale(True);
    FModified := True;
  end;
end;

procedure TAnimatorForm.ImageChanged(Sender: TObject);
var
  Enable: Boolean;
begin
  with ImageScroll do begin
    Min := 0;
    Max := RxMaxMin.Max(0, FImage.Count - 1);
    Enable := (Max > Min) and not FImage.Empty;
    if not Enable then ActiveControl := Pages;
    Enabled := Enable;
  end;
  SetSelectedIndex(Max(0, FImage.FrameIndex), True);
  EnableTabs;
  if not FLoading then begin
    if Active and HandleAllocated then
      PostMessage(Handle, WM_QUERYNEWPALETTE, 0, 0);
    UpdateControls;
    EnableButtons;
  end;
end;

procedure TAnimatorForm.SetSelectedIndex(Index: Integer; Force: Boolean);
var
  I: Integer;
  Labl: TLabel;
begin
  if Force or (Index <> FImage.FrameIndex) then begin
    I := FTopIndex;
    Index := Min(FImage.Count - 1, Max(Index, -1));
    if (FImage.Count > 0) then FTopIndex := Max(FTopIndex, 0);
    while (FTopIndex < Index - 3) do Inc(FTopIndex);
    if Index < FTopIndex then FTopIndex := Index;
    FImage.FrameIndex := Index;
    if FImage.FrameIndex <> ImageScroll.Position then
      ImageScroll.Position := FImage.FrameIndex;
    InvalidateImage(I <> FTopIndex);
  end;
  for I := 1 to 4 do begin
    Labl := TLabel(FindComponent(Format('Frame%dLbl', [I])));
    if Labl <> nil then
      Labl.Visible := (FTopIndex + Labl.Tag < FImage.Count) and
        (FImage.Count > 0);
    Labl := TLabel(FindComponent(Format('No%d', [I])));
    if Labl <> nil then begin
      Labl.Caption := IntToStr(FTopIndex + Labl.Tag + 1);
      Labl.Visible := (FTopIndex + Labl.Tag < FImage.Count) and
        (FImage.Count > 0);
    end;
  end;
end;

procedure TAnimatorForm.EnableTabs;
var
  Empty: Boolean;
begin
  Empty := FImage.Empty;
  AnimationTab.Enabled := not Empty;
  AnimationTab.TabVisible := not Empty;
  ImageTab.Enabled := not Empty;
  ImageTab.TabVisible := not Empty;
  if Empty then Pages.ActivePage := OptionsTab;
end;

procedure TAnimatorForm.InvalidateImage(UpdateAll: Boolean);
begin
  if not FLoading then begin
    PaintBox1.Invalidate;
    PaintBox2.Invalidate;
    PaintBox3.Invalidate;
    PaintBox4.Invalidate;
  end;
end;

procedure TAnimatorForm.SelectBackColor;
var
  AColor, NewColor: TColor;
begin
  AColor := FImage.BackgroundColor;
  NewColor := SelectColor(FImage.Palette, AColor);
  if NewColor <> AColor  then begin
    FImage.BackgroundColor := NewColor;
    FModified := True;
  end;
end;

procedure TAnimatorForm.SelectTransColor;
var
  Frame: TGIFFrame;
  AColor, NewColor: TColor;
begin
  if FImage.FrameIndex >= 0 then begin
    Frame := FImage.Frames[FImage.FrameIndex];
    AColor := Frame.TransparentColor;
    NewColor := SelectColor(FImage.Palette, AColor);
    if NewColor <> AColor then begin
      Frame.TransparentColor := NewColor;
      FModified := True;
    end;
  end
  else Beep;
end;

procedure TAnimatorForm.ConfirmSave;
var
  Res: TModalResult;
begin
  if FModified then begin
    Res := MessageDlg('Save changes to current animation?', mtWarning,
      [mbYes, mbNo, mbCancel], 0);
    case Res of
      mrYes: SaveBtnClick(nil);
      mrCancel: Abort;
    end;
  end;
end;

procedure TAnimatorForm.FormCreate(Sender: TObject);
begin
  { Registry settings }
  RegUseAppTitle := True;
  DefCompanyName := 'RX';
  { Initialization }
  //ToolbarImages.ResourceLoad(rtBitmap, 'TOOLBAR_IMAGES', clFuchsia);
  SetHintStyle(hsRectangle, 3, False, taCenter);
  UpdateCaption;
  FTopIndex := -1;
  FImage := TGIFImage.Create;
  EnableTabs;
  EnableButtons;
  ColorDepthCombo.ItemIndex := Ord(DefaultMappingMethod);
{$IFDEF RX_D3}
  FOpenDlg := TOpenPictureDialog.Create(Self);
  FSaveDlg := TSavePictureDialog.Create(Self);
{$ELSE}
  FOpenDlg := TOpenDialog.Create(Self);
  FSaveDlg := TSaveDialog.Create(Self);
{$ENDIF}
  with FOpenDlg do begin
    Name := 'OpenDialog';
    Options := [ofHideReadOnly, ofFileMustExist];
    DefaultExt := GraphicExtension(TGIFImage);
    Filter := GraphicFilter(TGraphic);
  end;
  with FSaveDlg do begin
    Name := 'SaveDialog';
    Options := [ofHideReadOnly, ofOverwritePrompt];
    DefaultExt := GraphicExtension(TGIFImage);
    Filter := GraphicFilter(TGIFImage);
  end;
  { Add dialogs to storage }
  with Storage.StoredProps do begin
    AddObject(CreateStoredItem(FOpenDlg.Name, 'InitialDir'), FOpenDlg);
    AddObject(CreateStoredItem(FSaveDlg.Name, 'InitialDir'), FSaveDlg);
  end;
  Application.OnActivate := FormActivate;
  FImage.OnProgress := GraphicProgress;
  FImage.OnChange := ImageChanged;
  Status.Caption := SReady;
  FModified := False;
end;

procedure TAnimatorForm.FormDestroy(Sender: TObject);
begin
  FImage.Free;
end;

procedure TAnimatorForm.FormActivate(Sender: TObject);
begin
  PasteBtn.Enabled := EnablePaste;
end;

procedure TAnimatorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ConfirmSave;
end;

procedure TAnimatorForm.PreviewBtnClick(Sender: TObject);
begin
  PreviewGIF(FImage);
end;

procedure TAnimatorForm.OpenBtnClick(Sender: TObject);
begin
  ConfirmSave;
  FOpenDlg.Filter := GraphicFilter(TGIFImage);
  try
    if FOpenDlg.Execute then begin
      StartWait;
      FLoading := True;
      try
        FOpenDlg.InitialDir := ExtractFilePath(FOpenDlg.FileName);
        Status.Caption := 'Press <Esc> to cancel';
        Application.ProcessMessages;
        try
          FImage.LoadFromFile(FOpenDlg.FileName);
          FImage.DecodeAllFrames;
          FModified := FImage.Corrupted;
        except
          FImage.Clear;
          FFileName := '';
          raise;
        end;
        FFileName := FOpenDlg.FileName;
        UpdateControls;
      finally
        FLoading := False;
        FAborting := False;
        FModified := FImage.Corrupted;
        StopWait;
        Status.Caption := SReady;
        InvalidateImage(True);
        UpdateCaption;
        EnableButtons;
      end;
    end;
  finally
    FOpenDlg.Filter := GraphicFilter(TGraphic);
  end;
end;

procedure TAnimatorForm.PaintBoxPaint(Sender: TObject);
var
  ImageIndex, Size: Integer;
  W, H, L, T: Integer;
  DrawRect: TRect;
  Frame: TGIFFrame;
begin
  ImageIndex := FTopIndex + TPaintBox(Sender).Tag;
  if (ImageIndex >= 0) and (ImageIndex < FImage.Count) then begin
    DrawRect := TPaintBox(Sender).ClientRect;
    Frame := FImage.Frames[ImageIndex];
    with TPaintBox(Sender).Canvas do begin
      if ImageIndex = FImage.FrameIndex then begin
        Pen.Color := clActiveCaption;
        Pen.Width := 3;
        with DrawRect do Rectangle(Left, Top, Right, Bottom);
      end;
      InflateRect(DrawRect, -3, -3);
      if ThumbnailsBox.Checked then begin
        W := FImage.ScreenWidth;
        H := FImage.ScreenHeight;
        L := Frame.Origin.X;
        T := Frame.Origin.Y;
      end
      else begin
        W := Frame.Width;
        H := Frame.Height;
        L := 0;
        T := 0;
      end;
      if (W <= WidthOf(DrawRect)) and
        (H <= HeightOf(DrawRect)) then
      begin
        DrawRect := Bounds(L, T, Frame.Width, Frame.Height);
      end
      else begin
        Size := DrawRect.Top + MulDiv(H, WidthOf(DrawRect), W);
        if Size > DrawRect.Bottom then begin
          L := MulDiv(L, HeightOf(DrawRect), H);
          T := MulDiv(T, HeightOf(DrawRect), H);
          W := MulDiv(Frame.Width, HeightOf(DrawRect), H);
          H := MulDiv(Frame.Height, HeightOf(DrawRect), H);
          DrawRect := Bounds(L, T, W, H);
        end
        else begin
          L := MulDiv(L, WidthOf(DrawRect), W);
          T := MulDiv(T, WidthOf(DrawRect), W);
          H := MulDiv(Frame.Height, WidthOf(DrawRect), W);
          W := MulDiv(Frame.Width, WidthOf(DrawRect), W);
          DrawRect := Bounds(L, T, W, H);
        end;
      end;
      OffsetRect(DrawRect, 3, 3);
      Frame.Draw(TPaintBox(Sender).Canvas, DrawRect, False);
    end;
  end;
end;

procedure TAnimatorForm.ImageScrollChange(Sender: TObject);
begin
  SetSelectedIndex(ImageScroll.Position, False);
end;

procedure TAnimatorForm.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ImageIndex: Integer;
begin
  if (FImage.Count > 0) then begin
    if ImageScroll.Enabled then ActiveControl := ImageScroll;
    ImageIndex := FTopIndex + TPaintBox(Sender).Tag;
    if (ImageIndex >= 0) and (ImageIndex < FImage.Count) then
      SetSelectedIndex(ImageIndex, True);
  end;
end;

procedure TAnimatorForm.NewBtnClick(Sender: TObject);
begin
  ConfirmSave;
  if not FImage.Empty then FImage.Clear;
  FFileName := '';
  UpdateCaption;
  Status.Caption := SReady;
  FModified := False;
end;

procedure TAnimatorForm.SaveBtnClick(Sender: TObject);
begin
  if FFileName = '' then SaveAsBtnClick(Sender)
  else begin
    StartWait;
    try
      FImage.SaveToFile(FFileName);
      FModified := False;
    finally
      StopWait;
      Status.Caption := SReady;
    end;
  end;
end;

procedure TAnimatorForm.SaveAsBtnClick(Sender: TObject);
begin
  if FFileName <> '' then begin
    FSaveDlg.FileName := FFileName;
    FSaveDlg.InitialDir := ExtractFilePath(FSaveDlg.FileName);
  end;
  if not FImage.Empty and FSaveDlg.Execute then begin
    Application.ProcessMessages;
    StartWait;
    try
      FSaveDlg.InitialDir := ExtractFilePath(FSaveDlg.FileName);
      FImage.SaveToFile(FSaveDlg.FileName);
      FModified := False;
      FFileName := FSaveDlg.FileName;
      UpdateCaption;
    finally
      StopWait;
      Status.Caption := SReady;
    end;
  end;
end;

procedure TAnimatorForm.InsertBtnClick(Sender: TObject);
var
  Pic: TPicture;
begin
  if FOpenDlg.Execute then begin
    Application.ProcessMessages;
    StartWait;
    Pic := TPicture.Create;
    try
      FOpenDlg.InitialDir := ExtractFilePath(FOpenDlg.FileName);
{$IFDEF RX_D3}
      Pic.OnProgress := GraphicProgress;
{$ENDIF}
      Pic.LoadFromFile(FOpenDlg.FileName);
      if (Pic.Graphic <> nil) and not Pic.Graphic.Empty then begin
        FImage.AddFrame(Pic.Graphic);
        FModified := True;
        ImageChanged(FImage);
        StartWait;
        try
          FImage.EncodeAllFrames;
        finally
          StopWait;
        end;
      end;
    finally
      Pic.Free;
      StopWait;
      Status.Caption := SReady;
    end;
  end;
end;

procedure TAnimatorForm.PasteBtnClick(Sender: TObject);
var
  Temp: TPicture;
begin
  if not EnablePaste then Exit;
  Temp := TPicture.Create;
  try
    Temp.Assign(Clipboard);
    if (Temp.Graphic <> nil) and not Temp.Graphic.Empty then begin
      FImage.AddFrame(Temp.Graphic);
      FModified := True;
      ImageChanged(FImage);
      StartWait;
      try
        FImage.EncodeAllFrames;
      finally
        StopWait;
      end;
    end;
  finally
    Temp.Free;
    Status.Caption := SReady;
  end;
end;

procedure TAnimatorForm.CutBtnClick(Sender: TObject);
begin
  CopyBtnClick(Sender);
  DeleteBtnClick(Sender);
end;

procedure TAnimatorForm.CopyBtnClick(Sender: TObject);
var
  Temp: TGIFImage;
begin
  if not FImage.Empty and (FImage.FrameIndex >= 0) then begin
    Temp := TGIFImage.Create;
    try
      Temp.Assign(FImage.Frames[FImage.FrameIndex]);
      Clipboard.Assign(Temp);
      PasteBtn.Enabled := EnablePaste;
    finally
      Temp.Free;
    end;
  end;
end;

procedure TAnimatorForm.DeleteBtnClick(Sender: TObject);
begin
  if FImage.FrameIndex >= 0 then begin
    FImage.DeleteFrame(FImage.FrameIndex);
    FModified := True;
  end;
end;

procedure TAnimatorForm.UpBtnClick(Sender: TObject);
begin
  if FImage.FrameIndex > 0 then begin
    FImage.MoveFrame(FImage.FrameIndex, FImage.FrameIndex - 1);
    FModified := True;
  end;
end;

procedure TAnimatorForm.DownBtnClick(Sender: TObject);
begin
  if (FImage.FrameIndex >= 0) and (FImage.FrameIndex < FImage.Count - 1) then
  begin
    FImage.MoveFrame(FImage.FrameIndex, FImage.FrameIndex + 1);
    FModified := True;
  end;
end;

procedure TAnimatorForm.AboutBtnClick(Sender: TObject);
begin
  ShowAbout('RX GIF Image Format Support', 'RX Library Demo Program',
    1, 1, 1998);
end;

procedure TAnimatorForm.ThumbnailsBoxClick(Sender: TObject);
begin
  InvalidateImage(True);
end;

procedure TAnimatorForm.ColorDepthComboChange(Sender: TObject);
begin
  DefaultMappingMethod := TMappingMethod(ColorDepthCombo.ItemIndex);
end;

procedure TAnimatorForm.BackColorButtonClick(Sender: TObject);
begin
  SelectBackColor;
end;

procedure TAnimatorForm.TransColorButtonClick(Sender: TObject);
begin
  SelectTransColor;
end;

procedure TAnimatorForm.LoopChange(Sender: TObject);
begin
  RepeatForever.Enabled := LoopBox.Checked;
  LoopLbl.Enabled := RepeatForever.Enabled;
  RepeatCnt.Enabled := LoopLbl.Enabled;
  if not (FLoading or FUpdating) then begin
    if Sender <> RepeatForever then
      RepeatForever.Checked := RepeatCnt.AsInteger = 0;
    if RepeatForever.Checked then
      FImage.RepeatCount := 0
    else
      FImage.RepeatCount := RepeatCnt.AsInteger;
    FImage.Looping := LoopBox.Checked;
    FModified := True;
  end;
end;

procedure TAnimatorForm.CommentChange(Sender: TObject);
begin
  if not (FLoading or FUpdating) then begin
    if (Sender = FrameComment) and (FImage.FrameIndex >= 0) then
      FImage.Frames[FImage.FrameIndex].Comment := FrameComment.Lines
    else if Sender = TrailingComment then
      FImage.Comment := TrailingComment.Lines;
    FModified := True;
  end;
end;

procedure TAnimatorForm.TopLeftChange(Sender: TObject);
begin
  if not (FLoading or FUpdating) and (FImage.FrameIndex >= 0) then begin
    FImage.Frames[FImage.FrameIndex].Origin := Point(ImageLeft.AsInteger,
      ImageTop.AsInteger);
    FModified := True;
  end;
end;

procedure TAnimatorForm.DelayTimeChange(Sender: TObject);
begin
  if not (FLoading or FUpdating) and (FImage.FrameIndex >= 0) then begin
    FImage.Frames[FImage.FrameIndex].AnimateInterval := DelayTime.AsInteger * 10;
    FModified := True;
  end;
end;

procedure TAnimatorForm.DisposalComboChange(Sender: TObject);
begin
  if not (FLoading or FUpdating) and (FImage.FrameIndex >= 0) then begin
    if DisposalCombo.ItemIndex >= 0 then begin
      FImage.Frames[FImage.FrameIndex].DisposalMethod :=
        TDisposalMethod(DisposalCombo.ItemIndex);
      FModified := True;
    end;
  end;
end;

procedure TAnimatorForm.TransBoxClick(Sender: TObject);
begin
  TransColor.Enabled := TransBox.Checked;
  TransColorLabel.Enabled := TransBox.Checked;
  if not (FLoading or FUpdating) and (FImage.FrameIndex >= 0) then begin
    if not TransBox.Checked then begin
      FImage.Frames[FImage.FrameIndex].TransparentColor := clNone;
      FModified := True;
    end;
  end;
end;

procedure TAnimatorForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) and FLoading then begin
    FAborting := True;
    Key := #0;
  end;
end;

procedure TAnimatorForm.SpeedBarDblClick(Sender: TObject);
begin
  Speedbar.Customize(0);
end;

procedure TAnimatorForm.FlatBtnsClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    Speedbar.Options := Speedbar.Options + [sbFlatBtns]
  else
    Speedbar.Options := Speedbar.Options - [sbFlatBtns];
end;

procedure TAnimatorForm.AlwaysOnTopClick(Sender: TObject);
begin
  if AlwaysOnTop.Checked then
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
      SWP_NOSIZE or SWP_NOACTIVATE)
  else
    SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
      SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TAnimatorForm.CheckLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and not (ssDouble in Shift) then begin
    if TRxLabel(Sender).FocusControl.CanFocus then
      ActiveControl := TRxLabel(Sender).FocusControl;
    if (TRxLabel(Sender).FocusControl is TCheckBox) then
      with TCheckBox(TRxLabel(Sender).FocusControl) do
        if Enabled then Checked := not Checked;
  end;
end;

procedure TAnimatorForm.GrayscaleBtnClick(Sender: TObject);
begin
  GrayscaleImage;
end;

end.