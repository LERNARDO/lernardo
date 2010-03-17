<%--
  User: mkuhl
  Date: 08.11.2009
  Time: 21:51:55

  renders a list of profiles
  params are:
    cssclass
    title
    emptyMsg
    entities
--%>

<div class="${cssclass}">
     <div class="head">${title}</div>
     <div class="content">

       <g:if test="${entities.size() == 0}">
         <p>${emptyMsg}</p>
       </g:if>

       <g:each in="${entities}" var="entity">
         <div class="member">

           <div class="member-pic">
             <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">
               <ub:profileImage name="${entity.name}" width="50" height="50" align="left"/>
             </g:link>
           </div>

           <div class="member-info">
             <div class="member-name"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link></div>
             <div class="member-uni">${entity.type.name}</div>
           </div>
           
           %{--<div class="clear"></div>--}%
         </div>
       </g:each>

       <div class="spacer"></div>
     </div>
   </div>