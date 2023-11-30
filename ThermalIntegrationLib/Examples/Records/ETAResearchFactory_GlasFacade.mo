within ThermalIntegrationLib.Examples.Records;
record ETAResearchFactory_GlasFacade
  extends ThermalIntegrationLib.FactoryBuilding.BuildingEnvelope.Records.WallProperties(
  length=20,
  width=11,
  k=(0.23+1.1)*0.5 "glas with fleece and glas without fleece have a 50% share of the overall facade system",
  G=length*width*k);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ETAResearchFactory_GlasFacade;
