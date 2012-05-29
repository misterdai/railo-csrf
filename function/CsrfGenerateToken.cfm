<cffunction name="CsrfGenerateToken" output="false" returntype="string">
  <cfargument name="key" type="string" required="false" default="" />
  <cfargument name="random" type="string" required="false" default="false" />
  <cfscript>
    var lc = StructNew();
    lc.csrfKey = '_csrfTokens';
    if (Not StructKeyExists(session, lc.csrfKey)) {
      session[lc.csrfKey] = StructNew();
    }
    if (arguments.random Or Not StructKeyExists(session[lc.csrfKey], arguments.key)) {
      lc.token = Now();
      // Throw in the datetime for a little more randomisation
      lc.times = 3;
      // Combinations = 65536^lc.times
      // e.g. 65536^3 = 281,474,976,710,656 possible values to pick from
      // This should be secure enough as the value is either per
      // generation (random=true) or only lives for the session lifetime
      for (lc.i = 1; lc.i Lte lc.times; lc.i = lc.i + 1) {
        lc.token = lc.token & RandRange(0, 65535, "SHA1PRNG");
      }
      // Hash the token, trim to 40 characters (20-bytes), upper case
      lc.token = UCase(Left(Hash(lc.token, "SHA-256"), 40));
      session[lc.csrfKey][arguments.key] = lc.token;
    }
    return session[lc.csrfKey][arguments.key];
  </cfscript>
</cffunction>