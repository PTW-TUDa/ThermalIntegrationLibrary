within ThermalIntegrationLib.Examples.Records;
record ETA_TechnicalConfiguration_CabinetCleaningMachine
 extends ProductionEquipment.CleaningMachines.CabinetCleaningMachine.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base(
    m_batch=150,
    c_batch=0.477,
    m_rack=50,
    c_rack=0.477,
    P_heat=22700,
    eta_heat=0.98,
    T_req=339.45,
    T_lim=337.45,
    m_t1=600,
    A_t1=2.49138,
    c_fluid=4186,
    d_ins=0,
    lambda_ins=0.04);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ETA_TechnicalConfiguration_CabinetCleaningMachine;
