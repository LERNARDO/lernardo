<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Profil von ${entity.profile.fullName}</title>
  <g:javascript library="jquery"/>
</head>
<body>
<div class="headerBlue">
  <h1>Mein Profil</h1>
</div>
<div class="boxGray">
<table width="100%">
  <g:if test="${entity.type.name == 'Operator' || entity.type.name == 'Sponsor'}">
    <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
    <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
    <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
    <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
    <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${entity.profile.speaker.profile.fullName}</td></tr>
    <tr><td class="bold titles bezeichnung">Beschreibung:</td><td class="bezeichnung">${entity?.profile?.description?.decodeHTML()}</td></tr>
  </g:if>
  <g:elseif test="${entity.type.name == 'Hort' || entity.type.name == 'School'}">
    <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
    <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
    <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
    <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
    <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
    <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${entity.profile.speaker.profile.fullName}</td></tr>
    <tr><td class="bold titles bezeichnung">Öffnungszeiten:</td><td class="bezeichnung">${entity.profile.opened}</td></tr>
    <tr><td class="bold titles bezeichnung">Beschreibung:</td><td class="bezeichnung">${entity?.profile?.description?.decodeHTML()}</td></tr>
  </g:elseif>
  <g:elseif test="${entity.type.name == 'User'}">
    <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${entity.profile.title}</td></tr>
    <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
    <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung"><g:formatDate format="dd. MM. yyyy" date="${entity.profile.birthDate}"/></td></tr>
    <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
    <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
    <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
    <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
    <tr><td class="bold titles bezeichnung">Geschlecht:</td><td class="bezeichnung"><app:showGender gender="${entity.profile.gender}"/></td></tr>
    <tr><td class="bold titles bezeichnung">Biographie:</td><td class="bezeichnung">${entity?.profile?.biography?.decodeHTML()}</td></tr>
  </g:elseif>
  <g:elseif test="${entity.type.name == 'Paed'}">
    <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${entity.profile.title}</td></tr>
    <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
    <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung"><g:formatDate format="dd. MM. yyyy" date="${entity.profile.birthDate}"/></td></tr>
    <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
    <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
    <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
    <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
    <tr><td class="bold titles bezeichnung">Geschlecht:</td><td class="bezeichnung"><app:showGender gender="${entity.profile.gender}"/></td></tr>
    <tr><td class="bold titles bezeichnung">Lebenslauf:</td><td class="bezeichnung">${entity?.profile?.biography?.decodeHTML()}</td></tr>
    <tr><td class="bold titles bezeichnung">Betreute Horte:</td><td class="bezeichnung">${horte} <ub:isAdmin><g:link action="changeFacilities" params="[name:entity.name]">[ändern]</g:link></ub:isAdmin></td></tr>
  </g:elseif>
  <g:elseif test="${entity.type.name == 'Client'}">
    <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${entity.profile.fullName}</td></tr>
    <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung"><g:formatDate format="dd. MM. yyyy" date="${entity.profile.birthDate}"/></td></tr>
    <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${entity.profile.PLZ}</td></tr>
    <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${entity.profile.city}</td></tr>
    <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${entity.profile.street}</td></tr>
    <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${entity.profile.tel}</td></tr>
    <tr><td class="bold titles bezeichnung">Geschlecht:</td><td class="bezeichnung"><app:showGender gender="${entity.profile.gender}"/></td></tr>
  </g:elseif>
</table>
</div>
</body>