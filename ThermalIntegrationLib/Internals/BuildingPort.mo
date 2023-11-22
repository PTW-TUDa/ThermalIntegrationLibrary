within ThermalIntegrationLib.Internals;
connector BuildingPort
   SI.Temperature insideTemperature;
   SI.Temperature outsideTemperature;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end BuildingPort;
