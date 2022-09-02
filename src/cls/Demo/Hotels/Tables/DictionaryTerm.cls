Class Demo.Hotels.Tables.DictionaryTerm Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property DefaultLanguage As %String(MAXLEN = 150) [ ReadOnly ];

Property Dictionary As Dictionary [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {DictionaryId}}, SqlComputed ];

Property DictionaryId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DictionaryItem As DictionaryItem [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {DictionaryItemId}}, SqlComputed ];

Property DictionaryItemId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DictionaryTermId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property StringValue As %String(MAXLEN = "") [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %DictionaryTermId On DictionaryTermId [ IdKey, PrimaryKey, Unique ];

Index DictTermExtent [ Extent, Type = bitmap ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>DictionaryId</Value>
</Value>
<Value name="2">
<Value>DictionaryItemId</Value>
</Value>
<Value name="3">
<Value>StringValue</Value>
</Value>
<Value name="4">
<Value>DefaultLanguage</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.Mat.DictTermId(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.Mat.DictTermId(3)</IdLocation>
<IndexLocation>^IRIS.IK.Idx.MDT(3)</IndexLocation>
<StreamLocation>^Demo.Hotels6B2A.DictionaryTermS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

