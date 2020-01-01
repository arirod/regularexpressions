unit er.model.abstractphotos;

{$mode delphi} {$H+}
{$LongStrings ON}

interface

uses
  Classes,
  SysUtils,
  ExtCtrls,
  fphttpclient;

type
  { iPhotoGetter }
  iPhotoGetter = interface
    ['{2D5CA912-EF33-4BB2-8AC6-486644FF8515}']
    procedure GetPhotos(Ref : string; ListOfUrls : TStrings);
   end;

  { TPhotoGetter }
  TPhotoGetter = class(TInterfacedObject, IPhotoGetter)
  protected
    http : TFPHTTPClient ;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetPhotos(Ref : string; ListOfUrls : TStrings); virtual; abstract;
  end;

implementation

constructor TPhotoGetter.Create;
begin
  http := TFPHTTPClient.Create(nil);
end;

destructor TPhotoGetter.Destroy;
begin
  http.Free;
  inherited Destroy;
end;


end.
