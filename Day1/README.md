# Day 1

## Hypervisor Overview
<pre>
- is nothing virtualization technology
- virtualization allows us to run multiple OS in the same machine simulataneously
- i.e many OS can run in parallel
- Processor with 
  - Intel Processor
    - Virtualization Feature supported is VT-X
  - AMD Processor
    - Virtualization Feature supported is AMD-V
- In BIOS, we need to ensure Virtualization is Enabled
- There are two types of Hypervisors
  1. Type 1 aka Bare Metal Hypervisor
     - doesn't require OS to install Type 1 Hypervisor
     - used in Servers and Workstations only
     - examples
       - KVM 
       - VMWare ESXi, VMWare vSphere
  2. Type 2
     - used in laptops/desktops/workstations
     - Type 2 Hypervisors are installed on top of Host OS ( Windows, Linux, Mac )
     - examples
       - VMWare Workstation ( Linux & Windows )
       - VMWare Fusion ( Mac OS-X )
       - Oracle VirtualBox ( Mac, Linux & Windows )
       - Parallels ( Mac OS-X )
       - Hyper-V ( Windows )
</pre>

## Hypervisor High Level Architecture

## Container Runtime Overview

## Container Engine Overview

# Docker Overview

## Docker High Level Architecture

