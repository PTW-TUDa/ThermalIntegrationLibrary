within ThermalIntegrationLibrary.BaseClasses.Internals;
model Q_flowDemand

  parameter Integer operationModes;

  input SI.Temperature [operationModes] T_in annotation(Dialog(enable=true));
  input SI.Temperature [operationModes] T_out annotation(Dialog(enable=true));

  input SI.HeatFlowRate [operationModes] Q_flow annotation(Dialog(enable=true));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Q_flowDemand;
