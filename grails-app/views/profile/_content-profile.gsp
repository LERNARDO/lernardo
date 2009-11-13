<div id="yui-main">
  <div class="yui-b">
    <div id="profile-content">
      <table width="100%">
        <g:if test="${type == 'betreiber'}">
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${plz}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${ort}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${strasse}</td></tr>
          <tr><td class="bold titles bezeichnung">Gemeinnützigkeit:</td><td class="bezeichnung">${gemeinnutzigkeit}</td></tr>
          <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${ansprechperson}</td></tr>
        </g:if>
        <g:elseif test="${type == 'client'}">
          <tr><td class="bold titles bezeichnung">Vorname:</td><td class="bezeichnung">${firstName}</td></tr>
          <tr><td class="bold titles bezeichnung">Nachname:</td><td class="bezeichnung">${lastName}</td></tr>
          <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${birthDate}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${plz}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${ort}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${strasse}</td></tr>
          <tr><td class="bold titles bezeichnung">E-Mail:</td><td class="bezeichnung">${mail}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${tel}</td></tr>
          <tr><td class="bold titles bezeichnung">Schule:</td><td class="bezeichnung">${schule}</td></tr>
          <tr><td class="bold titles bezeichnung">Klasse:</td><td class="bezeichnung">${klasse}</td></tr>
        </g:elseif>
        <g:elseif test="${profileInstance.type.supertype.name == 'Facility'}">
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${profileInstance.profile.fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${profileInstance.profile.PLZ}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${profileInstance.profile.city}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${profileInstance.profile.street}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${profileInstance.profile.tel}</td></tr>
          <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${profileInstance.profile.speaker}</td></tr>
          <tr><td class="bold titles bezeichnung">Öffnungszeiten:</td><td class="bezeichnung">${profileInstance.profile.opened}</td></tr>
          <tr><td class="bold titles bezeichnung">Beschreibung:</td><td class="bezeichnung">${profileInstance.profile.description}</td></tr>
        </g:elseif>
        <g:elseif test="${type == 'mitarbeiter'}">
          <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${title}</td></tr>
          <tr><td class="bold titles bezeichnung">Vorname:</td><td class="bezeichnung">${firstName}</td></tr>
          <tr><td class="bold titles bezeichnung">Nachname:</td><td class="bezeichnung">${lastName}</td></tr>
          <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${birthDate}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${plz}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${ort}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${strasse}</td></tr>
          <tr><td class="bold titles bezeichnung">E-Mail:</td><td class="bezeichnung">${mail}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${tel}</td></tr>
        </g:elseif>
        <g:elseif test="${type == 'paed'}">
          <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${title}</td></tr>
          <tr><td class="bold titles bezeichnung">Vorname:</td><td class="bezeichnung">${firstName}</td></tr>
          <tr><td class="bold titles bezeichnung">Nachname:</td><td class="bezeichnung">${lastName}</td></tr>
          <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${birthDate}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${plz}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${ort}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${strasse}</td></tr>
          <tr><td class="bold titles bezeichnung">E-Mail:</td><td class="bezeichnung">${mail}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${tel}</td></tr>
          <tr><td class="bold titles bezeichnung">Lebenslauf:</td><td class="bezeichnung">${lebenslauf}</td></tr>
        </g:elseif>
      </table>
      <br/>
      <g:isLoggedIn>
          <g:link style="color:#a00; font-weight: bold;" action="edit" id="#">Profil bearbeiten</g:link>
    </g:isLoggedIn>
%{--<g:form>
<input type="hidden" name="id" value="${name}" />
<span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
</g:form>--}%
    </div><!--profile-content-->
  </div><!--yui-b-->
</div><!--yui-main-->