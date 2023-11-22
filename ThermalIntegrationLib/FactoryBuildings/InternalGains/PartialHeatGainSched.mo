within ThermalIntegrationLib.FactoryBuildings.InternalGains;
partial model PartialHeatGainSched
  extends PartialHeatGain;
  Modelica.Blocks.Interfaces.RealInput schedule "Schedule of usage signal with values from 0 to 1" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true)), Diagram(coordinateSystem(preserveAspectRatio=true)));
end PartialHeatGainSched;
