within ThermalIntegrationLib.Examples.Records;
record ETAResearchFactory_Roof
  extends ThermalIntegrationLib.FactoryBuilding.BuildingEnvelope.Records.RoofProperties(
  length=40,
  width=20,
  k=0.2,
  G=length*width*k);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ETAResearchFactory_Roof;
