<div id="yui-main">
  <div class="yui-b">
    <div id="profile-content">
      <table width="100%">
        <g:if test="${entity.type.name == 'Operator'}">
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
          <tr><td class="bold titles bezeichnung">Gemeinnützigkeit:</td><td class="bezeichnung">${entity.profile.description}</td></tr>
          <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${entity.profile.speaker}</td></tr>
        </g:if>
        <g:elseif test="${entity.type.name == 'Client'}">
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${entity.profile.birthDate}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
        </g:elseif>
        <g:elseif test="${entity.type.name == 'Hort'}">
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
          <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${entity.profile.speaker}</td></tr>
          <tr><td class="bold titles bezeichnung">Öffnungszeiten:</td><td class="bezeichnung">${entity.profile.opened}</td></tr>
          <tr><td class="bold titles bezeichnung">Beschreibung:</td><td class="bezeichnung">${entity.profile.description}</td></tr>
        </g:elseif>
        <g:elseif test="${entity.type.name == 'User'}">
          <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${entity.profile.title}</td></tr>
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${entity.profile.birthDate}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
          <tr><td class="bold titles bezeichnung">Biographie:</td><td class="bezeichnung">${entity.profile.biography}</td></tr>
        </g:elseif>
        <g:elseif test="${entity.type.name == 'Paed'}">
          <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${entity.profile.title}</td></tr>
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${entity.profile.birthDate}</td></tr>
          <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
          <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
          <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
          <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
          <tr><td class="bold titles bezeichnung">Lebenslauf:</td><td class="bezeichnung">${entity.profile.biography}</td></tr>
        </g:elseif>
      </table>
      <br/>
      <ub:meOrAdmin entityName="${entity.name}">
          <g:link style="color:#a00; font-weight: bold;" action="edit" id="#">Profil bearbeiten</g:link>
      </ub:meOrAdmin>
%{--<g:form>
<input type="hidden" name="id" value="${name}" />
<span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
</g:form>--}%
    </div><!--profile-content-->
  </div><!--yui-b-->
</div><!--yui-main-->