Class Demo.Hotels.Tables.Sentence Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Entities As %List [ Calculated, ReadOnly, SqlComputeCode = {new tEntOccData,tEntOcc,tMaxEntOcc,tEntity,tList  set tList="", tEntOccData = $g(^IRIS.IK.SentDetails(3,{SentenceId})),tEntOcc=$lg(tEntOccData,4),tMaxEntOcc=tEntOcc+$lg(tEntOccData,5),tEntOccData=""  for { set tEntOcc=$o(^IRIS.IK.EntOccId(3,tEntOcc),1,tEntOccData)  quit:tEntOcc=""  quit:tEntOcc>tMaxEntOcc  set tEntity=$lg(tEntOccData,1)  set:tEntity tList=tList_$lb(tEntity) }  set {*} = tList}, SqlComputed ];

Property LanguageConfidence As %Numeric [ ReadOnly ];

Property LanguageId As %Integer(MINVAL = 1) [ ReadOnly ];

Property Parts As %List [ Calculated, ReadOnly, SqlComputeCode = {new tSentData,tPartId,tMinPartId,tMaxPartId,tList  set tList="", tSentData = $g(^IRIS.IK.SentDetails(3,{SentenceId})),tMinPartId=$lg(tSentData,4)+1,tMaxPartId=tMinPartId+$lg(tSentData,5)-1,tSentData=""  for tPartId=tMinPartId:1:tMaxPartId { set tList=tList_$lb(tPartId) }  set {*} = tList}, SqlComputed ];

Property Position As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = ##class(%iKnow.Queries.SentenceAPI).GetPosition(3,{SentenceId})}, SqlComputed ];

Property SentenceId As %Integer(MINVAL = 1) [ ReadOnly ];

Property SentenceValue As %String(COLLATION = "SQLUPPER(150)", MAXLEN = "") [ Calculated, ReadOnly, SqlComputeCode = {set {*} = ##class(%iKnow.Queries.SentenceAPI).GetValue(3,{SentenceId})}, SqlComputed ];

Property Source As Source [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {SourceId}}, SqlComputed ];

Property SourceId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = ##class(%iKnow.Queries.SentenceAPI).GetSourceId(3,{SentenceId})}, SqlComputed ];

Property SummaryRelevance As %Numeric [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %EntUniToSent On Entities(KEYS) [ Type = bitmap ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %SentenceId On SentenceId [ IdKey, PrimaryKey, Unique ];

Index SentExtent [ Extent, Type = bitmap ];

ClassMethod EntitiesBuildValueArray(pEntities As %List, Output pArray As %String) As %Status
{
	set tSC = $$$OK
	try {
		kill pArray
		set ptr = 0
		while $listnext(pEntities,ptr,tElement) {
			continue:'tElement
			set pArray(tElement) = $g(^IRIS.IK.EntUniId(3,tElement))
		}
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

ForeignKey %SourceFK(SourceId) References Demo.Hotels.Tables.Source() [ NoCheck ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>LanguageId</Value>
</Value>
<Value name="2">
<Value>LanguageConfidence</Value>
</Value>
<Value name="3">
<Value>SummaryRelevance</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.SentDetails(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.SentDetails(3)</IdLocation>
<Index name="%EntUniToSent">
<Location>^IRIS.IK.EntUniToSentBit(3)</Location>
</Index>
<IndexLocation>^IRIS.IK.Idx.Sent(3)</IndexLocation>
<StreamLocation>^Demo.Hotels.Tables.SentenceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

