within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac;
model EiB_CleaningMachine1Tank_thermal_Mafac
  extends ThermalIntegrationLib.ProductionEquipment.BaseClasses.BaseProductionEquipment(
    electricDemands=1,
    ID=1,
    coolDemands=0,
    m=1300,
    cp=0.5,
    TInitial=298.15,
    heatDemands=1,
    tableOperationMode=[0,3; 12600,3; 12600,2; 15300,2; 15300,3; 27900,3; 27900,2; 28800,2; 28800,3; 41400,3; 41400,2; 44100,2; 44100,3; 56700,
        3; 56700,2; 57600,2; 57600,3; 70200,3; 70200,2; 72900,2; 72900,3; 85500,3; 85500,1; 86400,1],
    operationModes=3);
    parameter Integer tableProcessingProgramm[:,2]=[16,15; 5,30; 6,60; 7,60; 12,10; 11,15; 14,60; 13,90; 17,15; 2,60]
                              "Washing programm (washing mode = first column, duration in s = second column)";
    parameter Modelica.SIunits.Temperature T_heat=363.15 "Temperature level of (potential) heat network" annotation(Dialog(group = "Heating"));
    replaceable parameter
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.TechnicalConfiguration.TechnicalConfiguration_a
    TechnicalConfiguration constrainedby ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base;
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.TankHeating.thermTankHeating1 thermTankHeating1(
    m_t1=TechnicalConfiguration.m_t1,
    A_t1=TechnicalConfiguration.A_t1,
    c_fluid=TechnicalConfiguration.c_fluid,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.ProcessingProgramms.stateController stateController(
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
      stateTable=tableProcessingProgramm) annotation (Placement(transformation(extent={{-112,10},{-92,30}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.MechanicalProcesses.mech_processes mech_processes
    annotation (Placement(transformation(extent={{-10,110},{10,130}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.MechanicalProcesses.ah ah
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.MechanicalProcesses.scc scc
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Math.MultiSum P_el(nu=5) annotation (Placement(transformation(extent={{54,68},{66,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=3)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-90})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_hall
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-110})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_heating
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-40})));
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.MechanicalProcesses.oil_separator oil_separator(pct=
        TechnicalConfiguration.pct_oil_sep)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature hall(T=298.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,-90})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature heating(T=T_heat)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,-20})));
  Batches.batch batch(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-90})));
  Batches.hot_batches hot_batches(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack,
    T_req=TechnicalConfiguration.T_req) annotation (Placement(transformation(extent={{-10,-140},{10,-120}})));
  Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{-10,134},{10,154}})));
  MechanicalProcesses.units_waste_heat units_waste_heat(Q_wasteheat=TechnicalConfiguration.Q_waste_heat)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  electricDemand[1].Power[1] = P_el.y;
  electricDemand[1].Power[2] = P_el.y;
  electricDemand[1].Power[3] = P_el.y;

// Heat demand represents heat influx from central heating system
  heatDemand[1].Q_flow[1] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[1] = T_heating.T;
  heatDemand[1].T_out[1] = thermTankHeating1.T;

  heatDemand[1].Q_flow[2] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[2] = T_heating.T;
  heatDemand[1].T_out[2] = thermTankHeating1.T;

  heatDemand[1].Q_flow[3] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[3] = T_heating.T;
  heatDemand[1].T_out[3] = thermTankHeating1.T;

  dissipationFlowRate = hall.port.Q_flow;
  connect(thermTankHeating1.state, stateController.state)
    annotation (Line(points={{-11,-40},{-60,-40},{-60,20},{-91,20}},      color={255,127,0}));
  connect(mech_processes.state, stateController.state)
    annotation (Line(points={{-11,120},{-60,120},{-60,20},{-91,20}},    color={255,127,0}));
  connect(ah.state, stateController.state) annotation (Line(points={{-11,90},{-60,90},{-60,20},{-91,20}},    color={255,127,0}));
  connect(scc.state, stateController.state) annotation (Line(points={{-11,60},{-60,60},{-60,20},{-91,20}},    color={255,127,0}));
  connect(T_hall.port, thermalCollector.port_b) annotation (Line(points={{110,-100},{110,-90},{100,-90}}, color={191,0,0}));
  connect(thermTankHeating1.port_hall, thermalCollector.port_a[1])
    annotation (Line(points={{10,-40},{79.3333,-40},{79.3333,-90}},
                                                              color={191,0,0}));
  connect(oil_separator.state, stateController.state)
    annotation (Line(points={{-11,35},{-60,35},{-60,20},{-91,20}},      color={255,127,0}));
  connect(mech_processes.P_el, P_el.u[1]) annotation (Line(points={{11,120},{40,120},{40,77.36},{54,77.36}}, color={0,0,127}));
  connect(ah.P_el, P_el.u[2]) annotation (Line(points={{11,90},{40,90},{40,75.68},{54,75.68}}, color={0,0,127}));
  connect(scc.P_el, P_el.u[3]) annotation (Line(points={{11,60},{42,60},{42,74},{54,74}},       color={0,0,127}));
  connect(oil_separator.P_el, P_el.u[4]) annotation (Line(points={{11,30},{42,30},{42,72.32},{54,72.32}}, color={0,0,127}));
  connect(stateController.opMode, integerExpression.y) annotation (Line(points={{-113,20},{-119,20}}, color={255,127,0}));
  connect(stateController.processTime, oil_separator.processTime)
    annotation (Line(points={{-91,26},{-51,26},{-51,25},{-11,25}}, color={0,0,127}));
  connect(T_heating.port, thermTankHeating1.port_heating) annotation (Line(points={{110,-30},{110,-20},{0,-20},{0,-30}},
                                                                                                                     color={191,0,0}));
  connect(thermTankHeating1.T, stateController.T_mt) annotation (Line(points={{-11,-34},{-102,-34},{-102,9}}, color={0,0,127}));
  connect(heating.port, thermTankHeating1.port_heating) annotation (Line(points={{130,-20},{0,-20},{0,-30}},
                                                                                                         color={191,0,0}));
  connect(hall.port, thermalCollector.port_b) annotation (Line(points={{130,-90},{100,-90}}, color={191,0,0}));
  connect(stateController.new_batch, batch.new_batch) annotation (Line(points={{-91,14},{-68,14},{-68,-90},{-12,-90}}, color={255,0,255}));
  connect(thermTankHeating1.port_batch, batch.port_tank) annotation (Line(points={{0,-50},{1.77636e-15,-80}}, color={191,0,0}));
  connect(hot_batches.port_hall, thermalCollector.port_a[2])
    annotation (Line(points={{10,-130},{80,-130},{80,-90},{80,-90}},   color={191,0,0}));
  connect(hot_batches.new_batch, batch.new_batch) annotation (Line(points={{-11,-130},{-68,-130},{-68,-90},{-12,-90}}, color={255,0,255}));
  connect(elBaseLoad.y, P_el.u[5]) annotation (Line(points={{11,144},{42,144},{42,70.64},{54,70.64}}, color={0,0,127}));
  connect(units_waste_heat.state, stateController.state) annotation (Line(points={{-11,0},{-60,0},{-60,20},{-91,20}}, color={255,127,0}));
  connect(units_waste_heat.port_hall, thermalCollector.port_a[3])
    annotation (Line(points={{10,0},{80.6667,0},{80.6667,-90}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
                                                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-160},{160,160}})));
end EiB_CleaningMachine1Tank_thermal_Mafac;
