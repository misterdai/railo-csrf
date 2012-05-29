<cffunction name="CsrfVerifyToken" output="false" returntype="boolean">
  <cfargument name="token" type="string" required="true" />
  <cfargument name="key" type="string" required="false" default="" />
  <cfscript>
    var csrfKey = '_csrfTokens';
    if (StructKeyExists(session, csrfKey)
      And StructKeyExists(session[csrfKey], arguments.key)
      And session[csrfKey][arguments.key] Eq arguments.token) {
      return true;
    }
    return false;
  </cfscript>
</cffunction>