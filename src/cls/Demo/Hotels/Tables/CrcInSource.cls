Class Demo.Hotels.Tables.CrcInSource Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property CrcUniId As %Integer(MINVAL = 1) [ ReadOnly ];

Property CrcUnique As CrcUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {CrcUniId}}, SqlComputed ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Dominance As %Numeric [ ReadOnly ];

Property Frequency As %Integer(MINVAL = 0) [ ReadOnly ];

Property Source As Source [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {SourceId}}, SqlComputed ];

Property SourceId As %Integer(MINVAL = 1) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcInSource On (SourceId, CrcUniId) [ IdKey, PrimaryKey, Unique ];

ForeignKey %CrcUniFK(CrcUniId) References CrcUnique() [ NoCheck ];

ForeignKey %SourceFK(SourceId) References Source() [ NoCheck ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>Frequency</Value>
</Value>
<Value name="2">
<Value>Dominance</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.CrcSrcDetails(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.CrcSrcDetails(3)</IdLocation>
<IndexLocation>^IRIS.IK.Idx.CSD(3)</IndexLocation>
<StreamLocation>^Demo.Hotels.Ta6B2A.CrcInSourceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

