within ThermalIntegrationLibrary.BaseClasses.Internals;
model ElectricDemand

  parameter Integer operationModes;

  input Real[operationModes] Power annotation(Dialog(enable=true));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end ElectricDemand;
