within ThermalIntegrationLib.BaseClasses.Internals;
partial model Power
  extends Modelica.Icons.TypeReal;
 Real Power;
 Real Energy;
equation

  der(Energy) = Power;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Power;
