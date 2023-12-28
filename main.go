package main

import (
	"fmt"
	"os"
	"os/exec"
	"runtime"
)

var version string

func main() {
	fmt.Printf("OS Detected: %s\n", runtime.GOOS)
	fmt.Printf("Agent Version: %s\n", version)
	var cmd *exec.Cmd

	switch runtime.GOOS {
	case "windows":
		cmd = exec.Command("powershell", "Get-ItemProperty HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\* | Select-Object DisplayName, DisplayVersion")
	case "darwin":
		cmd = exec.Command("system_profiler", "SPApplicationsDataType")
	case "linux":
		cmd = getPackageManagerCommand()
	default:
		fmt.Printf("OS is not supported: %s\n", runtime.GOOS)
		return
	}

	output, err := cmd.Output()
	if err != nil {
		fmt.Println("Error when run cmd:", err)
		return
	}

	fmt.Println(string(output))
}

func getPackageManagerCommand() *exec.Cmd {
	// Kiểm tra sự tồn tại của các file đặc trưng cho bản phân phối
	if _, err := os.Stat("/etc/debian_version"); err == nil {
		// Debian, Ubuntu, và các bản phân phối dựa trên Debian
		return exec.Command("dpkg", "-l")
	} else if _, err := os.Stat("/etc/redhat-release"); err == nil {
		// RHEL, CentOS, Fedora và các bản phân phối dựa trên RHEL/CentOS
		return exec.Command("rpm", "-qa")
	} else if _, err := os.Stat("/etc/arch-release"); err == nil {
		// Arch Linux và các bản phân phối dựa trên Arch
		return exec.Command("pacman", "-Q")
	} else if _, err := os.Stat("/etc/SuSE-release"); err == nil {
		// openSUSE, SUSE Linux Enterprise
		return exec.Command("zypper", "se", "--installed-only")
	} else if _, err := os.Stat("/etc/gentoo-release"); err == nil {
		// Gentoo Linux
		return exec.Command("equery", "list", "*")
	}
	// Thêm các case khác nếu cần
	return nil
}
