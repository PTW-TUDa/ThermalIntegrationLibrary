within ThermalIntegrationLib.Examples.Records;
record ETA_TechnicalConfiguration_Floor
  extends ThermalIntegrationLib.FactoryBuilding.ProductionHall.BuildingEnvelope.Records.FloorProperties(
  length=40,
  width=20,
  k=0.2,
  G=length*width*k,
  m=800000 "800 m^2 with a thickness of 0.5m and a density of 2000kg/m^3",
  cp=1000,
  C=800000000);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Values are taken from [3] and [4].</p>
</html>"));
end ETA_TechnicalConfiguration_Floor;
