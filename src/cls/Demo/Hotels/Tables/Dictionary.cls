Class Demo.Hotels.Tables.Dictionary Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property DefaultLanguage As %String(MAXLEN = 150) [ ReadOnly ];

Property Description As %String(MAXLEN = "") [ ReadOnly ];

Property DictionaryId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Name As %String(MAXLEN = 1000) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %DictName On Name [ Type = key, Unique ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %DictionaryId On DictionaryId [ IdKey, PrimaryKey, Unique ];

Index DictExtent [ Extent, Type = bitmap ];

Storage iKnowStorage
{
<Data name="CustomData">
<Subscript>"c"</Subscript>
</Data>
<Data name="iKnowSystemData">
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>Description</Value>
</Value>
<Value name="3">
<Value>DefaultLanguage</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.Mat.DictId(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.Mat.DictId(3)</IdLocation>
<Index name="%DictName">
<Location>^IRIS.IK.Mat.Dict(3)</Location>
</Index>
<IndexLocation>^IRIS.IK.Idx.MD(3)</IndexLocation>
<StreamLocation>^Demo.Hotels.Tables.DictionaryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

