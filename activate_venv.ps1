# 设置 mkdocs 命令路径和项目目录
# $mkdocsPath = "C:\path\to\mkdocs.exe"  # 如果在系统路径中，你可以省略这一行
$projectPath = "D:\Code\FURobotDocument\furobotGH_Doc"
$venvPath="D:\Code\FURobotDocument\venvDoc"

# 激活虚拟环境
#  . "$venvPath\Scripts\activate"
. "$venvPath\Scripts\Activate.ps1"

# Start-Process powershell

# Invoke-Expression "$venvPath\Scripts\Activate.ps1"


# 切换到项目目录
Set-Location -Path $projectPath
mkdocs serve