<% import grails.persistence.Event %>
<%=packageName%>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
    <div id="show-${domainClass.propertyName}" class="content" role="main">
      <div class="page-header">
        <h2><g:message code="default.show.label" args="[entityName]" /></h2>
      </div>
      <g:if test="\${flash.message}">
      <div class="message" role="status">\${flash.message}</div>
      </g:if>
      <ol class="property-list ${domainClass.propertyName}">
      <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
        allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
        props.each { p -> %>
        <g:if test="\${${propertyName}?.${p.name}}">
        <li class="fieldcontain">
          <span id="${p.name}-label" class="property-label"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></span>
          <%  if (p.isEnum()) { %>
            <span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></span>
          <%  } else if (p.oneToMany || p.manyToMany) { %>
            <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
            <span class="property-value" aria-labelledby="${p.name}-label"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></span>
            </g:each>
          <%  } else if (p.manyToOne || p.oneToOne) { %>
            <span class="property-value" aria-labelledby="${p.name}-label"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></span>
          <%  } else if (p.type == Boolean || p.type == boolean) { %>
            <span class="property-value" aria-labelledby="${p.name}-label"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></span>
          <%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
            <span class="property-value" aria-labelledby="${p.name}-label"><g:formatDate date="\${${propertyName}?.${p.name}}" /></span>
          <%  } else if(!p.type.isArray()) { %>
            <span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></span>
          <%  } %>
        </li>
        </g:if>
      <%  } %>
      </ol>
      <g:form>
        <fieldset class="buttons actions">
          <g:hiddenField name="id" value="\${${propertyName}?.id}" />
          <g:link class="list btn" action="list"><g:message code="default.back" /></g:link></li>
          <g:link class="edit btn primary" action="edit" id="\${${propertyName}?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="delete btn danger" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
	</body>
</html>
