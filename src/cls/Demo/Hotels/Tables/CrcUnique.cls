Class Demo.Hotels.Tables.CrcUnique Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property CcUniId As %Integer(MINVAL = 0) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $g(^IRIS.IK.CcUni(3,+{HeadId},+{TailId}))}, SqlComputed ];

Property CcUnique As CcUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {CcUniId}}, SqlComputed ];

Property CorpusDominance As %Numeric [ Calculated, ReadOnly, SqlComputeCode = {set {*} = ##class(%iKnow.Semantics.DominanceAPI).GetDomainValue(3,{CrcUniId},$$$SDCRC)}, SqlComputed ];

Property CorpusFrequency As %Integer(MINVAL = 0) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $lg($g(^IRIS.IK.CrcUniDetails(3,{CrcUniId})),1)}, SqlComputed ];

Property CorpusSpread As %Integer(MINVAL = 0) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $lg($g(^IRIS.IK.CrcUniDetails(3,{CrcUniId})),2)}, SqlComputed ];

Property CrcUniId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Entities As %List [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $g(^IRIS.IK.CrcUniId(3,{CrcUniId}))}, SqlComputed ];

Property Head As EntityUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {HeadId}}, SqlComputed ];

Property HeadId As %Integer(MINVAL = 0) [ ReadOnly ];

Property Relation As EntityUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {RelationId}}, SqlComputed ];

Property RelationId As %Integer(MINVAL = 0) [ ReadOnly ];

Property Tail As EntityUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {TailId}}, SqlComputed ];

Property TailId As %Integer(MINVAL = 0) [ ReadOnly ];

Property Value As %String(MAXLEN = "") [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $s({HeadId}:##class(EntityUnique).%OpenId({HeadId},0).EntityValue, 1:"") _ " ~ " _ $s({RelationId}:##class(EntityUnique).%OpenId({RelationId},0).EntityValue, 1:"") _ " ~ " _ $s({TailId}:##class(EntityUnique).%OpenId({TailId},0).EntityValue, 1:"")}, SqlComputed ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcUni On (HeadId, RelationId, TailId) [ Type = key, Unique ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcUniExists [ Extent, Type = bitmap ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcUniId On CrcUniId [ IdKey, PrimaryKey, Unique ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcUniIdFreq On (CorpusFrequency As Minus, CrcUniId);

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcUniIdSpread On (CorpusSpread As Minus, CrcUniId);

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %EntUniMToCrcUniBit On HeadId [ Type = bitmap ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %EntUniRToCrcUniBit On RelationId [ Type = bitmap ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %EntUniSToCrcUniBit On TailId [ Type = bitmap ];

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

ForeignKey %CcUniqueFK(CcUniId) References Demo.Hotels.Tables.CcUnique() [ NoCheck ];

ForeignKey %HeadFK(HeadId) References EntityUnique() [ NoCheck ];

ForeignKey %RelationFK(RelationId) References EntityUnique() [ NoCheck ];

ForeignKey %TailFK(TailId) References EntityUnique() [ NoCheck ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>HeadId</Value>
</Value>
<Value name="2">
<Value>RelationId</Value>
</Value>
<Value name="3">
<Value>TailId</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.CrcUniId(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.CrcUniId(3)</IdLocation>
<Index name="%CrcUni">
<Location>^IRIS.IK.CrcUni(3)</Location>
</Index>
<Index name="%CrcUniExists">
<Location>^IRIS.IK.CrcUniExistsBit(3)</Location>
</Index>
<Index name="%CrcUniIdFreq">
<Location>^IRIS.IK.CrcUniIdFreq(3)</Location>
</Index>
<Index name="%CrcUniIdSpread">
<Location>^IRIS.IK.CrcUniIdSpread(3)</Location>
</Index>
<Index name="%EntUniMToCrcUniBit">
<Location>^IRIS.IK.EntUniMToCrcUniBit(3)</Location>
</Index>
<Index name="%EntUniRToCrcUniBit">
<Location>^IRIS.IK.EntUniRToCrcUniBit(3)</Location>
</Index>
<Index name="%EntUniSToCrcUniBit">
<Location>^IRIS.IK.EntUniSToCrcUniBit(3)</Location>
</Index>
<IndexLocation>^IRIS.IK.Idx.CRCU(3)</IndexLocation>
<StreamLocation>^Demo.Hotels.Tables.CrcUniqueS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

