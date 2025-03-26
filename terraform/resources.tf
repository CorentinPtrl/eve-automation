resource "eveng_lab" "automation" {
  name = "Etat de art"
}

resource "eveng_network" "bridged" {
  for_each  = local.cloud
  lab_path = eveng_lab.automation.path
  top      = each.value.top
  left     = each.value.left
  name     = each.key
  icon     = "01-Cloud-Default.svg"
  type     = each.value.type
}

resource "eveng_node" "routers" {
  for_each  = local.routers
  lab_path  = eveng_lab.automation.path
  name      = each.key
  top       = each.value.top
  left      = each.value.left
  template  = "vios"
  config   = templatefile("${path.module}/templates/startup_config.tftpl", {
    hostname = each.value.hostname
    ip = each.value.ip
  })  type      = "qemu"
  ethernet  = 6
}

resource "eveng_node" "switchs" {
  for_each = local.switchs
  lab_path = eveng_lab.automation.path
  name     = each.key
  top      = each.value.top
  left     = each.value.left
  template = "viosl2"
  config   = templatefile("${path.module}/templates/startup_config.tftpl", {
    hostname = each.value.hostname
    ip = each.value.ip
  })
  type     = "qemu"
  ethernet = 12
}

locals {
  all_nodes = merge(
    { for k, v in eveng_node.routers : k => v.id },
    { for k, v in eveng_node.switchs : k => v.id },
    { for k, v in eveng_network.bridged : k => v.id },
  )
}

# Connexions entre nodes
resource "eveng_node_link" "connections_nodes" {
  for_each       = { for idx, conn in local.connections : idx => conn if !contains(keys(local.cloud), conn.target) }
  lab_path       = eveng_lab.automation.path
  source_node_id = local.all_nodes[each.value.source]
  source_port    = each.value.source_port
  target_node_id = local.all_nodes[each.value.target]
  target_port    = each.value.target_port
}

# Connexions vers Cloud
resource "eveng_node_link" "connections_network" {
  for_each       = { for idx, conn in local.connections : idx => conn if contains(keys(local.cloud), conn.target) }
  lab_path       = eveng_lab.automation.path
  source_node_id = local.all_nodes[each.value.source]
  source_port    = each.value.source_port
  network_id     = local.all_nodes[each.value.target]
}

resource "eveng_start_nodes" "start" {
  lab_path   = eveng_lab.automation.path
  depends_on = [eveng_node_link.connections_nodes, eveng_node_link.connections_network]
}

