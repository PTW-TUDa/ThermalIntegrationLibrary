within ThermalIntegrationLib.FactoryBuilding.BuildingElements.Records;
record WallProperties "Basic parameter record for wall elements"
  extends Modelica.Icons.Record;
  parameter SI.Length length "length of the wall";
  parameter SI.Length width "width of the wall";
  parameter SI.CoefficientOfHeatTransfer k "coefficient of heat transfer of the wall";
  parameter SI.ThermalConductance G "thermal conductance of the wall";
  parameter SI.Mass m "mass of wall";
  parameter SI.SpecificHeatCapacity cp "specific heat capacity of wall";
  parameter SI.HeatCapacity C "heat capacity of wall";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end WallProperties;
