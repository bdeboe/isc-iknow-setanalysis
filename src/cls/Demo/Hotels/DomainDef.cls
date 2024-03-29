Class Demo.Hotels.DomainDef Extends %iKnow.DomainDefinition
{

/// <p>An XML representation of the domain this class defines.</p>
/// <p>For a detailed reference of the available elements and attributes, consult the class
/// reference for <class>%iKnow.Model.domain</class> and other classes in the <package>%iKnow.Model</package>
/// package.</p>
XData Domain [ XMLNamespace = "http://www.intersystems.com/iknow" ]
{
<domain name="Hotel reviews" objectsPackage="Demo.Hotels.Tables">
<userDictionary name="HotelReviewSentiment">
<entry rewriteFrom="friendly" assignLabel="UDPosSentiment" />
<entry rewriteFrom="wonderful" assignLabel="UDPosSentiment" />
<entry rewriteFrom="superb" assignLabel="UDPosSentiment" />
<entry rewriteFrom="good" assignLabel="UDPosSentiment" />
<entry rewriteFrom="love" assignLabel="UDPosSentiment" />
<entry rewriteFrom="loves" assignLabel="UDPosSentiment" />
<entry rewriteFrom="loved" assignLabel="UDPosSentiment" />
<entry rewriteFrom="well" assignLabel="UDPosSentiment" />
<entry rewriteFrom="comfortable" assignLabel="UDPosSentiment" />
<entry rewriteFrom="nice" assignLabel="UDPosSentiment" />
<entry rewriteFrom="ideally" assignLabel="UDPosSentiment" />
<entry rewriteFrom="recommend" assignLabel="UDPosSentiment" />
<entry rewriteFrom="excellent" assignLabel="UDPosSentiment" />
<entry rewriteFrom="fantastic" assignLabel="UDPosSentiment" />
<entry rewriteFrom="concenient" assignLabel="UDPosSentiment" />
<entry rewriteFrom="pleasant" assignLabel="UDPosSentiment" />
<entry rewriteFrom="great" assignLabel="UDPosSentiment" />
<entry rewriteFrom="amazing" assignLabel="UDPosSentiment" />
<entry rewriteFrom="clean" assignLabel="UDPosSentiment" />
<entry rewriteFrom="helpful" assignLabel="UDPosSentiment" />
<entry rewriteFrom="fabulous" assignLabel="UDPosSentiment" />
<entry rewriteFrom="efficient" assignLabel="UDPosSentiment" />
<entry rewriteFrom="attentive" assignLabel="UDPosSentiment" />
<entry rewriteFrom="caring" assignLabel="UDPosSentiment" />
<entry rewriteFrom="professional" assignLabel="UDPosSentiment" />
<entry rewriteFrom="clean" assignLabel="UDPosSentiment" />
<entry rewriteFrom="comfy" assignLabel="UDPosSentiment" />
<entry rewriteFrom="clean" assignLabel="UDPosSentiment" />

<entry rewriteFrom="hated" assignLabel="UDNegSentiment" />
<entry rewriteFrom="annoyed" assignLabel="UDNegSentiment" />
<entry rewriteFrom="annoying" assignLabel="UDNegSentiment" />
<entry rewriteFrom="disappointed" assignLabel="UDNegSentiment" />
<entry rewriteFrom="expensive" assignLabel="UDNegSentiment" />
<entry rewriteFrom="uncomfortable" assignLabel="UDNegSentiment" />
<entry rewriteFrom="difficult" assignLabel="UDNegSentiment" />
<entry rewriteFrom="nasty" assignLabel="UDNegSentiment" />
<entry rewriteFrom="disgusting" assignLabel="UDNegSentiment" />
<entry rewriteFrom="jammed" assignLabel="UDNegSentiment" />
<entry rewriteFrom="inconvenient" assignLabel="UDNegSentiment" />
<entry rewriteFrom="rotten" assignLabel="UDNegSentiment" />
<entry rewriteFrom="irritating" assignLabel="UDNegSentiment" />
<entry rewriteFrom="dirty" assignLabel="UDNegSentiment" />
<entry rewriteFrom="hopeless" assignLabel="UDNegSentiment" />
<entry rewriteFrom="horrendous" assignLabel="UDNegSentiment" />
<entry rewriteFrom="horrible" assignLabel="UDNegSentiment" />

<entry rewriteFrom="min." rewriteTo="\noend" />
</userDictionary>
<configuration name="HotelReviewConfig" languages="en" userDictionary="HotelReviewSentiment" />
<parameter name="$$$IKPDEFAULTCONFIG"  value="HotelReviewConfig" />
<metadata>
<field name="Author" />
<field name="StayType" />
<field name="StayMonth" />
</metadata>
<data>
<table tableName="Demo_Hotels.Review" idField="ID" groupField="Hotelname" dataFields="Reviewfull"
metadataFields="Author,StayType,StayMonth" whereClause="reviewtext is not null"
metadataColumns="Authorname,StayType,StayMonth" />
</data>
<blacklist name="SimpleTerms">
<entry>hotel</entry>
<entry>guest</entry>
</blacklist>
</domain>
}

}
