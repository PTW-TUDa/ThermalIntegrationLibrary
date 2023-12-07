within ThermalIntegrationLib.ProductionEquipment.Ovens.Test;
model Test_AnnealingOven
  extends Modelica.Icons.Example;
  AnnealingOven.AnnealingOven annealingOven annotation (Placement(transformation(extent={{-40,-20},{20,40}})));
  inner BaseClasses.SystemEnergyManager sem annotation (Placement(transformation(extent={{80,80},{100,100}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_AnnealingOven;
