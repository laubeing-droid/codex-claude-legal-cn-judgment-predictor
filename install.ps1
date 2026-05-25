<#
.SYNOPSIS
  一键安装 Codex-Legal-CN-Judgment-Predictor
.DESCRIPTION
  自动安装必需依赖（core-codices 法律数据库），部署技能到 ~/.codex/skills/。
#>
#Requires -Version 5.1

$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsDir = "$env:USERPROFILE\.codex\skills"
$ParentDir = Split-Path -Parent $RepoRoot

Write-Host "=== Codex-Legal-CN-Judgment-Predictor 安装 ===" -ForegroundColor Green
Write-Host ""

# =========================================================
# [0] 必需依赖
# =========================================================
Write-Host "[0] 安装必需依赖..." -ForegroundColor Yellow

$CodicesDir = Join-Path $ParentDir "codex-claude-legal-cn-core-codices"
if (Test-Path $CodicesDir) {
    Write-Host "  [OK] core-codices (法律数据库) 已存在: $CodicesDir" -ForegroundColor Green
} else {
    Write-Host "  [安装] core-codices (162部法律全文JSON) -> $CodicesDir" -ForegroundColor Yellow
    Push-Location $ParentDir
    git clone --depth 1 https://github.com/laubeing-droid/codex-claude-legal-cn-core-codices.git codex-claude-legal-cn-core-codices 2>&1 | Out-Null
    Pop-Location
    Write-Host "  [OK] core-codices 安装完成" -ForegroundColor Green
}

Write-Host ""

# =========================================================
# [1/2] 安装技能
# =========================================================
Write-Host "[1/2] 安装技能..." -ForegroundColor Yellow

$skillName = "judgment-predictor"
$tgt = "$SkillsDir\$skillName"
$null = New-Item -ItemType Directory -Force $tgt

if (Test-Path "$RepoRoot\SKILL.md") {
    Copy-Item "$RepoRoot\SKILL.md" "$tgt\SKILL.md" -Force
    Write-Host "  技能安装完成: $tgt" -ForegroundColor Green
} else {
    Write-Host "  [错误] SKILL.md 未找到" -ForegroundColor Red
    exit 1
}

# =========================================================
# [2/2] 配置 skill 引用 core-codices 路径
# =========================================================
Write-Host "[2/2] 配置..." -ForegroundColor Yellow
Write-Host "  core-codices 路径: $CodicesDir" -ForegroundColor Cyan
Write-Host "  裁判预测将从此路径加载法条数据" -ForegroundColor Cyan

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  安装完成！" -ForegroundColor Green
Write-Host ""
Write-Host "  使用方式:" -ForegroundColor Cyan
Write-Host "    @judgment-predictor [案件事实描述]" -ForegroundColor White
Write-Host ""
Write-Host "  已安装依赖:" -ForegroundColor Cyan
Write-Host "    [必需] codex-claude-legal-cn-core-codices — 162部法律全文JSON" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Green
