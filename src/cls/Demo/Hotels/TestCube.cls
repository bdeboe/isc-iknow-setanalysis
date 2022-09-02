/// 
Class Demo.Hotels.TestCube Extends %DeepSee.CubeDefinition [ DependsOn = Demo.Hotels.Review, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="TestCompDim" displayName="Test cube" disabled="false" abstract="false" sourceClass="Demo.Hotels.Review" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false">
  <dimension name="Hotelname" disabled="false" hasAll="false" allCaption="All Hotelname" allDisplayName="Hotelname" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="HotelName" disabled="false" sourceProperty="Hotelname" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
        <additionalDescription>undefined</additionalDescription>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="StayDate" disabled="false" hasAll="false" allCaption="All StayDate" allDisplayName="StayDate" sourceProperty="StayDate" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="StayYear" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
        <additionalDescription>undefined</additionalDescription>
      </level>
      <level name="StayMonth" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
        <additionalDescription>undefined</additionalDescription>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Entities" disabled="false" hasAll="false" allCaption="All Entities" allDisplayName="Entities" type="iKnow" iKnowMeasure="ReviewFull" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Entities" disabled="false" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
        <additionalDescription>undefined</additionalDescription>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Sets" type="computed" dimensionClass="Demo.SetAnalysis.ComputedDimension" iKnowMeasure="ReviewFull">
  <hierarchy name="H1">
  <level name="Set">
  </level>
  </hierarchy>
  </dimension>
  <measure name="ReviewFull" disabled="false" sourceProperty="ReviewFull" aggregate="COUNT" type="iKnow" hidden="false" searchable="false" iKnowSource="string" >
    <additionalDescription>undefined</additionalDescription>
  </measure>
</cube>
}

Parameter DOMAIN;

}

