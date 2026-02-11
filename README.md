### Demo for setting up Azure Virtual Desktop with Terraform

This repository includes the Terraform configuration for setting up a demo for Azure Virtual Desktop consisting of two separate sets of
- AVD host pools (each consisting of two VMs with NIC and disk, registered with the host pools and joined with the subscription's Entra ID tenant)
- AVD workspaces
- AVD application groups

All resources are created in the same resource group, and the VMs share the same VNet and subnet.

Both host pools are set up with type "Pooled".

One of the application groups (avd-dt-appgroup) is set up with type "Desktop". It automatically comes with one "SessionDesktop" application for full desktop access. The application group is assigned to the workspace avd-dt-workspace with friendly name "Desktops".

The other application group (avd-apps-appgroup) is set up with type "RemoteApp" granting its assigned users restricted access to dedicated applications. For the purpose of this demo, the Terraform configuration automatically creates an application for the Edge browser on the target machines and assigns it to the application group. The application group is assigned to the workspace avd-apps-workspace with friendly name "Applications".

This set-up with separate host pools serving the two application groups allows assigning the same user to both application groups offering both options for the same user (full desktop access on the VMs of the avd-dt-hostpool host pool and restricted access to the Edge browser on the VMs of the avd-apps-hostpool host pool):

<img width="567" height="578" alt="image" src="https://github.com/user-attachments/assets/be99c9bd-f165-4f5f-9578-04f35a47de88" />

<img width="513" height="493" alt="image" src="https://github.com/user-attachments/assets/ada7b484-ca1a-4c45-b3d6-a22a2ea20dbd" />

Here is the full list of all Azure resources created by this configuration:

<img width="514" height="716" alt="image" src="https://github.com/user-attachments/assets/81ed3b1d-ce43-42b8-8ef3-d54d220d3298" />

In order to reduce code duplication, the configuration defines an "avd" module consisting of the configuration of a host pool, workspace, application group, VMs, VM extensions, NICs, disks and their mutual associations. The root module consists of two instances of the avd module ("avd_dt" and "avd_apps") and the configurations of the resource group and the required network resources (VNet, subnet, NSG and their associations) and the "edge" AVD application.
