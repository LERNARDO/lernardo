<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Lernardo | Profilbild hochladen</title>
    %{--<meta name="layout" content="test" />--}%
  </head>
  <body>
  <g:uploadForm controller="asset" action="putprf">
    <div class="dialog">
      <fieldset>
        <legend>Asset Upload</legend>
        <table>
          <colgroup>
            <col class="labelcol"/>
            <col class="fieldcol"/>
          </colgroup>
          <tr>
            <td>Datei</td>
            <td><input type="file" name="asset"></td>
          </tr>
        </table>
      </fieldset>
      <g:submitButton name="submit" value="Upload"/>
    </div>
  </g:uploadForm>
  </body>
</html>