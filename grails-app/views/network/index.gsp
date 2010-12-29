<head>
  <title>Netzwerk</title>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="headerBlue">
  <div class="second">
    <h1>Netzwerk</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="yui-g" id="members">

      <g:render template="memberList" model="[cssclass:'myfriends', title:'Meine Freunde',
                emptyMsg:'Du hast derzeit noch keine Freunde', entities:friendsList]"/>

      <erp:isEducator entity="${entity}">
        <ub:notAdmin>
          <g:render template="memberList" model="[cssclass:'myemployers', title:'Meine Betreuten',
                emptyMsg:'Du hast derzeit noch keine Betreuten!', entities:clientsList]"/>
          <g:render template="memberList" model="[cssclass:'myemployers', title:'Meine Einrichtungen',
                emptyMsg:'Du hast derzeit noch keine Einrichtungen!', entities:facilitiesList]"/>
        </ub:notAdmin>
      </erp:isEducator>

      <g:render template="memberList" model="[cssclass:'mymemberships', title:'Meine Bookmarks',
                emptyMsg:'Du hast derzeit noch keine Bookmarks!', entities:bookmarksList]"/>

      <erp:isFacility entity="${entity}">
        <ub:notAdmin>
          <g:render template="memberList" model="[cssclass:'mymemberships', title:'Meine Betreiber',
                    emptyMsg:'Du hast derzeit noch keine Betreiber!', entities:operatorsList]"/>
        </ub:notAdmin>
      </erp:isFacility>

      <erp:isClient entity="${entity}">
        <ub:notAdmin>
          <g:render template="memberList" model="[cssclass:'mymemberships', title:'Meine Einrichtungen',
                    emptyMsg:'Du hast derzeit noch keine Einrichtungen!', entities:facilities2List]"/>
        </ub:notAdmin>
      </erp:isClient>

    </div>
  </div>
</div>
</body>