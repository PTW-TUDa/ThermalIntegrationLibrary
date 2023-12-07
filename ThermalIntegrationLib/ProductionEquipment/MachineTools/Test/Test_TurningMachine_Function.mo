﻿within ThermalIntegrationLib.ProductionEquipment.MachineTools.Test;
function Test_TurningMachine_Function

algorithm
  simulateModel("ThermalIntegrationLib.ProductionEquipment.MachineTools.Test.Test_TurningMachine", stopTime=30000, method="Cvode", resultFile="Tester1_EiB_MachineTool") annotation(__Dymola_interactive=true);

// Script generated by Dymola Tue Nov  2 11:03:41 2021
// Plot commands
removePlots(false);
createPlot(id=1, position={0, 0, 1573, 808}, y={"EiB_MachineTool_v1_1.operationMode"}, range={0.0, 30000.0, -2.0, 6.0}, grid=true, legends={"Operation Mode"}, colors={{28,108,200}}, timeUnit="h");
createPlot(id=1, position={0, 0, 1573, 808}, y={"EiB_MachineTool_v1_1.electricDemand[1].Power[1]", "EiB_MachineTool_v1_1.electricDemand[2].Power[1]"}, range={0.0, 30000.0, -2000.0, 4000.0}, grid=true, legends={"Hauptanschluss (P_el, W)", "Chiller (P_el, W)"}, subPlot=102, colors={{28,108,200}, {238,46,47}}, timeUnit="h");
createPlot(id=1, position={0, 0, 1573, 808}, y={"EiB_MachineTool_v1_1.coolDemand[1].Q_flow[1]", "EiB_MachineTool_v1_1.dissipationFlowRate"}, range={0.0, 30000.0, -1000.0, 3000.0}, grid=true, legends={"Kühlwasserbedarf zentral (P_th, W)", "Abwärme konvektiv (P_th, W)"}, subPlot=103, colors={{28,108,200}, {238,46,47}}, displayUnits={"W", "W"}, timeUnit="h");

end Test_TurningMachine_Function;
