within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac;
model EiB_CleaningMachine2Tanks_thermal_Mafac
  extends ThermalIntegrationLib.ProductionEquipment.BaseClasses.BaseProductionEquipment(
    electricDemands=1,
    ID=1,
    coolDemands=0,
    m=1300,
    cp=0.5,
    TInitial=298.15,
    heatDemands=2,
    tableOperationMode=[0,3; 12600,3; 12600,2; 15300,2; 15300,3; 27900,3; 27900,2; 28800,2; 28800,3; 41400,3; 41400,2; 44100,2; 44100,3; 56700,
        3; 56700,2; 57600,2; 57600,3; 70200,3; 70200,2; 72900,2; 72900,3; 85500,3; 85500,1; 86400,1],
    operationModes=3);
    parameter Integer tableProcessingProgramm[:,2]=[16,15; 5,30; 6,60; 7,60; 12,10; 11,15; 8,60; 11,15; 14,60; 13,90; 17,15; 2,60]
                              "Washing programm (washing mode = first column, duration in s = second column)";
    parameter Modelica.SIunits.Temperature T_heat=363.15 "Temperature level of (potential) heat network" annotation(Dialog(group = "Heating"));
    replaceable parameter
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac.TechnicalConfiguration.TechnicalConfiguration_a
    TechnicalConfiguration constrainedby
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base
    "Record which defines technical/physical parameters";
  ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac.TankHeating.thermTankHeating1 thermTankHeating1(
    m_t1=TechnicalConfiguration.m_t1,
    A_t1=TechnicalConfiguration.A_t1,
    c_fluid=TechnicalConfiguration.c_fluid,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  TankHeating.thermTankHeating2 thermTankHeating2(
    m_t2=TechnicalConfiguration.m_t2,
    A_t2=TechnicalConfiguration.A_t2,
    c_fluid=TechnicalConfiguration.c_fluid,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins)
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  ProcessingProgramms.stateController stateController(
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,               stateTable=tableProcessingProgramm)
    annotation (Placement(transformation(extent={{-112,10},{-92,30}})));
  MechanicalProcesses.mech_processes mech_processes annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  MechanicalProcesses.ah ah annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  MechanicalProcesses.scc scc annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Math.MultiSum P_el(nu=5) annotation (Placement(transformation(extent={{54,68},{66,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=4)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-80})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_hall
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-110})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_heating
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={116,-30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1(m=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={96,-10})));
  MechanicalProcesses.oil_separator oil_separator(pct=TechnicalConfiguration.pct_oil_sep)
                                                  annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=94.76658477) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-56})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector2(m=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-104})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Batches.hot_batches hot_batches(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack,
    T_req=TechnicalConfiguration.T_req)
                                  annotation (Placement(transformation(extent={{52,-150},{72,-130}})));
  Batches.batch batch(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack)
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-128})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature hall(T=298.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,-80})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature heating(T=T_heat)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,-10})));
  Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{-10,138},{10,158}})));
  MechanicalProcesses.units_waste_heat units_waste_heat(Q_wasteheat=TechnicalConfiguration.Q_waste_heat)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
equation
  electricDemand[1].Power[1] = P_el.y;
  electricDemand[1].Power[2] = P_el.y;
  electricDemand[1].Power[3] = P_el.y;

