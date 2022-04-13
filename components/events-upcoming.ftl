<#--  Generate the HTML structure of an upcoming events list   -->
<#--  select subject, view_href, occasion_data.start_time, labels from messages where board.id='events'  -->

<#assign board = env.context.component.getParameter("board")/>

<#--  accept values such as "upcoming"  -->
<#attempt>
  <#assign filter = env.context.component.getParameter("filter")/>  
<#recover>
  <#assign filter="">
</#attempt>

<#--  filter on label  -->
<#attempt>
  <#assign label = env.context.component.getParameter("label")/>  
<#recover>
  <#assign label="">
</#attempt>

<#attempt>
  <#assign size= env.context.component.getParameter("size")/>
<#recover>
 <#assign size="5">
</#attempt>

<#--  Build the filters to add into the LIQL statement  -->
<#assign time_filter = ""/>  
<#if filter != "">
   <#assign time_filter = "AND occasion_data.status = '${filter}'"/>
</#if> 

<#assign label_filter = ""/>  
<#if label != "">
   <#assign label_filter = "AND labels.text MATCHES('${label}')"/>
</#if> 
  
<#assign board_href = "#"/>

<#assign boardq = rest("2.0", "/search?q=" + "select view_href from boards where id='${board}' and conversation_style='occasion'"?url)/>
<#if boardq.data?? && boardq.data.items?? && boardq.data.items?size gt 0>
 <#assign board_href = "${boardq.data.items[0].view_href}"/>
</#if>

<#assign events = rest("2.0", "/search?q=" + 
   "select subject, view_href, occasion_data.start_time, labels from messages where board.id='${board}' ${label_filter} ${time_filter} AND depth=0 order by occasion_data.start_time ASC LIMIT ${size}"?url 
     )/>

<#include "common-content-macros" />
<@liaCustomPanel key="upcomingevents" additionalClasses="upcomingevents" viewAll="${board_href}">
<div class="events-list">
  <ul class="events">
    <#if  events.data?? &&  events.data.items??>   
    <#list events.data.items as event >  
        <li class="event">
        <span class="event-title"><a href="${event.view_href}">${event.subject}</a></span> | <span class="event-date">${event.occasion_data.start_time?datetime?string("dd-MMM-yyyy")}</span> 
        <div class="event-labels">
    <#if event.labels?? && event.labels.query??>
    <#assign labels = rest("2.0", "/search?q=" + "${event.labels.query}"?url )/>
    <ul>
      <#list labels.data.items as label>
       <#assign labellink = "${board_href}/label-name/${label.text?url}"/>
       <li class="label"><a class="label-link" href="${labellink}">${label.text?html}</a></li>
      </#list>
    </ul>  
    </#if>             
        </div>
        </li>
    </#list>
    </#if>  
  </ul>
</div>     
</@liaCustomPanel>