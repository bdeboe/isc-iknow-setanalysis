Class Demo.Hotels.Tables.CrcOccurrence Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property CcUniId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {n crc  set crc = $g(^IRIS.IK.CrcUniId(3,{CrcUniId})), {*} = $g(^IRIS.IK.CcUni(3,+$lg(crc,1),+$lg(crc,3)))}, SqlComputed ];

Property CcUnique As CcUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {CcUniId}}, SqlComputed ];

Property CrcOccId As %Integer(MINVAL = 1) [ ReadOnly ];

Property CrcUniId As %Integer(MINVAL = 1) [ ReadOnly ];

Property CrcUnique As CrcUnique [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {CrcUniId}}, SqlComputed ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property HeadOccId As %Integer(MINVAL = 1) [ ReadOnly ];

Property PosInSentence As %Integer(MINVAL = 1) [ ReadOnly ];

Property RelationOccId As %Integer(MINVAL = 1) [ ReadOnly ];

Property Sentence As Sentence [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {SentenceId}}, SqlComputed ];

Property SentenceId As %Integer(MINVAL = 1) [ ReadOnly ];

Property Source As Source [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {SourceId}}, SqlComputed ];

Property SourceId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = ##class(%iKnow.Queries.SentenceAPI).GetSourceId(3,{SentenceId})}, SqlComputed ];

Property TailOccId As %Integer(MINVAL = 1) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CcUniToOccBit On CcUniId [ Type = bitmap ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcOccId On CrcOccId [ IdKey, PrimaryKey, Unique ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %CrcUniToOccBit On CrcUniId [ Type = bitmap ];

Index CrcOccExtent [ Extent, Type = bitmap ];

ForeignKey %CrcUniFK(CrcUniId) References CrcUnique() [ NoCheck ];

ForeignKey %EntOccHFK(HeadOccId) References Demo.Hotels.Tables.Part() [ NoCheck ];

ForeignKey %EntOccRFK(RelationOccId) References Demo.Hotels.Tables.Part() [ NoCheck ];

ForeignKey %EntOccTFK(TailOccId) References Demo.Hotels.Tables.Part() [ NoCheck ];

ForeignKey %SentenceFK(SentenceId) References Sentence() [ NoCheck ];

ForeignKey %SourceFK(SourceId) References Source() [ NoCheck ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>CrcUniId</Value>
</Value>
<Value name="2">
<Value>HeadOccId</Value>
</Value>
<Value name="3">
<Value>RelationOccId</Value>
</Value>
<Value name="4">
<Value>TailOccId</Value>
</Value>
<Value name="5">
<Value>SentenceId</Value>
</Value>
<Value name="6">
<Value>PosInSentence</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.CrcOccId(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.CrcOccId(3)</IdLocation>
<Index name="%CcUniToOccBit">
<Location>^IRIS.IK.CcUniToOccBit(3)</Location>
</Index>
<Index name="%CrcUniToOccBit">
<Location>^IRIS.IK.CrcUniToOccBit(3)</Location>
</Index>
<IndexLocation>^IRIS.IK.Idx.CRCO(3)</IndexLocation>
<StreamLocation>^Demo.Hotels6B2A.CrcOccurrenceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