// Heat demand represents heat influx from central heating system
  heatDemand[1].Q_flow[1] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[1] =T_heating.T;
  heatDemand[1].T_out[1] = thermTankHeating1.T;

  heatDemand[1].Q_flow[2] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[2] = T_heating.T;
  heatDemand[1].T_out[2] = thermTankHeating1.T;

  heatDemand[1].Q_flow[3] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[3] = T_heating.T;
  heatDemand[1].T_out[3] = thermTankHeating1.T;

  heatDemand[2].Q_flow[1] = thermTankHeating2.port_heating.Q_flow;
  heatDemand[2].T_in[1] = T_heating.T;
  heatDemand[2].T_out[1] = thermTankHeating2.T;

  heatDemand[2].Q_flow[2] = thermTankHeating2.port_heating.Q_flow;
  heatDemand[2].T_in[2] = T_heating.T;
  heatDemand[2].T_out[2] = thermTankHeating2.T;

  heatDemand[2].Q_flow[3] = thermTankHeating2.port_heating.Q_flow;
  heatDemand[2].T_in[3] = T_heating.T;
  heatDemand[2].T_out[3] = thermTankHeating2.T;

  dissipationFlowRate = hall.port.Q_flow;
  connect(thermTankHeating2.state, stateController.state)
    annotation (Line(points={{28,-80},{-60,-80},{-60,20},{-91,20}},      color={255,127,0}));
  connect(thermTankHeating1.state, stateController.state)
    annotation (Line(points={{-12,-30},{-60,-30},{-60,20},{-91,20}},      color={255,127,0}));
  connect(mech_processes.state, stateController.state)
    annotation (Line(points={{-11,130},{-60,130},{-60,20},{-91,20}},    color={255,127,0}));
  connect(ah.state, stateController.state) annotation (Line(points={{-11,100},{-60,100},{-60,20},{-91,20}},  color={255,127,0}));
  connect(scc.state, stateController.state) annotation (Line(points={{-11,70},{-60,70},{-60,20},{-91,20}},    color={255,127,0}));
  connect(T_hall.port, thermalCollector.port_b) annotation (Line(points={{110,-100},{110,-80},{100,-80}}, color={191,0,0}));
  connect(thermTankHeating1.port_hall, thermalCollector.port_a[1])
    annotation (Line(points={{10,-30},{79.25,-30},{79.25,-80}},
                                                              color={191,0,0}));
  connect(thermTankHeating2.port_hall, thermalCollector.port_a[2])
    annotation (Line(points={{50,-80},{79.75,-80}},color={191,0,0}));
  connect(thermTankHeating1.port_heating, thermalCollector1.port_a[1])
    annotation (Line(points={{0,-20},{0,-10},{85.5,-10}},
                                                      color={191,0,0}));
  connect(thermTankHeating2.port_heating, thermalCollector1.port_a[2])
    annotation (Line(points={{40,-70},{40,-10},{86.5,-10}},
                                                        color={191,0,0}));
  connect(oil_separator.state, stateController.state)
    annotation (Line(points={{-11,45},{-60,45},{-60,20},{-91,20}},      color={255,127,0}));
  connect(mech_processes.P_el, P_el.u[1]) annotation (Line(points={{11,130},{40,130},{40,77.36},{54,77.36}}, color={0,0,127}));
  connect(ah.P_el, P_el.u[2]) annotation (Line(points={{11,100},{40,100},{40,75.68},{54,75.68}},
                                                                                               color={0,0,127}));
  connect(scc.P_el, P_el.u[3]) annotation (Line(points={{11,70},{40,70},{40,74},{54,74}},       color={0,0,127}));
  connect(oil_separator.P_el, P_el.u[4]) annotation (Line(points={{11,40},{40,40},{40,72.32},{54,72.32}}, color={0,0,127}));
  connect(thermTankHeating1.port_tank, thermalConductor.port_a)
    annotation (Line(points={{10,-36},{60,-36},{60,-46}}, color={191,0,0}));
  connect(thermalConductor.port_b, thermTankHeating2.port_tank)
    annotation (Line(points={{60,-66},{60,-86},{50,-86}}, color={191,0,0}));
  connect(thermTankHeating1.port_batch, thermalCollector2.port_a[1]) annotation (Line(points={{0,-40},{0,-93.5}}, color={191,0,0}));
  connect(thermTankHeating2.port_batch, thermalCollector2.port_a[2])
    annotation (Line(points={{40,-90},{40,-94},{0,-94},{0,-94.5}}, color={191,0,0}));
  connect(stateController.opMode, integerExpression.y) annotation (Line(points={{-113,20},{-119,20}}, color={255,127,0}));
  connect(hot_batches.port_hall, thermalCollector.port_a[3])
    annotation (Line(points={{72,-140},{80.25,-140},{80.25,-80}},     color={191,0,0}));
  connect(thermalCollector2.port_b, batch.port_tank) annotation (Line(points={{0,-114},{1.77636e-15,-118}}, color={191,0,0}));
  connect(stateController.new_batch, batch.new_batch)
    annotation (Line(points={{-91,14},{-80,14},{-80,-128},{-12,-128}}, color={255,0,255}));
  connect(hot_batches.new_batch, batch.new_batch)
    annotation (Line(points={{51,-140},{-80,-140},{-80,-128},{-12,-128}}, color={255,0,255}));
  connect(stateController.processTime, oil_separator.processTime) annotation (Line(points={{-91,26},{-51,26},{-51,35},{-11,35}},
                                                                                                               color={0,0,127}));
  connect(T_heating.port, thermalCollector1.port_b)
    annotation (Line(points={{116,-20},{116,-10},{106,-10}},                  color={191,0,0}));
  connect(heating.port, thermalCollector1.port_b)
    annotation (Line(points={{130,-10},{106,-10}},                                  color={191,0,0}));
  connect(hall.port, thermalCollector.port_b) annotation (Line(points={{130,-80},{100,-80}}, color={191,0,0}));
  connect(thermTankHeating1.T, stateController.T_mt1) annotation (Line(points={{-11,-24},{-98,-24},{-98,9}}, color={0,0,127}));
  connect(thermTankHeating2.T, stateController.T_mt2) annotation (Line(points={{29,-74},{-106,-74},{-106,9}}, color={0,0,127}));
  connect(elBaseLoad.y, P_el.u[5]) annotation (Line(points={{11,148},{42,148},{42,70.64},{54,70.64}}, color={0,0,127}));
  connect(units_waste_heat.state, stateController.state)
    annotation (Line(points={{-11,10},{-60,10},{-60,20},{-91,20}}, color={255,127,0}));
  connect(units_waste_heat.port_hall, thermalCollector.port_a[4])
    annotation (Line(points={{10,10},{80,10},{80,-76},{80.75,-76},{80.75,-80}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
                                                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-160},{160,160}})));
end EiB_CleaningMachine2Tanks_thermal_Mafac;
