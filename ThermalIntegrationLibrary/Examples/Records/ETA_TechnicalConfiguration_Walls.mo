within ThermalIntegrationLibrary.Examples.Records;
record ETA_TechnicalConfiguration_Walls
  extends ThermalIntegrationLibrary.FactoryBuilding.ProductionHall.BuildingEnvelope.Records.WallProperties(
    length=40,
    width=11,
    k=0.225,
    G=length*width*k,
    m=176000 "440* m^2 with a thickness of 0.2m and a density of 2000kg/m^3",
    cp=1000,
    C=176000000);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Values are taken from [3] and [4].</p>
</html>"));
end ETA_TechnicalConfiguration_Walls;
