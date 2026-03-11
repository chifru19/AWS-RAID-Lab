# AWS Data Center Lab: Containerized RAID 1 Mirroring

## Project Overview
This project demonstrates the configuration of a RAID 1 (Mirror) array using `mdadm` within a privileged Docker environment. This setup simulates server storage redundancy used in AWS Data Centers to ensure high availability.

## Technical Skills Demonstrated
* **Linux Storage Administration:** Proficient use of `mdadm` for array creation and `/proc/mdstat` for health monitoring.
* **Docker Operations:** Deploying privileged containers with `SYS_ADMIN` capabilities to interact with the host kernel.
* **Block Device Emulation:** Creating and binding loopback devices (`losetup`) to simulate physical hard drives.

## Lab Execution
1. Built a custom Ubuntu-based Docker image.
2. Provisioned 100MB virtual disk images.
3. Successfully initialized `md0` as an active RAID 1 mirror.
## Troubleshooting & Lessons Learned

### Issue: `md_mod` Kernel Module Not Found
**Problem:** During initial execution inside the Docker container, `mdadm` failed with a `FATAL` error stating the kernel module `md_mod` was missing. 
**Root Cause:** Standard Docker containers share the host kernel but do not have permission to load kernel modules or access block devices by default.
**Resolution:** 1. Ensured the `raid1` and `md_mod` modules were loaded on the host machine using `sudo modprobe raid1`.
2. Re-deployed the container using the `--privileged` flag and granted `SYS_ADMIN` capabilities.
3. Successfully mapped loopback devices (`/dev/loopX`) from the host to the container to allow `mdadm` to initialize the array.
![RAID Verification](./raid-verification.jpg)
