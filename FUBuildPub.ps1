# 设置 mkdocs 命令路径和项目目录
# $mkdocsPath = "C:\path\to\mkdocs.exe"  # 如果在系统路径中，你可以省略这一行
$projectPath = "D:\Code\FURobotDocument\furobotGH_Doc"
$venvPath="D:\Code\FURobotDocument\venvDoc"

# 激活虚拟环境
. "$venvPath\Scripts\Activate.ps1"

# 切换到项目目录
Set-Location -Path $projectPath


# 修改mkdocs.yml文件

# 定义文件名
$mkdocsfileName = "mkdocs.yml"
$mkdocsPath = Join-Path -Path $projectPath -ChildPath $mkdocsfileName

# $mkdocsPath = "D:\Code\FURobotDocument\furobotGH_Doc\mkdocs.yml"
$fileContent = Get-Content -Path $mkdocsPath -Encoding UTF8
# 检查文件是否有至少两行
if ($fileContent.Count -ge 2) {
    # 更新第二行的内容为您想要的字符串
    $fileContent[1] = "site_url: `"http://furobotdoc.fabunion.com/`""
    
    # 将更新后的内容写回文件
    $fileContent | Set-Content -Path $mkdocsPath -Encoding UTF8
    Write-Host "2nd line has updated."
} 
else {
    Write-Host "Less than 2 lines"
}

# 修改完毕

# Read-Host "Finished modify mkdocs.yml"




# 设置要删除的路径
$enPath = "D:\Code\FURobotDocument\furobotGH_Doc\docs\en"
$zhPath = "D:\Code\FURobotDocument\furobotGH_Doc\docs\zh"
# 删除路径下的所有文件和文件夹
# 检查文件夹是否存在
if (Test-Path -Path $enPath -PathType Container) {
    # 删除文件夹及其所有内容
    Remove-Item -Path $enPath -Recurse -Force
    Write-Host "en folder deleted"
} else {
    Write-Host "en folder non exist"
}

New-Item -Path $enPath -ItemType Directory



# 复制zh文件夹下的所有内容到en文件夹
Copy-Item -Path $zhPath\* -Destination $enPath -Recurse -Force

# 提示用户输入，等待用户输入 "y" 或 "n"
$response = Read-Host "Do translation? (y/n)"

if ($response -eq "n") {
    Write-Host "No translation"

} else {
    Write-Host "Translating ..."
    python D:\Code\Python\TranslateDoc\main.py
    # 在这里添加你要执行的指令
} 

Write-Host "Begin to build:"
# 运行 mkdocs build 命令
& mkdocs build


# 设置要删除文件的文件夹路径
$destinationFolderPath = "D:\Code\OpenSource\FURobotDoc\FURobotDoc"
$sourceFolderPath = "D:\Code\FURobotDocument\furobotGH_Doc\site"
$StartPath="D:\Code\FURobotDocument\furobotGH_Doc"
# 获取文件夹下的所有文件，排除隐藏文件夹及其内部的文件
$filesToDelete = Get-ChildItem -Path $destinationFolderPath -File -Recurse | Where-Object { -not $_.PSIsContainer -or (-not $_.Attributes.HasFlag([System.IO.FileAttributes]::Hidden)) }

# 删除每个文件
foreach ($file in $filesToDelete) {
    Remove-Item -Path $file.FullName -Force
}

# 删除空文件夹
Get-ChildItem -Path $destinationFolderPath -Directory -Recurse | Where-Object { $_.GetFiles().Count -eq 0 } | ForEach-Object {
    Remove-Item -Path $_.FullName -Force -Recurse
}

# 复制源文件夹下的所有内容到目标文件夹
Copy-Item -Path $sourceFolderPath\* -Destination $destinationFolderPath -Recurse -Force



# 输出推送成功的消息
Write-Host "Finished"

deactivate

Set-Location -Path $StartPath
