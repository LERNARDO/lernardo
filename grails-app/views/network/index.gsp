  <head>
    <title>Lernardo | Netzwerk</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
  </head>

  <body>
  <div class="headerBlue">
  <h1>Netzwerk</h1>
</div>
  <div class="boxGray">
    <div class="yui-g" id="members">

        <g:if test="${friendsList}">
          <g:render template="memberList" model="[cssclass:'myfriends', title:'Meine Freunde',
                    emptyMsg:'noch keine Freunde', entities:friendsList]"/>
        </g:if>
        <g:else>
          <p>Du hast derzeit noch keine Freunde!</p>
        </g:else>

        <g:if test="${clientsList}">
          <g:render template="memberList" model="[cssclass:'myemployers', title:'Meine Betreuten',
                    emptyMsg:'noch keine Betreuten', entities:clientsList]"/>
        </g:if>
        <g:else>
          <p>Du hast derzeit noch keine Betreuten!</p>
        </g:else>

        <g:if test="${bookmarksList}">
          <g:render template="memberList" model="[cssclass:'mymemberships', title:'Meine Bookmarks',
                    emptyMsg:'noch keine Bookmarks', entities:bookmarksList]"/>
        </g:if>
        <g:else>
          <p>Du hast derzeit noch keine Bookmarks!</p> 
        </g:else>

    </div><!-- END yui-g -->
    </div>
  </body>