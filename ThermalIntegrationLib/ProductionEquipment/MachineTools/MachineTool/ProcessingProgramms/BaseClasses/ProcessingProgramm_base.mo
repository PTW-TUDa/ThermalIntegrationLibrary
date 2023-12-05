within ThermalIntegrationLib.ProductionEquipment.MachineTools.MachineTool.ProcessingProgramms.BaseClasses;
record ProcessingProgramm_base
  extends Modelica.Icons.Record;
  parameter Real ProcessingProgramm[:,4] "First column defines operating mode. Following columns define electric power demand of components during operating mode";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ProcessingProgramm_base;
