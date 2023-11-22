within ThermalIntegrationLib.Internals;
connector CoolingPowerPort
    flow SI.HeatFlowRate Power;
    SI.Temperature Temperature_in;
    SI.Temperature Temperature_out;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end CoolingPowerPort;
