Class Demo.Hotels.Tables.SentenceAttribute Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property AttributeTypeId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Parts As %List [ Calculated, ReadOnly, SqlComputeCode = {new tPartBase,tSentPos,tList,tAttData  set tPartBase = $lg($g(^IRIS.IK.SentDetails(3,{SentenceId})),4),tList="",tAttData=$g(^IRIS.IK.Att.Sent(3,{SentenceId},{AttributeTypeId},{StartPosInSent})) for tSentPos=0:1:{SpanInSent}-1 { set:$ld(tAttData,tSentPos+2) tList=tList_$lb(tPartBase+{StartPosInSent}+tSentPos) }  set {*} = tList}, SqlComputed ];

Property Sentence As Sentence [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {SentenceId}}, SqlComputed ];

Property SentenceId As %Integer(MINVAL = 1) [ ReadOnly ];

Property SpanInSent As %Integer(MINVAL = 1) [ ReadOnly ];

Property StartPosInSent As %Integer(MINVAL = 1) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %SentenceAttribute On (SentenceId, AttributeTypeId, StartPosInSent) [ IdKey, PrimaryKey, Unique ];

ForeignKey %SentenceFK(SentenceId) References Sentence() [ NoCheck ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>SpanInSent</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.Att.Sent(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.Att.Sent(3)</IdLocation>
<IndexLocation>^IRIS.IK.Idx.ATS(3)</IndexLocation>
<StreamLocation>^Demo.Hotel6B2A.SentenceAttCA0AS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

