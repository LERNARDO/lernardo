<div id="yui-main">
  <div class="yui-b">
    <div id="profile-content">
      <table width="100%">
        <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${profileInstance.fullName}</td></tr>
        <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${profileInstance.plz}</td></tr>
        <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${profileInstance.ort}</td></tr>
        <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${profileInstance.strasse}</td></tr>
        <tr><td class="bold titles bezeichnung">Gemeinnützigkeit:</td><td class="bezeichnung">${profileInstance.gemeinnutzigkeit}</td></tr>
        <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${profileInstance.ansprechperson}</td></tr>
      </table>
%{--<g:form>
<input type="hidden" name="id" value="${name}" />
<span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
</g:form>--}%
    </div><!--profile-content-client"-->
  </div><!--yui-b-->
</div><!--yui-main-->