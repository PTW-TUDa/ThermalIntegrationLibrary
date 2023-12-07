within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine;
model TurningMachine
  extends ThermalIntegrationLib.BaseClasses.BaseProductionEquipment(
    electricDemands=1,
    ID=1,
    coolDemands=3,
    m=1099.6,
    cp=500,
    TInitial=293.15,
    heatDemands=0,
    tableOperationMode=[0, 0; 3122,4; 6134,1; 6832,4; 7687,1; 7858,4; 8030,1; 8666,4; 8833,3; 9525,4; 9610,3; 10301,4; 10689,1; 11227,4; 11369,3; 12048,4; 12216,3; 12909,4; 12938,3; 13617,4; 13636,3; 14315,4; 14333,3; 15012,4; 15030,3; 15709,4; 15728,3; 16407,4; 16425,3; 17104,4; 17122,3; 17801,4; 17819,3; 18498,4; 18588,1; 19047,4; 20132,1; 21348,4; 21360,1; 22002,4; 22200,3; 22933,4; 23050,3; 23729,4; 23747,3; 24426,4; 24444,3; 25123,4; 25141,3; 25821,4; 25839,3; 26518,4; 26536,3; 27215,4; 27233,3;
        27559,4; 27576,1; 27642,4; 27651,3; 28342,4; 28371,3; 29049,4; 29069,3; 29748,4; 30141,1; 32180,4; 32196,1],
    operationModes=4);
  parameter Real tableProcessingProgramm[:,2]=[0,1; 86400,1]
                                               "Table which defines the sequence of processing programms (time = first column; processingProgramm = second column)";
  replaceable parameter ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.TechnicalConfiguration.TechnicalConfiguration_a TechnicalConfiguration constrainedby ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base annotation (choicesAllMatching=true);

  replaceable parameter ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.Kugelspiel_OP10 ProcessingProgramm_1 constrainedby ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.BaseClasses.ProcessingProgramm_base "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-190,-190},{-170,-170}})));
  replaceable parameter ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.Kugelspiel_OP20 ProcessingProgramm_2 constrainedby ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.BaseClasses.ProcessingProgramm_base "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-150,-190},{-130,-170}})));
  replaceable parameter ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.Steuerscheibe_OP10 ProcessingProgramm_3 constrainedby ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.BaseClasses.ProcessingProgramm_base "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-110,-190},{-90,-170}})));
  replaceable parameter ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.Steuerscheibe_OP20 ProcessingProgramm_4 constrainedby ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.BaseClasses.ProcessingProgramm_base "Table which defines power demand of components during operating modes (operating mode = first column; power demand = following columns)"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-70,-190},{-50,-170}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ThermalSystem.ThermalSystem thermalSystem(
    heatCapacitor(C=TechnicalConfiguration.C_MachineTool, T(start=TInitial)),
    thermalConductor(G=TechnicalConfiguration.lambda_coolinglubricant),
    thermalConductor1(G=TechnicalConfiguration.lambda_loss),
    thermalConductor2(G=TechnicalConfiguration.lambda_machinecooling)) annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.Drives.Drives drives annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Math.MultiSum DC(nu=1) annotation (Placement(transformation(extent={{-6,-86},{6,-74}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ProcessController.ProcessController processController(
    ProcessingProgramm1=ProcessingProgramm_1.ProcessingProgramm,
    ProcessingProgramm2=ProcessingProgramm_2.ProcessingProgramm,
    ProcessingProgramm3=ProcessingProgramm_3.ProcessingProgramm,
    ProcessingProgramm4=ProcessingProgramm_4.ProcessingProgramm) annotation (Placement(transformation(extent={{-116,-20},{-76,20}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingLubricantSystem.CoolingLubricantSystem coolingLubricantSystem annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.HydraulicSystem.HydraulicSystem hydraulicSystem annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode) annotation (Placement(transformation(extent={{-170,0},{-150,20}})));
  Modelica.Blocks.Sources.IntegerTable integerTable(table=tableProcessingProgramm)
                                                    annotation (Placement(transformation(extent={{-172,-20},{-152,0}})));
  Modelica.Blocks.Math.MultiSum AC_DC(nu=2) annotation (Placement(transformation(extent={{60,6},{72,-6}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ControlCabinet.ControlCabinet controlCabinet(
    m_controlCabinet=20,
    cp_controlCabinet=900,
    eta_controlCabinet=0.95,
    heatCapacitor(T(start=TInitial))) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.MultiSum sum(nu=2) annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.CentralCoolWater centralCoolWater(T_flow=TechnicalConfiguration.T_target_coolWater - 5) annotation (Placement(transformation(extent={{120,110},{140,130}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.ColdWaterNetwork coldWater(heatCapacitor(T(start=TechnicalConfiguration.T_target_coldWater))) annotation (Placement(transformation(extent={{20,90},{40,110}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.CentralColdWater centralColdWater(T_flow=TechnicalConfiguration.T_target_coldWater - 5) annotation (Placement(transformation(extent={{120,90},{140,110}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.TransferUnit.TransferUnit transferUnit2(
    IsUsed=TechnicalConfiguration.CentralColdWater,
    lambda=TechnicalConfiguration.lambda_components,
    T_target=TechnicalConfiguration.T_target_coldWater) annotation (Placement(transformation(extent={{100,90},{80,110}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.TransferUnit.TransferUnit transferUnit3(
    IsUsed=TechnicalConfiguration.WaterCooledCompressionChiller,
    lambda=TechnicalConfiguration.lambda_components,
    T_target=TechnicalConfiguration.T_target_coolWater) annotation (Placement(transformation(extent={{100,110},{80,130}})));
  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.ColdWaterNetwork coolWater(heatCapacitor(T(start=TechnicalConfiguration.T_target_coolWater))) annotation (Placement(transformation(extent={{40,110},{20,130}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor dissipation annotation (Placement(transformation(extent={{190,180},{210,200}})));

  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.CompressionChillers.CompressionChiller compressionChiller(
    WaterCooled=TechnicalConfiguration.WaterCooledCompressionChiller,
    IsUsed=true,
    ContControl=TechnicalConfiguration.ContControl,
    T_flow=TechnicalConfiguration.T_target_coldWater - 5,
    T_target_coldWater=TechnicalConfiguration.T_target_coldWater) annotation (Placement(transformation(extent={{-40,72},{-20,92}})));
                                                                                                               //Anpassung des Parameterbezugs,

  ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.CompressionChillers.CompressionChiller_onePort compressionChiller_onePort(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    IsUsed=true,
    ContControl=TechnicalConfiguration.ContControl,
    T_flow=TechnicalConfiguration.T_target_coldWater - 5,
    T_target_coldWater=TechnicalConfiguration.T_target_coldWater) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={226,190})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=surroundingTemperature) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={256,190})));
equation
  // main connection
  electricDemand[1].Power[1] =AC_DC.y + controlCabinet.P_el + compressionChiller.P_el;
  electricDemand[1].Power[2] =AC_DC.y + controlCabinet.P_el + compressionChiller.P_el;
  electricDemand[1].Power[3] =AC_DC.y + controlCabinet.P_el + compressionChiller.P_el;
  electricDemand[1].Power[4] =AC_DC.y + controlCabinet.P_el + compressionChiller.P_el;

  // machine cooling
  coolDemand[1].Q_flow[1:end] ={-thermalSystem.CoolingLubricant.Q_flow,-thermalSystem.CoolingLubricant.Q_flow,-thermalSystem.CoolingLubricant.Q_flow,-thermalSystem.CoolingLubricant.Q_flow};
  coolDemand[1].T_in[1:end] ={coldWater.T_coldWater,coldWater.T_coldWater,coldWater.T_coldWater,coldWater.T_coldWater};
  coolDemand[1].T_out[1:end] ={thermalSystem.CoolingLubricant.T,thermalSystem.CoolingLubricant.T,thermalSystem.CoolingLubricant.T,thermalSystem.CoolingLubricant.T};

  // condenser cooling
  coolDemand[2].Q_flow[1:end] ={-compressionChiller.coolWater.Q_flow,-compressionChiller.coolWater.Q_flow,-compressionChiller.coolWater.Q_flow,-compressionChiller.coolWater.Q_flow};
  coolDemand[2].T_in[1:end] = {TechnicalConfiguration.T_target_coolWater - 5,TechnicalConfiguration.T_target_coolWater - 5,TechnicalConfiguration.T_target_coolWater - 5,TechnicalConfiguration.T_target_coolWater - 5};
  coolDemand[2].T_out[1:end] ={coolWater.T_coldWater,coolWater.T_coldWater,coolWater.T_coldWater,coolWater.T_coldWater};

  // control cabinet cooling
  coolDemand[3].Q_flow[1:end] ={-controlCabinet.controlCabinetCooling.Q_flow,-controlCabinet.controlCabinetCooling.Q_flow,-controlCabinet.controlCabinetCooling.Q_flow,-controlCabinet.controlCabinetCooling.Q_flow};
  coolDemand[3].T_in[1:end] ={controlCabinet.controlCabinetCooling.T,controlCabinet.controlCabinetCooling.T,controlCabinet.controlCabinetCooling.T,controlCabinet.controlCabinetCooling.T};
  coolDemand[3].T_out[1:end] = {controlCabinet.T_controlCabinet,controlCabinet.T_controlCabinet,controlCabinet.T_controlCabinet,controlCabinet.T_controlCabinet};

  // calculation of dissipation to hall
  dissipationFlowRate = dissipation.Q_flow;

  connect(processController.controlBus, drives.controlBus) annotation (Line(
      points={{-76,0},{-60,0},{-60,-80},{-40,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(coolingLubricantSystem.controlBus, processController.controlBus) annotation (Line(
      points={{-40,0},{-76,0}},
      color={255,204,51},
      thickness=0.5));
  connect(hydraulicSystem.controlBus, processController.controlBus) annotation (Line(
      points={{-40,-40},{-60,-40},{-60,0},{-76,0}},
      color={255,204,51},
      thickness=0.5));
  connect(integerExpression.y, processController.OperatingMode) annotation (Line(points={{-149,10},{-118,10}},                   color={255,127,0}));
  connect(integerTable.y, processController.ProcessingProgramm) annotation (Line(points={{-151,-10},{-118,-10}}, color={255,127,0}));
  connect(drives.P_el, DC.u[1]) annotation (Line(points={{-19,-80},{-6,-80}}, color={0,0,127}));
  connect(coolingLubricantSystem.P_el, sum.u[1]) annotation (Line(points={{-19,0},{-6,0},{-6,2.1}}, color={0,0,127}));
  connect(hydraulicSystem.P_el, sum.u[2]) annotation (Line(points={{-19,-40},{-10,-40},{-10,-4},{-6,-4},{-6,-2.1}}, color={0,0,127}));
  connect(sum.y, controlCabinet.u) annotation (Line(points={{7.02,0},{18,0}}, color={0,0,127}));
  connect(controlCabinet.P_el, AC_DC.u[1]) annotation (Line(points={{41,-5},{60,-5},{60,-2.1}},
                                                                                              color={0,0,127}));
  connect(DC.y, AC_DC.u[2]) annotation (Line(points={{7.02,-80},{54,-80},{54,2.1},{60,2.1}}, color={0,0,127}));
  connect(transferUnit2.primary, centralColdWater.consumption) annotation (Line(points={{100,100},{120,100}}, color={191,0,0}));
  connect(transferUnit3.primary, centralCoolWater.consumption) annotation (Line(points={{100,120},{120,120}}, color={191,0,0}));
  connect(thermalSystem.hall, dissipation.port_a) annotation (Line(points={{140,-10},{180,-10},{180,190},{190,190}}, color={191,0,0}));
  connect(coolWater.supply, transferUnit3.secondary) annotation (Line(points={{40,120},{80,120}}, color={191,0,0}));
  connect(compressionChiller.Hall, dissipation.port_a) annotation (Line(points={{-30,92},{-30,190},{190,190}},
                                                       color={191,0,0}));
  connect(compressionChiller.coolWater, coolWater.consumption) annotation (Line(
        points={{-25,92},{-25,120},{20,120}},        color={191,0,0}));
  connect(compressionChiller_onePort.ColdWater, controlCabinet.controlCabinetCooling)
    annotation (Line(points={{-29.6,30},{-30,30},{-30,22},{25,22},{25,10}},
        color={191,0,0}));
  connect(compressionChiller_onePort.Hall, dissipation.port_a) annotation (Line(
        points={{-29.8,50},{-29.8,54},{-80,54},{-80,190},{190,190}},   color={
          191,0,0}));

  connect(dissipation.port_b, prescribedTemperature.port) annotation (Line(points={{210,190},{216,190}}, color={191,0,0}));
  connect(prescribedTemperature.T, realExpression.y) annotation (Line(points={{238,190},{245,190}}, color={0,0,127}));
  connect(coldWater.consumption, transferUnit2.secondary) annotation (Line(points={{40,100},{80,100}}, color={191,0,0}));
  connect(compressionChiller.ColdWater, thermalSystem.MachineCooling) annotation (Line(points={{-30,72},{-30,60},{160,60},{160,10},{140.2,10}}, color={191,0,0}));
  connect(coldWater.supply, thermalSystem.CoolingLubricant) annotation (Line(points={{20,100},{0,100},{0,80},{170,80},{170,0},{140,0}}, color={191,0,0}));
  connect(thermalSystem.P_el, AC_DC.y) annotation (Line(points={{98,0},{73.02,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})),
    experiment(
      StopTime=30000,
      Interval=10,
      __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput);
end TurningMachine;
