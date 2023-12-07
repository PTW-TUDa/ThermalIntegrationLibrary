within ThermalIntegrationLib.Examples.Records;
record ETA_TechnicalConfiguration_AnnealingOven
  extends ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base(
  t_door=0.1,
  use_heating_heat_recovery=true,
  use_quenching_heat_recovery=true,
  T_init_door=323.15,
  T_init_wall=323.15,
  T_init_workpiece=293.15,
  T_init_retort=373.15,
  T_init_air=373.15,
  T_target_heating_heat_recovery=353.15,
  T_target_quenching_heat_recovery=353.15,
  T_target_gasketcooling=313.15,
  eta_f=0.9,
  P_th_nom_heating=100000,
  P_el_nom_quenching=7500,
  m_flow_nom_quenching=5.5,
  P_th_nom_gasket_cooling=15000,
  rho_wall=2000,
  lambda_wall=1,
  cp_wall=1000,
  t_wall=0.1,
  A_wall=45,
  rho_door=2000,
  lambda_door=1,
  cp_door=1000,
  A_door=3,
  m_retort=200,
  cp_retort=500,
  v_air=1,
  m_workpiece=50,
  cp_workpiece=500,
  m_workpiece_carrier=50,
  cp_workpiece_carrier=500,
  alpha_forced=250);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Values are taken from [3] and [4].</p>
</html>"));
end ETA_TechnicalConfiguration_AnnealingOven;
