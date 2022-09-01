Class Demo.Hotels.Tables.PathAttribute Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property AttributeTypeId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Parts As %List [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $li($g(^IRIS.IK.PathToEntOcc(3,{PathId})),{StartPosInPath},{StartPosInPath}+{SpanInPath}-1)}, SqlComputed ];

Property Path As Path [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {PathId}}, SqlComputed ];

Property PathId As %Integer(MINVAL = 1) [ ReadOnly ];

Property SpanInPath As %Integer(MINVAL = 1) [ ReadOnly ];

Property StartPosInPath As %Integer(MINVAL = 1) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %PathAttribute On (PathId, AttributeTypeId, StartPosInPath) [ IdKey, PrimaryKey, Unique ];

ForeignKey %PathFK(PathId) References Path() [ NoCheck ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>SpanInPath</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.Att.Path(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.Att.Path(3)</IdLocation>
<IndexLocation>^IRIS.IK.Idx.ATP(3)</IndexLocation>
<StreamLocation>^Demo.Hotels6B2A.PathAttributeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

