Include %IKPublic

Class Demo.SetAnalysis.Utils
{

/// <p>Sets up your SetAnalysis demo, based on the data in column <var>pDataColumn</var> in table
/// <var>pTableName</var>, using columns <var>pMetadataColumns</var> as additional metadata fields to
/// visualize on the main demo page.</p>
/// <p>First, this method will try to setup the REST web application using <method>CreateRestWebApp</method>.
/// Then, it will create a domain definition matching the table and column information you provided. 
/// If needed, you can still modify that definition as you see fit, after which your domain will be built.</p>
/// <p>Note that, if you already have a domain available, you'll only need to run the <method>CreateRestWebApp</method>
/// method (once per namespace).</p>
ClassMethod Setup(pTableName As %String, pDataColumn As %String, pMetadataColumns As %List = "", ByRef pDomainName As %String = "") As %Status
{
	set tSC = $$$OK
	try {
		do ..CreateRestWebApp(.tWebAppName)
		
		// some input cleansing
		set:pDomainName="" pDomainName = $translate(pTableName,"_.","  ")
		set pDomainName = $zstrip(pDomainName,"*W")
		set:(pMetadataColumns'="")&&'$lv(pMetadataColumns) pMetadataColumns = $lfs(pMetadataColumns)
		
		// prepare metadata array tMetadata(FIELDNAME) = FIELDSPEC
		for i = 1:1:$ll(pMetadataColumns) {
			set tFieldSpec = $zstrip($lg(pMetadataColumns,i),"<>WP")
			continue:tFieldSpec=""
			set tAliased = $find($$$UPPER(tFieldSpec)," AS ")
			set tFieldName = $s(tAliased:$e(tFieldSpec,tAliased,*), 1:tFieldSpec)
			set tMetadata(tFieldName) = tFieldSpec
		}
		
		// set up domain
		set tSC = ..CreateDomainDefinition(pDomainName, pTableName, pDataColumn, .tMetadata, .tDomainDefClass)
		quit:$$$ISERR(tSC)
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	
	if $$$ISOK(tSC) {
		
		write !,"Demo setup completed succesfully.",!!,"You can now make any final modifications to "_tDomainDefClass_" (refine metadata or configuration,...).",!,"Just hit enter when you're done",!
		
		read tDummy

		set tSC = $classmethod(tDomainDefClass,"%Build")
		
		if $$$ISOK(tSC) {
			set tDomainId = $classmethod(tDomainDefClass, "%GetDomainId")
			do ##class(%Library.RoutineMgr).GetWebServerPort(.tPort,.tServer,.tURLPrefix,.tURL)		
			write !,"You can now access your application at "_tURL_"csp/",$namespace,"/SetAnalysisDemo.csp?",tDomainId,!
		}
	} else {
		write !!,"Something went wrong setting up your demo:",!
		do $system.OBJ.DisplayError(tSC)
	}
	
	quit tSC
}

ClassMethod CreateDomainDefinition(pDomainName As %String, pTableName As %String, pDataColumn As %String, ByRef pMetadata, Output pDomainDefClass As %String = "") As %Status [ Internal ]
{
	set tSC = $$$OK
	try {
		do $system.SQL.TableExists(pTableName,.tMetadata)
		set tClassName = $lg(tMetadata,3)
		set tPackageName = $piece(tClassName,".",1,*-1)
		
		set tDomainDef = ##class(%iKnow.Model.domain).%New()
		set tDomainDef.name = pDomainName
		//set tDomainDef.objectsPackage = tPackageName_".Tables"  // helpful addition in 2015.2
		
		// set sort field to spread, as that's the metric being visualized
		set tParamDef = ##class(%iKnow.Model.parameter).%New()
		set tParamDef.name = $$$IKPSORTFIELD
		set tParamDef.value = $$$SORTBYSPREAD
		set tParamDef.parent = tDomainDef
		
		// add data location
		set tDomainDef.data = ##class(%iKnow.Model.data).%New()
		set tListDef = ##class(%iKnow.Model.listTable).%New()
		set tListDef.tableName = pTableName
		set tListDef.idField = "ID"
		set tListDef.groupField = "ID"
		set tListDef.dataFields = pDataColumn
		set tListDef.data = tDomainDef.data
		
		// add metadata
		set tDomainDef.metadata = ##class(%iKnow.Model.metadata).%New()
		set tFieldName = ""
		for {
			set tFieldName = $order(pMetadata(tFieldName), 1, tFieldSpec)
			quit:tFieldName=""
			set tListDef.metadataColumns = tListDef.metadataColumns _ $s(tListDef.metadataColumns="":"", 1:",") _ tFieldSpec
			//set tListDef.metadataFields = tListDef.metadataFields _ $s(tListDef.metadataFields="":"", 1:",") _ tFieldName
			set tFieldDef = ##class(%iKnow.Model.metadataField).%New()
			set tFieldDef.name = tFieldName
			set tFieldDef.metadata = tDomainDef.metadata
		}
		
		// language
rdlang	write !,"Which language are these texts in? [en] "
		read tLanguage
		if (tLanguage'="") && (tLanguage'="en") {
			set tConfig = ##class(%iKnow.Model.configuration).%New()
			set tConfig.name = pDomainName_".Config"
			set tConfig.languages = tLanguage
			set tSC = tConfig.%Validate()
			if $$$ISERR(tSC) {
				do $system.OBJ.DisplayError(tSC)
				goto rdlang
			}
			do tDomainDef.configurations.Insert(tConfig)
			set tParamDef = ##class(%iKnow.Model.parameter).%New()
			set tParamDef.name = $$$IKPDEFAULTCONFIG
			set tParamDef.value = tConfig.name
			set tParamDef.parent = tDomainDef
		}
		write !
		
		set pDomainDefClass = tPackageName_".Domain"
		
		if (($system.Version.GetMajor()*10)+$system.Version.GetMinor())>=20152 {
			// leverage utility methods in 2015.2+
			set tSC = tDomainDef.%SaveToClass(pDomainDefClass, 1, 1, 1)
			quit:$$$ISERR(tSC)
		} else {
			// otherwise do things manually
			if $$$defClassDefined(pDomainDefClass) {
				set tSC = $$Delete^%apiOBJ(pDomainDefClass)
			}
		    set tClass = ##class(%Dictionary.ClassDefinition).%New()
		    set tClass.Name = pDomainDefClass
		    set tClass.Super = "%iKnow.DomainDefinition"
		    set tClass.ProcedureBlock = 1
		    
			// this is all taken care of inside %iKnow.Model.node after 2015.1!
			set tSC = tDomainDef.XMLExportToString(.tString)
			quit:$$$ISERR(tSC)
			set tString = ##class(%DeepSee.PMML.Builder.AbstractBuilder).FormatXML(tString)  
			// avoid minor inconvenience with predefined readonly attribute
			set tString = $replace(tString, "listerClass=""%iKnow.Source.SQL.Lister""", "")
			
		    set tXData = ##class(%Dictionary.XDataDefinition).%New()
		    set tXData.Name = "Domain"
		    set tXData.XMLNamespace = "http://www.intersystems.com/iknow"
		    do tClass.XDatas.Insert(tXData)
			set tSC = tXData.Data.Write(tString)
			quit:$$$ISERR(tSC)
		    
		    set tSC = tClass.%Save()
		    quit:$$$ISERR(tSC)
		    set tClass="", tXData=""
		    
		    set tSC = $system.OBJ.Compile(pDomainDefClass, "ckd /multicompile=0")
			quit:$$$ISERR(tSC)
		}
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// Attempts to create a web application forwarding to Demo.SetAnalysis.RestHandler
ClassMethod CreateRestWebApp(ByRef pWebAppName = "") As %Status
{
	set tSC = $$$OK, tCreated=0, tCurrentNS = $$$LOWER($namespace)
	try {
		set:pWebAppName="" pWebAppName = "/csp/"_tCurrentNS_"/saREST/"
		set tProperties("NameSpace") = tCurrentNS
		set tProperties("DispatchClass") = "Demo.SetAnalysis.RestHandler"
		set tProperties("AutheEnabled") = $$$AutheUnauthenticated
		//set tProperties("iKnowEnabled") = 1
		
		zn "%SYS"
		if '##class(Security.Applications).Exists(pWebAppName) {
			set tSC = ##class(Security.Applications).Create(pWebAppName, .tProperties)
			quit:$$$ISERR(tSC)
			set tCreated=1
		}
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	zn tCurrentNS
	
	if $$$ISERR(tSC) {
		write !,"WARNING: unable to create web application due to the following error:",!
		do $system.OBJ.DisplayError(tSC)
		write !,"You'll still have to create a web application '",pWebAppName,"' referring to Demo.SetAnalysis.RestHandler",!
	} elseif (tCreated) {
		write !,"Web Application '"_pWebAppName_"' created successfully",!
	}
	
	quit $$$OK
}

ClassMethod ToClassifier(domainId As %Integer, setName As %String, classifierClassName As %String, metadataFieldName As %String, targetCategory As %String = "") As %Status
{
    set sc = $$$OK
    try {
        set set = ##class(Demo.SetAnalysis.SetDefinition).NameIdxOpen(domainId, setName,, .sc)
        quit:'$isobject(set)
        set classifier = ##class(%iKnow.Classification.Definition.Classifier).%New()
        set classifier.description = "Automatically generated from set "_setName

		set param = ##class(%iKnow.Classification.Definition.BuilderParameter).%New()
		set param.name = "DomainId"
		set param.value = domainId
		do classifier.BuilderParameters.Insert(param)
		set param = ##class(%iKnow.Classification.Definition.BuilderParameter).%New()
		set param.name = "MetadataField"
		set param.value = metadataFieldName
		do classifier.BuilderParameters.Insert(param)

        // first build categories based on metadata field
        set sc = ##class(%iKnow.Queries.MetadataAPI).GetUniqueValues(.md, domainId, metadataFieldName, 0, 0)
        quit:$$$ISERR(sc)
        set i = ""
        for {
            set i = $order(md(i),1,d)
            quit:i=""
            set cat = ##class(%iKnow.Classification.Definition.Category).%New()
            set cat.name = $lg(d,1)
            set filter = ##class(%iKnow.Filters.SimpleMetadataFilter).%New(domainId, metadataFieldName, "=", cat.name)
            set cat.recordCount = filter.FilteredSourceCount
            set cat.spec = filter.ToString()
            do classifier.Categories.Insert(cat)

			set:targetCategory="" targetCategory = cat.name
        }
		

		set classifier.ClassificationMethod = ##class(%iKnow.Classification.Definition.ClassificationMethod).%New()
		set classifier.ClassificationMethod.method = "rules"
		set classifier.ClassificationMethod.ClassificationRules = ##class(%iKnow.Classification.Definition.ClassificationRules).%New()

		set rule = ##class(%iKnow.Classification.Definition.Rule).%New()
		set rule.category = targetCategory
		set rule.Predicate = ##class(%iKnow.Classification.Definition.PredicateOR).%New()
		do classifier.ClassificationMethod.ClassificationRules.Rules.Insert(rule)
 
        set classifier.TermDictionary = ##class(%iKnow.Classification.Definition.TermDictionary).%New()
		set entityCount = set.Entities.Count()
        for i = 1:1:entityCount {
            set term = ##class(%iKnow.Classification.Definition.TermEntity).%New()
            do term.Entries.Insert(set.Entities.GetAt(i))
			do classifier.TermDictionary.Terms.Insert(term)

			set predicate = ##class(%iKnow.Classification.Definition.Predicate).%New(),
				predicate.operator = "greaterThan",
				predicate.term = i,
				predicate.value = 0
			do rule.Predicate.predicates.Insert(predicate)
        }
		
        for i = 1:1:set.CRCs.Count() {
            set term = ##class(%iKnow.Classification.Definition.TermCRC).%New()
			set str = set.CRCs.GetAt(i),
				crc = ##class(%iKnow.Classification.Definition.TermCRCEntry).%New(),
				crc.Master = $p(str," ~ ",1),
				crc.Relation = $p(str," ~ ",2),
				crc.Slave = $p(str," ~ ",3)
            do term.Entries.Insert(crc)
			do classifier.TermDictionary.Terms.Insert(term)
			
			set predicate = ##class(%iKnow.Classification.Definition.Predicate).%New(),
				predicate.operator = "greaterThan",
				predicate.term = i+entityCount,
				predicate.value = 0
			do rule.Predicate.predicates.Insert(predicate)
        }

        set sc = classifier.%SaveToClass(classifierClassName, 1, 1)
        quit:$$$ISERR(sc)

    } catch (ex) {
        set sc = ex.AsStatus()
    }
    quit sc
}

}

