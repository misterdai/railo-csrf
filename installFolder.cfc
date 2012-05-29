<cfcomponent>
    <cffunction name="install" returntype="struct" output="no" hint="called from Railo to install application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        
		<cfset var result = {status = true, message = ""} />
		<cfset var serverPath = expandPath('{railo-web-directory}') />
		
		<cftry>
			<cffile
				action="copy"
				source="#path#function/CsrfGenerateToken.cfm"
				destination="#serverPath#/library/function" />
			<cffile
				action="copy"
				source="#path#function/CsrfVerifyToken.cfm"
				destination="#serverPath#/library/function" />
			<cfcatch type="any">            
				<cfset result.status = false />
				<cfset result.message = cfcatch.message />
				<cflog file="railo_extension_install" text="Error: #cfcatch.message#">
			</cfcatch>			
        
	   </cftry>
	   
	   <cfreturn result />
	   
    </cffunction>
	
	
	<cffunction name="uninstall" returntype="struct" output="no" hint="called by Railo to uninstall the application">
        <cfargument name="path" type="any"/>
        <cfargument name="config" type="any"/>
        <cfscript>
			var processResult = {
				status = true,
				message = ""};
			var ssDir = "";
			var serverPath = expandPath('{railo-web-directory}');
			
			processResult.status = deleteAsset("file", "#serverPath#/function/CsrfGenerateToken.cfm");
			processResult.status = deleteAsset("file", "#serverPath#/function/CsrfVerifyToken.cfm");
		</cfscript>
		
		<cfif processResult.status>
			<cfset processResult.message = "Uninstall successful" />
		<cfelse>
			<cfset processResult.message = "Error uninstalling: Please see logs and delete manually" />
		</cfif>

		<cfreturn processResult />
	</cffunction>
	
	
	<cffunction name="deleteAsset" returntype="boolean" output="no" hint="called in the uninstall process" access="private">
		<cfargument name="type" required="true" hint="Accepts file|directory" />
		<cfargument name="asset" required="true" hint="location of asset to be removed" />

		<cfset var status = true />
		
		<cftry>
			<cfif arguments.type EQ "directory">
				<cfdirectory action="delete" directory="#arguments.asset#" recurse="true" />			
			<cfelse>
				<cffile action="delete" file="#arguments.asset#" />
			</cfif>		
			<cfcatch type="any">
				<cfset local.errMsg = "Cannot delete #arguments.type# #arguments.asset# | #cfcatch.message#" />
				<cflog file="rail_extension_csrf" text="#local.errMsg#" />
				<cfset status = false/>
			</cfcatch>
		</cftry>			
		<cfreturn status />
	</cffunction>	
	
 </cfcomponent>