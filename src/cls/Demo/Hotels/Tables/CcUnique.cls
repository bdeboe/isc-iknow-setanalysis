Class Demo.Hotels.Tables.CcUnique Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property CcUniId As %Integer(MINVAL = 1) [ ReadOnly ];

Property CorpusFrequency As %Integer(MINVAL = 0) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $lg($g(^IRIS.IK.CcUniDet(3,{CcUniId})),1)}, SqlComputed ];

Property CorpusSpread As %Integer(MINVAL = 0) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $lg($g(^IRIS.IK.CcUniDet(3,{CcUniId})),2)}, SqlComputed ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Head As EntityUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {HeadId}}, SqlComputed ];

Property HeadId As %Integer(MINVAL = 0) [ ReadOnly ];

Property Tail As EntityUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {TailId}}, SqlComputed ];

Property TailId As %Integer(MINVAL = 0) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CcUni On (HeadId, TailId) [ Type = key, Unique ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CcUniExists [ Extent, Type = bitmap ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CcUniId On CcUniId [ IdKey, PrimaryKey, Unique ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CcUniIdFreq On (CorpusFrequency As Minus, CcUniId);

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CcUniIdSpread On (CorpusSpread As Minus, CcUniId);

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %EntUniMToCcUniBit On HeadId [ Type = bitmap ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %EntUniSToCcUniBit On TailId [ Type = bitmap ];

ForeignKey %HeadFK(HeadId) References EntityUnique() [ NoCheck ];

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
<Value>TailId</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.CcUniId(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.CcUniId(3)</IdLocation>
<Index name="%CcUni">
<Location>^IRIS.IK.CcUni(3)</Location>
</Index>
<Index name="%CcUniExists">
<Location>^IRIS.IK.CcUniExistsBit(3)</Location>
</Index>
<Index name="%CcUniIdFreq">
<Location>^IRIS.IK.CcUniIdFreq(3)</Location>
</Index>
<Index name="%CcUniIdSpread">
<Location>^IRIS.IK.CcUniIdSpread(3)</Location>
</Index>
<Index name="%EntUniMToCcUniBit">
<Location>^IRIS.IK.EntUniMToCcUniBit(3)</Location>
</Index>
<Index name="%EntUniSToCcUniBit">
<Location>^IRIS.IK.EntUniSToCcUniBit(3)</Location>
</Index>
<IndexLocation>^IRIS.IK.Idx.CCU(3)</IndexLocation>
<StreamLocation>^Demo.Hotels.Tables.CcUniqueS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

