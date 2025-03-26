locals {
  routers = {
    R1 = { top = 50, left = 420, hostname = "hostname R1", ip = "192.168.100.45" }
    R2 = { top = 145, left = 340, hostname = "hostname R2", ip = "192.168.100.46" }
    R3 = { top = 145, left = 510, hostname = "hostname R3", ip = "192.168.100.47" }
    R4 = { top = 50, left = 730, hostname = "hostname R4", ip = "192.168.100.48" }
  }

  switchs = {
    SW1 = { top = 310, left = 340, hostname = "hostname SW1", ip = "192.168.100.40" }
    SW2 = { top = 310, left = 510, hostname = "hostname SW2", ip = "192.168.100.41" }
    SW3 = { top = 440, left = 420, hostname = "hostname SW3", ip = "192.168.100.42" }
    SW4 = { top = 220, left = 730, hostname = "hostname SW4", ip = "192.168.100.43" }
    OOB = { top = 120, left = 120, hostname = "hostname OOB", ip = "192.168.100.44" }

  }

  cloud = {
    EXT-NET = { top = 30, left = 30, type = "pnet0" }
    DHCP = { top = 330, left = 660, type = "pnet1" }
  }


  connections = [
    { source = "R1", source_port = "Gi0/0", target = "R4", target_port = "Gi0/0" },
    { source = "R1", source_port = "Gi0/1", target = "R2", target_port = "Gi0/0" },
    { source = "R1", source_port = "Gi0/3", target = "R3", target_port = "Gi0/0" },
    { source = "R2", source_port = "Gi0/1", target = "SW1", target_port = "Gi0/0" },
    { source = "R3", source_port = "Gi0/1", target = "SW2", target_port = "Gi0/0" },
    { source = "R4", source_port = "Gi0/1", target = "SW4", target_port = "Gi0/0" },
    { source = "SW1", source_port = "Gi0/1", target = "SW3", target_port = "Gi0/0" },
    { source = "SW2", source_port = "Gi0/1", target = "SW3", target_port = "Gi0/1" },
    { source = "SW4", source_port = "Gi0/1", target = "DHCP", target_port = "eth0" },
    { source = "OOB", source_port = "Gi0/0", target = "R1", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi0/1", target = "R2", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi0/2", target = "R3", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi0/3", target = "R4", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi1/0", target = "SW1", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi1/1", target = "SW2", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi1/2", target = "SW3", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi1/3", target = "SW4", target_port = "Gi0/2" },
    { source = "OOB", source_port = "Gi2/0", target = "EXT-NET", target_port = "eth0" }
  ]
}
