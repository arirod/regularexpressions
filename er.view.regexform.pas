unit er.view.regexform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls,
  IdHTTP;

type

  { TRegularExpressionsForm }

  TRegularExpressionsForm = class(TForm)
    btnGetPhotos: TButton;
    edtReference: TLabeledEdit;
    imagePhoto: TImage;
    edtBaseURL: TLabeledEdit;
    listBoxPhoto: TListBox;
    StatusBar1: TStatusBar;
    procedure btnGetPhotosClick(Sender: TObject);
    procedure listBoxPhotoDblClick(Sender: TObject);
  private

  public

  end;

var
  RegularExpressionsForm: TRegularExpressionsForm;

implementation

{$R *.lfm}

uses
 er.model.concretephotos;

//*****************  { Thanks ShowDelphi }  ********************
procedure GetImageByUrl(URL: string; APicture: TPicture);
var
  jpegImage: TJPEGImage;
  stream: TMemoryStream;
  http : TIdHTTP;
begin
  Screen.Cursor := crHourGlass;
  jpegImage := TJPEGImage.Create;
  stream    := TMemoryStream.Create;
  http      := TIdHTTP.Create(nil);
  try
    http.Get(URL, stream);
    if (stream.Size > 0) then
    begin
      stream.Position := 0;
      jpegImage.LoadFromStream(stream);
      APicture.Assign(jpegImage);
    end;
  finally
    stream.Free;
    jpegImage.Free;
    http.Free;
    Screen.Cursor := crDefault;
  end;
end;


//*************************************************
procedure RemoveDuplicates(AListBox:TListBox);
var
  i:integer;
begin
  with AListBox do
    for i := Items.Count - 1 downto 0 do
      if Items.IndexOf(Items[i]) < i then
        Items.Delete(i);
end;
//*************************************************

{ TRegularExpressionsForm }
procedure TRegularExpressionsForm.btnGetPhotosClick(Sender: TObject);
var
  aRef   : string;
  Photos : TConcretePhotos;
begin
  aRef:= Concat( edtBaseURL.Text, edtReference.Text );
  //aRef := 'https://br.pinterest.com/ldp5446/alias/';
  Photos := TConcretePhotos.Create;
  Photos.GetPhotos( aRef, listBoxPhoto.Items);
  RemoveDuplicates(listBoxPhoto);
end;

procedure TRegularExpressionsForm.listBoxPhotoDblClick(Sender: TObject);
begin
 GetImageByUrl( listBoxPhoto.Items[listBoxPhoto.ItemIndex] , imagePhoto.Picture);
end;

end.


