within ThermalIntegrationLibrary.ProductionEquipment.GenericProcesses;
model MachineMinimal
  extends ThermalIntegrationLibrary.BaseClasses.BaseProductionEquipment(
    heatDemands=0,
    coolDemands=0,
    electricDemands=0,
    operationModes=0);

equation

  0.0 = dissipationFlowRate;

 annotation (Documentation(info="<html>
 <p>This is a minimalistic definition of a machine for a valid set of equations.</p>
<p>
This machine has no effect in a system (no energy flows).
</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end MachineMinimal;
