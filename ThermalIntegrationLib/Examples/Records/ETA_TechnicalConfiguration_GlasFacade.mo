within ThermalIntegrationLib.Examples.Records;
record ETA_TechnicalConfiguration_GlasFacade
  extends ThermalIntegrationLib.FactoryBuilding.ProductionHall.BuildingEnvelope.Records.WallProperties(
  length=20,
  width=11,
  k=(0.23+1.1)*0.5 "glas with fleece and glas without fleece have a 50% share of the overall facade system",
  G=length*width*k,
  m=11000 "220* m^2 with a thickness of 0.02m and a density of 2500kg/m^3",
  cp=720,
  C=7920000);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ETA_TechnicalConfiguration_GlasFacade;
