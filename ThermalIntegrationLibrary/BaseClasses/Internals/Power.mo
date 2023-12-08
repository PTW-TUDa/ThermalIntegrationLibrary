within ThermalIntegrationLibrary.BaseClasses.Internals;
partial model Power

 Real Power;
 Real Energy;
equation

  der(Energy) = Power;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Power;
