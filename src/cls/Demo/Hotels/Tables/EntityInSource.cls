Class Demo.Hotels.Tables.EntityInSource Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property DominanceAsConcept As %Numeric [ ReadOnly ];

Property DominanceAsRelation As %Numeric [ ReadOnly ];

Property EntUniId As %Integer(MINVAL = 1) [ ReadOnly ];

Property Entity As EntityUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {EntUniId}}, SqlComputed ];

Property Frequency As %Integer(MINVAL = 0) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {FrequencyAsConcept} + {FrequencyAsRelation}}, SqlComputed ];

Property FrequencyAsConcept As %Integer(MINVAL = 0) [ ReadOnly ];

Property FrequencyAsRelation As %Integer(MINVAL = 0) [ ReadOnly ];

Property Source As Source [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {SourceId}}, SqlComputed ];

Property SourceId As %Integer(MINVAL = 1) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %EntityInSource On (SourceId, EntUniId) [ IdKey, PrimaryKey, Unique ];

ForeignKey %EntUniFK(EntUniId) References EntityUnique() [ NoCheck ];

ForeignKey %SourceFK(SourceId) References Source() [ NoCheck ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>FrequencyAsConcept</Value>
</Value>
<Value name="2">
<Value>FrequencyAsRelation</Value>
</Value>
<Value name="3">
<Value>DominanceAsConcept</Value>
</Value>
<Value name="4">
<Value>DominanceAsRelation</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.EntSrcDetails(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.EntSrcDetails(3)</IdLocation>
<IndexLocation>^IRIS.IK.Idx.ESD(3)</IndexLocation>
<StreamLocation>^Demo.Hotels6B2A.EntityInSourceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

