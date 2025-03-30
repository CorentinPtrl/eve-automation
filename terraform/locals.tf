locals {
  routers = {
    FR_TLS_R1 = { top = 50, left = 420, hostname = "hostname FR_TLS_R1", ip = "192.168.100.45" }
    FR_TLS_CORE1 = { top = 145, left = 340, hostname = "hostname FR_TLS_CORE1", ip = "192.168.100.46" }
    FR_TLS_CORE2 = { top = 145, left = 510, hostname = "hostname FR_TLS_CORE2", ip = "192.168.100.47" }
    EN_FLT_R1 = { top = 50, left = 730, hostname = "hostname EN_FLT_R1", ip = "192.168.100.48" }
  }
  switchs = {
    FR_TLS_DIST1 = { top = 310, left = 340, hostname = "hostname FR_TLS_DIST1", ip = "192.168.100.40" }
    FR_TLS_DIST2 = { top = 310, left = 510, hostname = "hostname FR_TLS_DIST2", ip = "192.168.100.41" }
    FR_TLS_ACC = { top = 440, left = 420, hostname = "hostname FR_TLS_ACC", ip = "192.168.100.42" }
    EN_FLT_SW1 = { top = 220, left = 730, hostname = "hostname EN_FLT_SW1", ip = "192.168.100.43" }
  }
  cloud = {
    OOB = { top = 30, left = 30, type = "pnet0" }
    EN_FLT_SRV-DHCP = { top = 330, left = 660, type = "pnet1" }
  }
  connections = [
    { source = "FR_TLS_R1", source_port = "Gi0/0", target = "EN_FLT_R1", target_port = "Gi0/0" },
    { source = "FR_TLS_R1", source_port = "Gi0/1", target = "FR_TLS_CORE1", target_port = "Gi0/0" },
    { source = "FR_TLS_R1", source_port = "Gi0/3", target = "FR_TLS_CORE2", target_port = "Gi0/0" },
    { source = "FR_TLS_CORE1", source_port = "Gi0/1", target = "FR_TLS_DIST1", target_port = "Gi0/0" },
    { source = "FR_TLS_CORE2", source_port = "Gi0/1", target = "FR_TLS_DIST2", target_port = "Gi0/0" },
    { source = "EN_FLT_R1", source_port = "Gi0/1", target = "EN_FLT_SW1", target_port = "Gi0/0" },
    { source = "FR_TLS_DIST1", source_port = "Gi0/1", target = "FR_TLS_ACC", target_port = "Gi0/0" },
    { source = "FR_TLS_DIST2", source_port = "Gi0/1", target = "FR_TLS_ACC", target_port = "Gi0/1" },
    { source = "EN_FLT_SW1", source_port = "Gi0/1", target = "EN_FLT_SRV-DHCP", target_port = "eth0"},
    { source = "FR_TLS_R1", source_port = "Gi0/2", target = "OOB"},
    { source = "FR_TLS_CORE1", source_port = "Gi0/2", target = "OOB"},
    { source = "FR_TLS_CORE2", source_port = "Gi0/2", target = "OOB"},
    { source = "EN_FLT_R1", source_port = "Gi0/2", target = "OOB"},
    { source = "FR_TLS_DIST1", source_port = "Gi0/2", target = "OOB"},
    { source = "FR_TLS_DIST2", source_port = "Gi0/2", target = "OOB"},
    { source = "FR_TLS_ACC", source_port = "Gi0/2", target = "OOB"},
    { source = "EN_FLT_SW1", source_port = "Gi0/2", target = "OOB"}
  ]
}
