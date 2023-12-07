within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.CabinetCleaningMachine;
model CabinetCleaningMachine
  extends ThermalIntegrationLib.BaseClasses.BaseProductionEquipment(
    electricDemands=1,
    ID=1,
    coolDemands=0,
    m=1300,
    cp=0.5,
    TInitial=298.15,
    heatDemands=1,
    tableOperationMode=[0,3; 28800,3],
    operationModes=3);
    parameter Integer tableProcessingProgramm[:,2]=[6,15; 3,80; 4,120; 5,320; 7,15]
                              "Washing programm (washing mode = first column, duration in s = second column)";
  parameter Modelica.Units.SI.Temperature T_heat=363.15 "Temperature level of (potential) heat network" annotation (Dialog(group="Heating"));
    parameter Real tableStates[:,2]=[1,0; 2,0; 3,5500; 4,1780; 5,1100; 6,0; 7,0]
                                                                         "State power definition for mechanical processes, heating power excluded (washing mode = first column, el. Power [W] = second column)";
    parameter Integer tableWashing[:,1]=[3] "States when washing is active";
  replaceable parameter ThermalIntegrationLib.Examples.Records.ETA_TechnicalConfiguration_CabinetCleaningMachine TechnicalConfiguration constrainedby ThermalIntegrationLib.ProductionEquipment.CleaningMachines.CabinetCleaningMachine.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base  annotation (choicesAllMatching=true);
  Modelica.Blocks.Math.MultiSum P_el(nu=2) annotation (Placement(transformation(extent={{56,94},{68,106}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=2)
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
        origin={110,-30})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature hall(T=298.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,-80})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature heating(T=T_heat)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,0})));
  Batches.batch batch(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-80})));
  Batches.hot_batches hot_batches(
    m_batch=TechnicalConfiguration.m_batch,
    c_batch=TechnicalConfiguration.c_batch,
    m_rack=TechnicalConfiguration.m_rack,
    c_rack=TechnicalConfiguration.c_rack,
    T_req=TechnicalConfiguration.T_req) annotation (Placement(transformation(extent={{-10,-140},{10,-120}})));
  Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  MechanicalProcesses.mech_processes mech_processes1 annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  ProcessingProgramms.stateController stateController(T_req=TechnicalConfiguration.T_req, T_lim=TechnicalConfiguration.T_lim)
                                                      annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  TankHeating.thermTankHeating1 thermTankHeating1(
    m_t1=TechnicalConfiguration.m_t1,
    A_t1=TechnicalConfiguration.A_t1,
    c_fluid=TechnicalConfiguration.c_fluid,
    d_ins=TechnicalConfiguration.d_ins,
    lambda_ins=TechnicalConfiguration.lambda_ins,
    T_req=TechnicalConfiguration.T_req,
    T_lim=TechnicalConfiguration.T_lim,
    tableWashing=tableWashing) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
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
  connect(T_hall.port, thermalCollector.port_b) annotation (Line(points={{110,-100},{110,-80},{100,-80}}, color={191,0,0}));
  connect(hall.port, thermalCollector.port_b) annotation (Line(points={{130,-80},{100,-80}}, color={191,0,0}));
  connect(hot_batches.port_hall, thermalCollector.port_a[2])
    annotation (Line(points={{10,-130},{80,-130},{80,-80},{79.75,-80}},color={191,0,0}));
  connect(integerExpression.y, stateController.opMode) annotation (Line(points={{-119,20},{-101,20}}, color={255,127,0}));
  connect(stateController.state, mech_processes1.state) annotation (Line(points={{-79,25},{-40,25},{-40,70},{-11,70}}, color={255,127,0}));
  connect(thermTankHeating1.port_heating, heating.port)
    annotation (Line(points={{0,-20},{0,0},{122,0},{122,1.33227e-15},{130,1.33227e-15}}, color={191,0,0}));
  connect(thermTankHeating1.port_heating, T_heating.port) annotation (Line(points={{0,-20},{0,0},{110,0},{110,-20}}, color={191,0,0}));
  connect(stateController.new_batch, hot_batches.new_batch)
    annotation (Line(points={{-79,15},{-60,15},{-60,-130},{-11,-130}}, color={255,0,255}));
  connect(thermTankHeating1.port_hall, thermalCollector.port_a[1])
    annotation (Line(points={{10,-30},{80,-30},{80,-80},{80.25,-80}},color={191,0,0}));
  connect(thermTankHeating1.port_batch, batch.port_tank) annotation (Line(points={{0,-40},{1.77636e-15,-70}}, color={191,0,0}));
  connect(thermTankHeating1.state, stateController.state)
    annotation (Line(points={{-12,-30},{-40,-30},{-40,25},{-79,25}}, color={255,127,0}));
  connect(thermTankHeating1.T, stateController.T_mt) annotation (Line(points={{-11,-24},{-90,-24},{-90,9}}, color={0,0,127}));
  connect(elBaseLoad.y, P_el.u[1]) annotation (Line(points={{11,130},{50,130},{50,98.95},{56,98.95}}, color={0,0,127}));
  connect(P_el.u[2], mech_processes1.P_el) annotation (Line(points={{56,101.05},{50,101.05},{50,70},{11,70}},
                                                                                                          color={0,0,127}));
  connect(batch.new_batch, hot_batches.new_batch) annotation (Line(points={{-12,-80},{-60,-80},{-60,-130},{-11,-130}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
                                                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-160},{160,160}})));
end CabinetCleaningMachine;
