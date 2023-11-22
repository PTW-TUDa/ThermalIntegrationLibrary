within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration;
record TechnicalConfiguration_a
  extends BaseClasses.TechnicalConfiguration_base(
  m_batch = 50,
  c_batch = 0.477,
  T_heat = 363.15,
  T_req = 343.15,
  T_lim = 341.15,
  m_t1 = 540,
  A_t1 = 2.49138,
  m_t2 = 280,
  A_t2 = 1.7444,
  c_fluid = 4.19,
  A_tt = 0.551,
  d_ins = 0.21,
  lambda_ins = 0.04);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end TechnicalConfiguration_a;
