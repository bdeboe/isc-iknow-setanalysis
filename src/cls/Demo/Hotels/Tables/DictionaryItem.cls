Class Demo.Hotels.Tables.DictionaryItem Extends (%Persistent, %iKnow.Tables.AbstractTable) [ Final, Inheritance = right, ProcedureBlock, StorageStrategy = iKnowStorage ]
{

Parameter DOMAINID = 3;

Property DefaultLanguage As %String(MAXLEN = 150) [ ReadOnly ];

Property Dictionary As Dictionary [ Calculated, ReadOnly, SqlComputeCode = {set {*} = {DictionaryId}}, SqlComputed ];

Property DictionaryId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DictionaryItemId As %Integer(MINVAL = 1) [ ReadOnly ];

Property DomainId As %Integer(MINVAL = 1) [ Calculated, ReadOnly, SqlComputeCode = {set {*} = 3}, SqlComputed ];

Property Name As %String(MAXLEN = 1000) [ ReadOnly ];

Property Terms As %List [ Calculated, ReadOnly, SqlComputeCode = {set {*} = $g(^IRIS.IK.Mat.DictItemTerms(193,{DictionaryItemId}))}, SqlComputed ];

Property URI As %String(COLLATION = "EXACT", MAXLEN = 150) [ ReadOnly ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %DictItemURI On URI [ Type = key, Unique ];

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %DictToItem On DictionaryId;

/// This index is maintained automatically by iKnow. DO NOT MODIFY
Index %DictionaryItemId On DictionaryItemId [ IdKey, PrimaryKey, Unique ];

Index DictItemExtent [ Extent, Type = bitmap ];

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
<Value>Name</Value>
</Value>
<Value name="3">
<Value>URI</Value>
</Value>
<Value name="4">
<Value>DefaultLanguage</Value>
</Value>
</Data>
<DataLocation>^IRIS.IK.Mat.DictItemId(3)</DataLocation>
<DefaultData>CustomData</DefaultData>
<IdLocation>^IRIS.IK.Mat.DictItemId(3)</IdLocation>
<Index name="%DictItemURI">
<Location>^IRIS.IK.Mat.DictItemURI(3)</Location>
</Index>
<Index name="%DictToItem">
<Location>^IRIS.IK.Mat.DictToItem(3)</Location>
</Index>
<IndexLocation>^IRIS.IK.Idx.MDI(3)</IndexLocation>
<StreamLocation>^Demo.Hotels6B2A.DictionaryItemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

