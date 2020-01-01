unit er.model.concretephotos;

{$mode objfpc}{$H+}
{$LongStrings on}

interface

uses
  Classes,
  SysUtils,
  ExtCtrls,
  er.model.abstractphotos,
  RegExpr;

type
  TConcretePhotos = class ( TPhotoGetter  )
    procedure GetPhotos( Ref : string; ListOfUrls : TStrings ) ; override;
  end;

implementation

procedure TConcretePhotos.GetPhotos(Ref: string; ListOfUrls: TStrings);
var
  pageHTML : ansistring;
  re       : TRegExpr;
begin
  try
    pageHTML := http.SimpleGet( Ref ) ;
  except
    exit;
  end;

  { Regular Expression for Validation }

  re := TRegExpr.Create('http[s]{1}\:\/\/+[\w\d\.\/\-]{1,}\.jpg');
  if re.Exec(pageHTML) then
  begin
    ListOfUrls.Add( StringReplace( re.Match[0],'src="', '', [rfReplaceAll, rfIgnoreCase] ) );
    while re.ExecNext do
    begin
     ListOfUrls.Add( StringReplace( re.Match[0],'src="', '', [rfReplaceAll, rfIgnoreCase] ) );
    end;
  end;
  ListOfUrls.SaveToFile('lista.txt');
end;

end.
