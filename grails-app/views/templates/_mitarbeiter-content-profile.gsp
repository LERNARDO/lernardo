<div id="yui-main">
  <div class="yui-b">
    <div id="profile-content">
      <table width="100%">
        <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${profileInstance.title}</td></tr>
        <tr><td class="bold titles bezeichnung">Vorname:</td><td class="bezeichnung">${profileInstance.firstName}</td></tr>
        <tr><td class="bold titles bezeichnung">Nachname:</td><td class="bezeichnung">${profileInstance.lastName}</td></tr>
        <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${profileInstance.birthDate}</td></tr>
        <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${profileInstance.plz}</td></tr>
        <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${profileInstance.ort}</td></tr>
        <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${profileInstance.strasse}</td></tr>
        <tr><td class="bold titles bezeichnung">E-Mail:</td><td class="bezeichnung">${profileInstance.mail}</td></tr>
        <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${profileInstance.tel}</td></tr>
      </table>
%{--<g:form>
<input type="hidden" name="id" value="${name}" />
<span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
</g:form>--}%
    </div><!--profile-content-client"-->
  </div><!--yui-b-->
</div><!--yui-main-->