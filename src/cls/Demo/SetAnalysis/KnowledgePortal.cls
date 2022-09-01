Class Demo.SetAnalysis.KnowledgePortal Extends %iKnow.UI.KnowledgePortal
{

/// Subclasses can override this method to supply custom filter types to be displayed
/// in the filter type dropdown in the following format:
/// pCustomFilterTypes(typeName) = typeLabel
ClassMethod GetCustomFilterTypes(Output pCustomFilterTypes) As %Status
{
	kill pCustomFilterTypes
	set pCustomFilterTypes("set") = "Sets"
	quit $$$OK
}

/// Subclasses can override this method to draw the input fields specific to a custom
/// filter type added through <method>GetCustomFilterTypes</method>.
/// <var>pSettings</var> is the string capturing user input, as assembled by <method>getCustomFilterSettings</method>.
Method DrawCustomFilterInputs(pFilterType As %String, pSettings As %String) As %Status
{
	// sample code:
	if (pFilterType = "set") {
		write !,"<select id=""selCustomFilterSetting"" class=""form-control input-sm"" required=""true"" >"
		
		set tRS = ##class(%SQL.Statement).%ExecDirect(,"SELECT %ID, Name FROM Demo_SetAnalysis.SetDefinition WHERE DomainID = "_..domain)
		while tRS.%Next() {
			write !,"<option value=""",tRS.%GetData(1),""">",$zcvt(tRS.%GetData(2),"O","HTML"),"</option>"
		}
		
		write !,"</select>"
		quit $$$OK
	} else {
		quit $$$ERROR($$$GeneralError, "Unknown custom filter type: '"_pFilterType_"'")
	}
}

/// Subclasses can override this method to pick up the values of the input fields
/// specific to a custom filter type as draw in <method>DrawCustomFilterIntputs</method>
/// and concatenate them into a settings string.
ClientMethod getCustomFilterSettings(filterType) [ Language = javascript ]
{
	// sample code:
	if (filterType=='set') {
		return $('#selCustomFilterSetting').val();
	}
	return '';
}

/// Subclasses can override this method to instantiate an actual <class>%iKnow.Filters.Filter</class> 
/// object based on the supplied settings.
/// <var>pSettings</var> is the string capturing user input, as assembled by <method>getCustomFilterSettings</method>.
Method CreateCustomFilter(pFilterType As %String, pSettings As %String) As %iKnow.Filters.Filter
{
	// sample code:
	if (pFilterType="set") {
		set tSetDef = ##class(Demo.SetAnalysis.SetDefinition).%OpenId(pSettings)
		quit:tSetDef="" ""
		quit tSetDef.GetSDFilter()
	} 
	quit ""
}

}

