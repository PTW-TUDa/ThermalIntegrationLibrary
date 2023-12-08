within ThermalIntegrationLibrary.ProductionEquipment.MachineTools.Test;
model Test_TurningMachine
  extends Modelica.Icons.Example;
  inner ThermalIntegrationLibrary.BaseClasses.SystemEnergyManager sem(useBuilding=false) annotation (Placement(transformation(extent={{70,70},{90,90}})));
  TurningMachine.TurningMachine turningMachine annotation (Placement(transformation(extent={{-18,-20},{22,20}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=60000, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(executeCall(ensureSimulated=true) = {createPlot(
        id=1,
        position={0,0,1573,607},
        y={"eiB_MachineTool_v1_1.coolDemand[1].Q_flow[1]","eiB_MachineTool_v1_1.dissipationFlowRate"},
        range={0.0,30000.0,-4000.0,6000.0},
        grid=true,
        colors={{28,108,200},{238,46,47}},
        displayUnits={"W","W"}),createPlot(
        id=1,
        position={0,0,1573,607},
        y={"eiB_MachineTool_v1_1.electricDemand[1].Power[1]","eiB_MachineTool_v1_1.electricDemand[2].Power[1]","eiB_MachineTool_v1_1.coolingSystem.COP"},
        range={0.0,30000.0,-1000.0,4000.0},
        grid=true,
        subPlot=102,
        colors={{28,108,200},{238,46,47},{0,140,72}},
        displayUnits={"","","1"})}, file="../../../../Desktop/EiB_machine_tool_plot.mos" "EiB_machine_tool_plot"));
end Test_TurningMachine;
