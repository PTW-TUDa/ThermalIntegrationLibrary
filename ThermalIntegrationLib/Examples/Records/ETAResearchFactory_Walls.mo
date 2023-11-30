within ThermalIntegrationLib.Examples.Records;
record ETAResearchFactory_Walls
  extends ThermalIntegrationLib.FactoryBuilding.BuildingShell.Records.WallProperties(
  length=40,
  width=11,
  k=0.24,
  G=length*width*k);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ETAResearchFactory_Walls;
