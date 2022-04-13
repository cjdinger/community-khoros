<#macro liaCustomPanel key="" additionalClasses="" viewAll="">
<div class="lia-panel lia-panel-standard <#if key?trim?has_content> custom-component-${key}</#if> ${additionalClasses!""}">
  <div class="lia-decoration-border">
    <div class="lia-decoration-border-top">
      <div></div>
    </div>
    <div class="lia-decoration-border-content">
      <div>
        <div class="lia-panel-heading-bar-wrapper">
          <div class="lia-panel-heading-bar">
            <span class="lia-panel-heading-bar-title"><#if key?trim?has_content >${text.format("custom.component.${key}.title")}</#if></span>
          </div>
        </div>
        <div class="lia-panel-content-wrapper">
          <div class="lia-panel-content">
<#nested>	  
            <#if viewAll?? && viewAll?trim?has_content>
            <div class="lia-view-all">
              <a class="lia-link-navigation" href="${viewAll!""}">${text.format("general.View_All")}</a>
            </div>
            </#if>
          </div>
        </div>
      </div>
    </div>
    <div class="lia-decoration-border-bottom">
      <div></div>
    </div>
  </div>
</div>
</#macro>

<#-- macro: displayDateTime
	Used to display the date and time in a format similar to the standard behavior. If relative (friendly) dates
		are enabled, it will attempt to display a relative date. Otherwise, the standard date and time format
		will be used.
	param: date  - The post_time element returned from the REST API
	usage: <@displayDateTime date=message.post_time />
-->
<#macro displayDateTime date>
<span class="DateTime">
	<#if date.@view_friendly_date[0]?? && date.@view_friendly_date != "">
	<span title="${date.@view_date!""} ${date.@view_time!""}" class="local-friendly-date">
		${date.@view_friendly_date!""}
	</span>
	<#else>
	<span class="local-date">${date.@view_date!""}</span>
	<span class="local-time">${date.@view_time!""}</span>	
	</#if>
</span>
</#macro>

<#function firstXChars charsNo textValue ellipses>
       <#assign returnVal = "" />
        <#attempt>
        <#assign textValue = utils.html.stripper.from.gdata.strip(textValue) />
        <#assign maxChars = charsNo?number />
        <#if textValue?length < maxChars>
           <#assign returnVal = textValue />
        <#else>
           <#if ellipses = "yes"><#assign returnVal = textValue?substring(0,maxChars-3) + "..." /><#else><#assign returnVal = textValue?substring(0,maxChars) /></#if>
        </#if>
        <#recover>
           <#assign returnVal = utils.html.stripper.from.gdata.strip(textValue) />
        </#attempt>
        <#return returnVal />
</#function>